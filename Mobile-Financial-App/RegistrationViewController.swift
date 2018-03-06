//
//  RegistrationViewController.swift
//  Mobile-Financial-App
//
//  Created by Jason Wong on 2018-02-16.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class RegistrationViewController: UIViewController {
    
    var dbReference : DatabaseReference!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        dbReference = Database.database().reference()
    }
    
    @IBAction func submitButton(sender: UIButton) {
        signup()
    }
    
    @objc func signup() {
        guard let email = emailField.text else { return }
        guard let pwd = passwordField.text else { return }
        guard let name = nameField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: pwd) { user, error in
            if error == nil && user != nil {
                let signupSuccessAlert = UIAlertController(title: "Account Created!", message: "You can now login to the app with your account!", preferredStyle: .alert)
                signupSuccessAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
                self.present(signupSuccessAlert, animated: true, completion: nil)
                
                let userId: String = user!.uid
                let userEmail: String = email
                let userName: String = name
                
                self.dbReference.child("user").child(userId).setValue(["userId": userId,
                                                                              "email": userEmail,
                                                                              "name": userName])
                return
            } else {
                let signupErrorAlert = UIAlertController(title: "Error", message: "\(error!.localizedDescription) Please try again.", preferredStyle: .alert)
                signupErrorAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
                self.present(signupErrorAlert, animated: true, completion: nil)
                return
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Registration"
    }
    
    
}
