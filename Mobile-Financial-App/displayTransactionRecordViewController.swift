//
//  displayTransactionRecordViewController.swift
//  Mobile-Financial-App
//
//  Created by Jason Wong on 2018-03-05.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase

class displayTransactionRecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    let formatter = NumberFormatter()

    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var tableViewTransaction: UITableView!
    
    var transactionList = [TransactionModel]()
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        let transaction: TransactionModel
        
        transaction = transactionList[indexPath.row]
        
        cell.labelTransactionName.text = transaction.payableTo
        cell.labelTransactionAmount.text = transaction.amount
        
        return cell
    }
    
    var refTransaction: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refTransaction = Database.database().reference().child("transaction")
        let auth_userId = Auth.auth().currentUser!.uid
        var transaction = TransactionModel(payableTo: "", amount: "")
        
        refTransaction.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                
                self.transactionList.removeAll()
                
                for record in snapshot.children.allObjects as! [DataSnapshot] {
                    let transactionObject = record.value as? [String: AnyObject]
                    let transaction_uid = transactionObject?["userId"]! as! String
                    
                    if (transaction_uid != auth_userId) {
                        continue
                    } else {
                        let transactionName = transactionObject?["payableTo"]
                        let transactionAmount = transactionObject?["amount"]
                        
                        transaction = TransactionModel(payableTo: transactionName as! String?,
                                                           amount: transactionAmount as! String?)
                    }
                    self.transactionList.append(transaction)
                }
                self.tableViewTransaction.reloadData()
            }
        })
    }
}
