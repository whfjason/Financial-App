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

class passwordChange: UIViewController {
    
    @IBOutlet weak var newPwField: UITextField!
    @IBOutlet weak var reNewPwField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }
    
    @IBAction func submitButton(sender: UIButton) {
        changePW()
    }

    @objc func changePW() {
        guard let nPW = newPwField.text else { return }
        guard let rePW = reNewPwField.text else { return }
        
        
        if Auth.auth().currentUser != nil {
            // User is signed in.
            // Compare if provided passwords are match
            if (nPW == rePW)
            {
                let missMatchAlert = UIAlertController(title: "MismatchPW!", message: "Your passwords typed are not matched", preferredStyle: .alert)
                missMatchAlert.addAction(UIAlertAction(title: "Mismatch", style: .default, handler: nil))
                self.present(missMatchAlert, animated: true, completion: nil)
                return
            }
            //update the password
            Auth.auth().currentUser?.updatePassword(to: nPW) { (error) in
                if error == nil {
                    let changePasswordSuccessAlert = UIAlertController(title: "Password changed successfully!", message: "You can now login to the app with your new password!", preferredStyle: .alert)
                    changePasswordSuccessAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
                    self.present(changePasswordSuccessAlert, animated: true, completion: nil)
                    return
                } else {
                    let changePasswordErrorAlert = UIAlertController(title: "Error", message: "\(error!.localizedDescription) Please try again.", preferredStyle: .alert)
                    changePasswordErrorAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
                    self.present(changePasswordErrorAlert, animated: true, completion: nil)
                    return
                }
            }
            
        } else {
            // No user is signed in.
            let notSigninAlert = UIAlertController(title: "NotSignedIn!", message: "You need to log in first", preferredStyle: .alert)
            notSigninAlert.addAction(UIAlertAction(title: "NotSigned", style: .default, handler: nil))
            self.present(notSigninAlert, animated: true, completion: nil)
            return
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "updatedPW"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
