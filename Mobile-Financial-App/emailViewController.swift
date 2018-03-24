//
//  emailViewController.swift
//  Mobile-Financial-App
//
//  Created by Eric Xiao on 2018/3/23.
//  Copyright © 2018年 55487145. All rights reserved.
//
import UIKit

class emailViewController: UIViewController, MFMailCOmposeViewControllerDelegate{
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var messageField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func Send(sender: AnyObject){
        let toRecipients = ["abc@123.com"]
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setToRecipients(toRecipients)
        mc.setSubject(nameField.text!)
        mc.setMessageBody("Name: \(nameField.text!) \n\nEmail:\(emailField.text!) \n\nMessage: \(messageField.text!)",isHTML: Bool)
        self.presentedViewController(mc,animated:true,completion:nil)
        
    }
    
}
