//
//  paybillsViewController.swift
//  Mobile-Financial-App
//
//  Created by Michael Ren on 2018-03-08.
//  Copyright © 2018 55487145. All rights reserved.
//  Reference: using open sources to finish the encryption, source link: https://github.com/verbeeckkristof/crypto.git

import UIKit

class paybillsViewController: UIViewController {
    @IBOutlet weak var paymentPassword: UITextField!
    var plaintext = ""
    var cipherText = ""
    let crypt = KVCipher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //encryption users payment password for security
    @IBAction func encryptData(_ sender: Any) {
        plaintext = paymentPassword.text!
        //encryption the password
        let ciphertxt = crypt.encrypt(PlainText:plaintext)
        //deciphering the password if there is a future use
        let plaintxt = crypt.decrypt(CipherText: ciphertxt)
        
        /*
         display it if needed for future
         plaintextView.text = plaintxt
         ciphertextView.text = ciphertxt
         */
        paymentPassword.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() // Dispose of any resources that can be recreated.
    }
    

    
}
