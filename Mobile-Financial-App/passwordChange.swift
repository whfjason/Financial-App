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
    
    @IBAction func submitButton(sender: UIButton) {
        changePW()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func changePW() {
        let nPw = newPwField.text!
        let rePW = reNewPwField.text!

        if (nPw == rePW) {
            Auth.auth().currentUser!.updatePassword(to: nPw) { (error) in
                let missMatchAlert = UIAlertController(title: "Password Changed!", message: "Your passwords are successfully", preferredStyle: .alert)
                missMatchAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
                self.present(missMatchAlert, animated: true, completion: nil)
                return
            }
        } else {
            let passwordChangedAlert = UIAlertController(title: "Password Mismatched!", message: "Your passwords are not matched!", preferredStyle: .alert)
            passwordChangedAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
            self.present(passwordChangedAlert, animated: true, completion: nil)
            return
        }
    }
    
}
