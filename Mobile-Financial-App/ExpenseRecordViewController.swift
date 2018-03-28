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
        self.hideKeyboard()
    }
    
    
    @IBAction func addTransaction(_ sender: UIButton) {
        
        addTransactionToDB()
        
    }
    
    
    @IBAction func showFullTransactionRecord(_ sender: UIButton) {
        // self.performSegue(withIdentifier: "transactionRecord", sender: self)
    }
    
    func addTransactionToDB() {
        let uid = Auth.auth().currentUser!.uid;
        let ref = dbReference.child("transaction")
        let tid = ref.childByAutoId().key
        let transactionRef = ref.child(tid)
      
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let timestamp = formatter.string(from: date)
        
        transactionAmount.text! = (transactionAmount.text?.replacingOccurrences(of: " ", with: ""))!
        payableTo.text! = (payableTo.text?.replacingOccurrences(of: " ", with: ""))!
        
        let countdots = transactionAmount.text!
        let cont = countdots.components(separatedBy:".")
        let x = cont.count - 1
        
        if x > 1 || transactionAmount.text! == "." || !(transactionAmount.text!.isValidAmount)
        {
            let alert = UIAlertController(title: "Alert", message: "Invalid Input", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            transactionAmount.text! = remove(text: (transactionAmount.text)!)
            payableTo.text! = remove(text: (payableTo.text)!)
            
            if((accountType.text) == ""||(transactionAmount.text) == ""||(payableTo.text) == ""){
                let alert = UIAlertController(title: "Alert", message: "no null value", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

            } else {
                transactionAmount.text! = remove(text: (transactionAmount.text)!)
                payableTo.text! = remove(text: (payableTo.text)!)
                let transactionDetails = ["transactionId": tid,
                                          "userId": uid as String,
                                          "timestamp": timestamp,
                                          "payableTo": payableTo.text! as String,
                                          "fromAccount": accountType.text! as String,
                                          "amount": transactionAmount.text! as String] as [String : Any]
                transactionRef.updateChildValues(transactionDetails)
            }
        }
    }
    
    
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
    
    func remove(text: String) -> String {
        let okayChars : Set<Character> =
            Set(" 1234567890.ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Transactions"
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

extension String {
    var isValidAmount: Bool {
        let char: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]
        return Set(self.characters).isSubset(of: char)
    }
}
