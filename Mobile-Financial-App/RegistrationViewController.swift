//
//  RegistrationViewController.swift
//  Mobile-Financial-App
//
//  Created by Jason  Wong on 2018-02-16.
//  Copyright © 2018 55487145. All rights reserved.
//

// TODO: Implement a successfully login page (aka homepage) and redirect to expense report interface

import Foundation
import UIKit
import Firebase

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }
    
    @IBAction func submitButton(sender: UIButton) {
        signup()
    }
    
    @objc func signup() {
        guard let email = emailField.text else { return }
        guard let pwd = passwordField.text else { return }
        
        
        Auth.auth().createUser(withEmail: email, password: pwd) { user, error in
            if error == nil && user != nil {
                let signupSuccessAlert = UIAlertController(title: "Account Created!", message: "You can now login to the app with your account!", preferredStyle: .alert)
                signupSuccessAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
                self.present(signupSuccessAlert, animated: true, completion: nil)
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