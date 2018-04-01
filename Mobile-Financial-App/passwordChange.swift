//
//  passwordChange.swift
//  Mobile-Financial-App
//
//  Created by Michael Ren on 2018-02-19.
//  Copyright © 2018 55487145. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase



class passwordChange: UIViewController {
    
    @IBOutlet weak var newPwField: UITextField!
    @IBOutlet weak var reNewPwField: UITextField!
    @IBOutlet weak var curPwField: UITextField!
    
    
    @IBAction func submitButton(sender: UIButton) {
        changePW()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //the tittle of this user interface
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Update"
    }
    
    func changePW() {
        newPwField.text! = (newPwField.text?.replacingOccurrences(of: " ", with: ""))!
        reNewPwField.text! = (reNewPwField.text?.replacingOccurrences(of: " ", with: ""))!
        curPwField.text! = (curPwField.text?.replacingOccurrences(of: " ", with: ""))!
        
        let cPw = curPwField.text!
        let nPw = newPwField.text!
        let rePW = reNewPwField.text!
        
        //re-verify the user at the beginning by asking current password
        Auth.auth().currentUser!.updatePassword(to: cPw) { (error) in
            if error == nil{
                //case1: the new password is same as the current one
                if(cPw == nPw){
                    let sameAlert = UIAlertController(title: "all the same", message: "Your new password should distinct from the current one", preferredStyle: .alert)
                    sameAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
                    self.present(sameAlert, animated: true, completion: nil)
                    return
                }else if (nPw == rePW) {
                    //case2.1: the new input is empty
                    if(nPw == "" && rePW == ""){
                        let passwordChangedAlert = UIAlertController(title: "null value!", message: "no empty value/space!", preferredStyle: .alert)
                        passwordChangedAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
                        self.present(passwordChangedAlert, animated: true, completion: nil)
                        return
                    }else{
                        //case2.2: password changes successfully
                        Auth.auth().currentUser!.updatePassword(to: nPw) { (error) in
                            let missMatchAlert = UIAlertController(title: "Password Changed!", message: "Your passwords are successfully", preferredStyle: .alert)
                            missMatchAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
                            self.present(missMatchAlert, animated: true, completion: nil)
                            return
                        }
                    }
                } else {
                    //case2.3: the two times inputs are not match
                    let passwordChangedAlert = UIAlertController(title: "Password Mismatched!", message: "Your passwords are not matched!", preferredStyle: .alert)
                    passwordChangedAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
                    self.present(passwordChangedAlert, animated: true, completion: nil)
                    return
                }
            }else{
                //case3: failed verification
                let cannotVarifyAlert = UIAlertController(title: "Cannot Verify", message: "Please enter the correct current possward", preferredStyle: .alert)
                cannotVarifyAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
                self.present(cannotVarifyAlert, animated: true, completion: nil)
                return
            }
        }
        
}
