//
//  ViewController.swift
//  Mobile-Financial-App
//
//  Created by 55487145 on 2018-02-14.
//  Copyright © 2018 55487145. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    
    @IBOutlet weak var emailField: LoginTextField!
    @IBOutlet weak var passwordField: LoginTextField!
    
    @IBAction func loginButton(_ sender: UIButton) {
        login()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func login() {
        guard let email = emailField.text else { return }
        guard let pwd = passwordField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: pwd) { user, error in
            if error == nil {
                self.performSegue(withIdentifier: "loginToMenuSegue", sender: self)
                print("login was successful")
            } else {
                print("login failed")
                let loginErrorAlert = UIAlertController(title: "Login Error", message: "\(error!.localizedDescription) Please try again.", preferredStyle: .alert)
                loginErrorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(loginErrorAlert, animated: true, completion: nil)
                return
            }
        }
    }
    
}

