//
//  AddTransactionViewController.swift
//  Mobile-Financial-App
//
//  Created by Jason Wong on 2018-04-01.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase

class AddTransactionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    /*
     MARK: Brief description of the Transaction class. Transaction is stored under user, uid, account.
    
     Transaction Class:
        - date (app generated timestamp at the time where the transaction is added to the database)
        - name
        - amount
        - balance (auto-calculated based on the currenct account balance)
        - type (an option of either expense or revenue)
    */
    
    // MARK: Variables declaration
    
    var accountId : String!
    var accountBalance : String!
    var dbReference : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    @IBOutlet weak var transactionName: LoginTextField!
    @IBOutlet weak var transactionAmount: LoginTextField!
    @IBOutlet weak var transactionType: LoginTextField!
    
    
    @IBAction func addTransaction(_ sender: Any) {
        
        addTransactionToDB()
    }
    
    let transactionTypePickerData = ["Revenue", "Expenses"]
    
    // MARK: Implement UIPickerViewDataSource Protocol
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return transactionTypePickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return transactionTypePickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        transactionType.text = transactionTypePickerData[row]
    }
    
    // MARK: Create transaction class in database
    
    func addTransactionToDB() {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let transactionDate = formatter.string(from: date)
        
        // TODO: Only call the updateAccountBalance() method if the update to the database is successful
        // TODO: Implement Export CSV functionality

        let type = transactionType.text! as String
        var amount = transactionAmount.text! as String
        var runningBalance = ""
        if (type == "Revenue") {
            runningBalance = String(Double(accountBalance)! + Double(transactionAmount.text! as String)!)
        } else {
            amount = "-" + amount
            runningBalance = String(Double(accountBalance)! - Double(transactionAmount.text! as String)!)
        }
        
        
        
        let uid = Auth.auth().currentUser!.uid
        let ref = dbReference.child("user").child(uid).child("account").child(accountId).child("transaction")
        
        let transactionId = ref.childByAutoId().key
        let transactionRef = ref.child(transactionId)
        
        let transactionInfo = ["tid": transactionId,
                               "date": transactionDate,
                               "name": transactionName.text! as String,
                               "amount": amount,
                               "type": type,
                               "balance": runningBalance]
        
        transactionRef.updateChildValues(transactionInfo)
        updateAccountBalance(balance: runningBalance)
    }
    
    func updateAccountBalance(balance: String) {
        let uid = Auth.auth().currentUser!.uid
        let ref = dbReference.child("user").child(uid).child("account").child(accountId)
        ref.updateChildValues([
            "accountBalance": balance
        ])        
    }
    
    override func viewDidLoad() {
        
        dbReference = Database.database().reference()
        
        super.viewDidLoad()
        self.hideKeyboard()
        
        let transactionTypePicker = UIPickerView()
        transactionType.inputView = transactionTypePicker
        transactionTypePicker.delegate = self
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dimissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        transactionType.inputAccessoryView = toolBar

    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
}
