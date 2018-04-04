//
//  ExpensesAnalyticsViewController.swift
//  Mobile-Financial-App
//
//  Created by Jason  Wong on 2018-04-03.
//  Copyright © 2018 55487145. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase

class ExpensesAnalyticsViewController: UIViewController {

    var dbReference : DatabaseReference!
    var dbHandel : DatabaseHandle!
    @IBOutlet weak var averageMonthlyExpense: UILabel!
    
    // MARK: Retrieve transaction amount for the past 30 days
    func retrievePastTransaction() {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        let targetDate = Calendar.current.date(byAdding: .month, value: -1, to: date)
        let prevDate = formatter.string(from: targetDate!)
        
        
        // DONE: Iterate through the transaction records where the date is within the past 30 days
        
        // TODO: Obtain the accountId by segue transmission to fetch the proper records
        // TODO: Add segue to display analytics
        
        let uid = Auth.auth().currentUser!.uid
        let ref = Database.database().reference().child("user").child(uid).child("account").child("-L9-ALAEpWY2UFXcfVy3").child("transaction")
        
      //  var expensesAmountRecord = [Double]()
        var expensesAmountRecord: [Double] = []

        
        ref.observe(DataEventType.value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0 {
                for record in snapshot.children.allObjects as! [DataSnapshot] {
                    let transactionObject = record.value as! [String: AnyObject]
                    let transactionDate = (transactionObject["date"] as! String)
                    
                    if (transactionDate > prevDate) {
                        let transactionAmount = (transactionObject["amount"] as! String)
                        let amount = Double(transactionAmount)!
                        print(amount)
                        // BUG: the array expensesAmountRecord is never updated
                        expensesAmountRecord.append(amount)
                    }
                }
            }
        })
        print(expensesAmountRecord)
        let averageExpenses = Double(expensesAmountRecord.reduce(0, +) / 30)
        print(averageExpenses)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrievePastTransaction()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
