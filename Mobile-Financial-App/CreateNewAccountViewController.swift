//
//  CreateNewAccountViewController.swift
//  Mobile-Financial-App
//
//  Created by Jason Wong on 2018-03-31.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase

class CreateNewAccountViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    /*
     MARK: Brief description of the Account class. Account is stored under user and uid.
     
     Account Class:
        - AccountId (Auto-generated ID)
        - AccountName
        - AccountType
        - AccountBalance
    */
    
    // MARK: Variables Declaration
    
    var dbReference : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    @IBOutlet weak var accountName: LoginTextField!
    @IBOutlet weak var accountType: LoginTextField!
    @IBOutlet weak var accountBalance: LoginTextField!
    
    @IBAction func addAccount(_ sender: UIButton) {
        
        addAccountInfoToDB()
    }
    
    let accountTypePickerData = ["Deposit Accounts",
                             "Credit Accounts",
                             "Cash"]
    
    // MARK: Implement UIPickerViewDataSource Protocol
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return accountTypePickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return accountTypePickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        accountType.text  = accountTypePickerData[row]
    }
    
    // MARK: Create account in database
    
    func addAccountInfoToDB() {
        let uid = Auth.auth().currentUser!.uid
        let ref = dbReference.child("user").child(uid).child("account")
        let accountId = ref.childByAutoId().key
        
        let accountRef = ref.child(accountId)
        
        let accountInfo = ["accountName": accountName.text! as String,
                           "accountId": accountId,
                           "accountType": accountType.text! as String,
                           "accountBalance": accountBalance.text! as String]
        
        accountRef.updateChildValues(accountInfo)
            
        // TODO: Conditioned the redirectToAccountSegue only if .updateChildValues is success (i.e. error nil)
        self.performSegue(withIdentifier: "redirectToAccountSegue", sender: self)
    }
    
    override func viewDidLoad() {
        
        dbReference = Database.database().reference()
        
        super.viewDidLoad()
        self.hideKeyboard()
        
        let accountTypePicker = UIPickerView()
        accountType.inputView = accountTypePicker
        accountTypePicker.delegate = self
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self,
                                         action: #selector(self.dimissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        accountType.inputAccessoryView = toolBar
    
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    

}
