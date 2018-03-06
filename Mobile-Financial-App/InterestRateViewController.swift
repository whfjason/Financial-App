//
//  InterestRateViewController.swift
//  Mobile-Financial-App
//
//  Created by 21403150 on 2018-03-05.
//  Copyright © 2018 55487145. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class InterestRateViewController: UIViewController {
   
    @IBOutlet weak var Principal: UITextField!
   
    @IBOutlet weak var Compound: UITextField!
    
    @IBOutlet weak var Interest: UITextField!
  
    @IBOutlet weak var Duration: UITextField!
    
    @IBOutlet weak var Result: UILabel!
    
    @IBAction func Execute(_ sender: Any) {
    let p = Double(Principal.text!)
    let n = Double(Compound.text!)
    let r = Double(Interest.text!)
    let T = Double(Duration.text!)
    let sum =    p!+(pow((r!/n!)+1,n!*T!))
    Result.text = String(sum)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
