//
//  emailViewController.swift
//  Mobile-Financial-App
//
//  Created by Eric Xiao on 2018/3/31.
//  Copyright © 2018年 55487145. All rights reserved.
//
import UIKit
import MessageUI

class emailViewController: UIViewController, MFMailComposeViewControllerDelegate{
    
    @IBOutlet weak var Subject: UITextField!
    @IBOutlet weak var MessageBody: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func SendMessage(_ sender: Any) {
        var SubjectText = "App Issues"
        SubjectText += Subject.text!
        var Message = MessageBody.text
        let mailCompose = MFMailComposeViewController()
        mailCompose.mailComposeDelegate = self
    mailCompose.setToRecipients(["superericxiao@hotmail.com"])
        mailCompose.setSubject(SubjectText)
        mailCompose.setMessageBody(Message!, isHTML: false)
        if MFMailComposeViewController.canSendMail(){
            self.present(mailCompose, animated: true, completion: nil)
        }else{
            showSendMailErrorAlert()
            
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    func showSendMailErrorAlert(){
        let errorAlert = UIAlertController(title: "Error", message: "Could not send email", preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(errorAlert, animated: true, completion: nil)
        
    }
}
