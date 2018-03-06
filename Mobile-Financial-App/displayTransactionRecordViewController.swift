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


    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var tableViewTransaction: UITableView!
    
    
    var transactionList = [TransactionModel]()
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // creating a cell using the customer class
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        // the transaction object
        let transaction: TransactionModel
        
        // getting the transaction of the selected position
        transaction = transactionList[indexPath.row]
        
        // adding values to labels
        cell.labelTransactionName.text = transaction.payableTo
        cell.labelTransactionAmount.text = transaction.amount
        
        return cell
    }
    
    var refTransaction: DatabaseReference!
    
    // TODO: Make sure that the transactions returned are belong to the current logged-in user only
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refTransaction = Database.database().reference().child("transaction")
        let auth_userId = Auth.auth().currentUser!.uid
        var transaction = TransactionModel(payableTo: "", amount: "")
        
        refTransaction.observe(DataEventType.value, with: { (snapshot) in
            // if the reference have some values
            if snapshot.childrenCount > 0 {
                
                // clearing the list
                self.transactionList.removeAll()
                
                // iterate through all the values
                for record in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    // getting values
                    let transactionObject = record.value as? [String: AnyObject]
                    let transaction_uid = transactionObject?["userId"]! as! String
                    
                    if (transaction_uid != auth_userId) {
                        break
                    } else {
                        let transactionName = transactionObject?["payableTo"]
                        let transactionAmount = transactionObject?["amount"]
                        
                        // creating artist object with model and fetched values
                        transaction = TransactionModel(payableTo: transactionName as! String?,
                                                           amount: transactionAmount as! String?)
                    }
                    // appending it to the list
                    self.transactionList.append(transaction)
                }
                
                // reloading the tableview
                self.tableViewTransaction.reloadData()
            }
        })
    }
}
