//
//  emailViewController.swift
//  Mobile-Financial-App
//
//  Created by Eric Xiao on 2018/3/31.
//  Copyright © 2018年 55487145. All rights reserved.
//


import UIKit
import MessageUI


class emailViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var Subject: UITextField!
    
    @IBOutlet weak var Body: UITextView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func SendMessage(_ sender: AnyObject) {
        var SubjectText = "Technical Issues"
        SubjectText += Subject.text!
        
        var MessageBody = Body
        
        
        var mc:  MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject(SubjectText)
        mc.setMessageBody((MessageBody?.text)!, isHTML: false)
        mc.setToRecipients(["techinical@gmail.com"])
        self.present(mc,animated: true, completion: nil)
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: NSError?) {
        switch result {
        case MFMailComposeResult.cancelled:
            NSLog("Mail Cancelled")
        case MFMailComposeResult.saved:
            NSLog("Mail Saved")
        case MFMailComposeResult.sent:
            NSLog("Mail Sent")
        case MFMailComposeResult.failed:
            NSLog("Mail Sent Failure: %@", [error?.localizedDescription])

        default:
            break
        }
        self.dismiss(animated: true,completion: nil)
    }
    
    
}

