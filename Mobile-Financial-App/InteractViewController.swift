//
//  InteractViewController.swift
//  Mobile-Financial-App
//
//  Created by 21403150 on 2018-03-06.
//  Copyright © 2018 55487145. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import QuartzCore

class InteractViewController: UIViewController {
    
    @IBAction func RBC(_ sender: UIButton) {
        if let url = NSURL(string:"https://www.rbc.com"){
            UIApplication.shared.open(url as URL)
        }
    }

    @IBAction func CIBC(_ sender: UIButton) {
        if let url = NSURL(string:"https://www.cibc.com"){
            UIApplication.shared.open(url as URL)
        }
    }
    
    @IBAction func HSBC(_ sender: UIButton) {
        if let url = NSURL(string:"https://www.hsbc.com"){
            UIApplication.shared.open(url as URL)
        }
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}


