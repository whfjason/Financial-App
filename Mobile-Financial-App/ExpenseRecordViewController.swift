//
//  ExpenseRecordViewController.swift
//  Mobile-Financial-App
//
//  Created by Jason  Wong on 2018-02-16.
//  Copyright © 2018 55487145. All rights reserved.
//

import UIKit

class ExpenseRecordViewController: UIViewController {
    
    @IBOutlet weak var expenseReportType: UITextField!

    let account = ["Checking CIBC",
                   "Credit CIBC",
                   "Credit RBC",
                   "Credit TD"
                   ]
    
    var selectedAccount: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        createAccountPicker()
        createToolbar()

    }
    
    func createAccountPicker() {
        
        let accountPicker = UIPickerView()
        accountPicker.delegate = self
        expenseReportType.inputView = accountPicker
    }
    
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self,
                                         action: #selector(ExpenseRecordViewController.dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        expenseReportType.inputAccessoryView = toolBar
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Expense Report"
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
        expenseReportType.text = selectedAccount
    }
}
