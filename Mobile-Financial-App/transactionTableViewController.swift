//
//  transactionTableViewController.swift
//  Mobile-Financial-App
//
//  Created by Jason Wong on 2018-04-01.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase

class transactionTableViewController: UITableViewController {

    // var accuontName : String!
    var accountName = ""
    var dbAccountId = ""
    var dbAccountBalance = ""
    
    var transaction = [Transaction]()
    @IBOutlet var tableViewTransaction: UITableView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return transaction.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cellIdentifier = "TransactionTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as?
            TransactionTableViewCell else {
                fatalError("The dequeued cell is not an instance of TransactionTableViewCell")
        }
        
        let t: Transaction
        t = transaction[indexPath.row]
        
        cell.transactionAmountLabel.text = t.transactionAmountLabel
        cell.transactionBalanceLabel.text = t.transactionBalanceLabel
        cell.transactionDateLabel.text = t.transactionDateLabel
        cell.transactionNameLabel.text = t.transactionNameLabel
        
        var num = t.transactionAmountLabel.replacingOccurrences(of: "$", with: "")
        num = num.replacingOccurrences(of: ",", with: "")
        let amount = Double(num)!
        
        if amount < 0.0 {
            cell.transactionAmountLabel.textColor = UIColor.init(red: 0.75, green: 0.06, blue: 0.22, alpha: 1.0)
        } else {
            cell.transactionAmountLabel.textColor = UIColor.init(red: 0.21, green: 0.54, blue: 0.14, alpha: 1.0)
        }
        return cell

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addTransactionSegue" {
            let atvc = segue.destination as! AddTransactionViewController
            atvc.accountId = dbAccountId
            atvc.accountBalance = dbAccountBalance
        }
    }
    
    // MARK - retrieve accountId based on accountName
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let localAccountName = accountName as String
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current

        let uid = Auth.auth().currentUser!.uid
        let refAccount = Database.database().reference().child("user").child(uid).child("account")
        refAccount.observe(DataEventType.value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0 {
                for record in snapshot.children.allObjects as! [DataSnapshot] {
                    let accountObject = record.value as! [String: AnyObject]
                    let name = accountObject["accountName"]! as! String
                    let accountId = accountObject["accountId"]! as! String
                    let accountBalance = accountObject["accountBalance"]! as! String
                    
                    self.dbAccountId = accountId
                    self.dbAccountBalance = accountBalance

                    if (name == localAccountName) {
                        
                        let refTransaction = refAccount.child(accountId).child("transaction")
                        refTransaction.observe(DataEventType.value, with: { (snapshot) in
                            
                            var transactionItem = Transaction(transactionDateLabel: "", transactionNameLabel: "", transactionAmountLabel: "", transactionBalanceLabel: "")
                            
                            if snapshot.childrenCount > 0 {
                                
                                self.transaction.removeAll()
                                
                                for transactionRecord in snapshot.children.allObjects as! [DataSnapshot] {
                                    let transactionObject = transactionRecord.value as! [String: AnyObject]
                                    
                                    let transactionDate = (transactionObject["date"] as! String)
                                    let transactionName = (transactionObject["name"] as! String)
                                    
                                    let amount = Double(transactionObject["amount"] as! String)
                                    let transactionAmount = currencyFormatter.string(from: NSNumber(value: amount!))!
                                                                        
                                    let balance = Double(transactionObject["balance"] as! String)
                                    let transactionBalance = currencyFormatter.string(from: NSNumber(value: balance!))!
                                    
                                    transactionItem = Transaction(transactionDateLabel: transactionDate, transactionNameLabel: transactionName, transactionAmountLabel: transactionAmount, transactionBalanceLabel: transactionBalance)
                                    
                                    self.transaction.append(transactionItem!)
                                }
                            }
                            self.tableViewTransaction.reloadData()
                        })
                        break
                    }
                }
            }
        })
    }
}
