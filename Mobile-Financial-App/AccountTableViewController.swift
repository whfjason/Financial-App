//
//  AccountTableViewController.swift
//  Mobile-Financial-App
//
//  Created by Jason Wong on 2018-03-31.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase


class AccountTableViewController: UITableViewController {
    
    var selectedAccountName = ""
    var account = [Account]()
    @IBOutlet weak var tableViewAccount: UITableView!
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return account.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "AccountTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AccountTableViewCell else {
            fatalError("The dequeued cell is not an instance of AccountTableViewCell")
        }
        
        let a: Account
        a = account[indexPath.row]
        
        cell.accountNameLabel.text = a.accountNameLabel
        cell.accountTypeLabel.text = a.accountTypeLabel
        cell.accountBalance.text = a.accountBalance

        var num = a.accountBalance.replacingOccurrences(of: "$", with: "")
        num = num.replacingOccurrences(of: ",", with: "")
        let balance = Double(num)!
        
        if balance < 0.0 {
            cell.accountBalance.textColor = UIColor.init(red: 0.75, green: 0.06, blue: 0.22, alpha: 1.0)
        } else {
            cell.accountBalance.textColor = UIColor.init(red: 0.21, green: 0.54, blue: 0.14, alpha: 1.0)
        }
        return cell
    }
    
    // MARK: Perform segue to display transactions for selected account
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cell = tableView.cellForRow(at: indexPath) as! AccountTableViewCell
        
        // TODO: Validation - account name must be unique
    
        selectedAccountName = cell.accountNameLabel.text!
        transactionSegue()
    }
    
    func transactionSegue() {
        self.performSegue(withIdentifier: "transactionRecordSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "transactionRecordSegue" {
            let tvc = segue.destination as! transactionTableViewController
            tvc.accountName = selectedAccountName
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        
        let uid = Auth.auth().currentUser!.uid
        let refAccount = Database.database().reference().child("user").child(uid).child("account")
        
        var accountItem = Account(accountNameLabel: "", accountTypeLabel: "", accountBalance: "")
        
        refAccount.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                
                self.account.removeAll()
                
                for record in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    let accountObject = record.value as! [String: AnyObject]
                    let accountType = (accountObject["accountType"] as! String)
                    let accountName = (accountObject["accountName"] as! String)
                    let balance = Double(accountObject["accountBalance"] as! String)
                    let accountBalance = currencyFormatter.string(from: NSNumber(value: balance!))!
                    
                    accountItem = Account(accountNameLabel: accountName, accountTypeLabel: accountType, accountBalance: accountBalance)
                    
                    self.account.append(accountItem!)
                }
            }
            self.tableViewAccount.reloadData()
        })

    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

}
