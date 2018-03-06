//
//  ExpenseRecordViewController.swift
//  Mobile-Financial-App
//
//  Created by Jason  Wong on 2018-02-16.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase

class ExpenseRecordViewController: UIViewController {
    
    var dbReference : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    @IBOutlet weak var accountType: UITextField!
    @IBOutlet weak var transactionAmount: UITextField!
    @IBOutlet weak var payableTo: UITextField!
    
    // Retrieve all available client expense accounts from database dynamically
    let account = ["Checking",
                   "Saving",
                   "Cash"
                   ]
    
    var selectedAccount: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        createAccountPicker()
        createToolbar()
        dbReference = Database.database().reference()
        
//        testFunction()
    }
    
    @IBAction func addTransaction(_ sender: UIButton) {
        addTransactionToDB()
    }
    
    func addTransactionToDB() {
        let uid = Auth.auth().currentUser!.uid;
        let uidRef = dbReference.child("user").child("uid_"+uid)
        let tid = uidRef.childByAutoId().key
        let transactionRef = uidRef.child("tid_"+tid)
        let timestamp = NSDate().timeIntervalSince1970

        let transactionDetails = ["transactionId": tid,
                                  "timestamp": timestamp,
                                  "payableTo": payableTo.text! as String,
                                  "fromAccount": accountType.text! as String,
                                  "amount": transactionAmount.text! as String] as [String : Any]
        transactionRef.updateChildValues(transactionDetails)
    }
    
    // Test function displays all the transaction made by the current authorized user
//    func testFunction() {
//        let refTransaction = Database.database().reference().child("transaction")
//        refTransaction.observe(DataEventType.value, with: { (snapshot) in
//            if snapshot.childrenCount > 0 {
//                print("---------- breakpoint checker ----------")
//                for record in snapshot.children.allObjects as! [DataSnapshot] {
//                    let transactionObject = record.value as? [String: AnyObject]
//                    let userId = transactionObject?["userId"]! as!String
//                    print(userId)
//                    if (userId != Auth.auth().currentUser!.uid) {
//                        break;
//                    } else {
//                        print(transactionObject?["amount"]! ?? String.self)
//                        print(transactionObject?["payableTo"] ?? String.self)
//                    }
//                }
//            }
//        })
//    }
    
    func createAccountPicker() {
        
        let accountPicker = UIPickerView()
        accountPicker.delegate = self
        accountType.inputView = accountPicker
    }
    
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self,
                                         action: #selector(ExpenseRecordViewController.dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        accountType.inputAccessoryView = toolBar
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Transaction Records"
    }
}

extension ExpenseRecordViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return account.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return account[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedAccount = account[row]
        accountType.text = selectedAccount
    }
}
