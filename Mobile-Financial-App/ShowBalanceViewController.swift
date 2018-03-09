//
//  ShowBalanceViewController.swift
//  Mobile-Financial-App
//
//  Created by Eric Xiao on 2018/3/8.
//  Copyright © 2018年 Eric Xiao. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class ShowBalanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewBalance: UITableView!
    
    var balanceList = [BalanceModel]()
    
   public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return balanceList.count
    }
    
   public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShowBalanceTableViewCell
    
    let balance: BalanceModel
    
    balance = balanceList[indexPath.row]
    
    cell.accountTp.text = balance.fromAccount
    cell.accountBalance.text = balance.amount
    return cell
    
    }
    
    var refBalance: DatabaseReference!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        refBalance = Database.database().reference().child("balance")
        let auth_userId = Auth.auth().currentUser!.uid
        var balance = BalanceModel(fromAccount: "", amount: "")
        
        refBalance.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                
                self.balanceList.removeAll()
                
                for record in snapshot.children.allObjects as! [DataSnapshot] {
                    let balanceObject = record.value as? [String: AnyObject]
                    let balance_uid = balanceObject?["userId"]! as! String
                    
                    if (balance_uid != auth_userId) {
                        continue
                    } else {
                        let balanceType = (balanceObject?["fromAccount"] as! String)
                        
                        // TODO: catch exception for invalid input for amount
                        let balanceAmount = (balanceObject?["amount"] as! String)
                        
                        balance = BalanceModel(fromAccount: balanceType,
                        amount: balanceAmount)
                    }
                    self.balanceList.append(balance)
                }
                self.tableViewBalance.reloadData()
            }
        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}




