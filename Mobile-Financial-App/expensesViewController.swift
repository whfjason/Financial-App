//
//  expensesViewController.swift
//  Mobile-Financial-App
//
//  Created by 21403150 on 2018-02-16.
//  Copyright © 2018 55487145. All rights reserved.
//

import UIKit

class expensesViewController: UIViewController {

    @IBOutlet var cityButtons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleSelection(_ sender: UIButton) {
        cityButtons.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            
            })
        }
    }
    enum Reports: String{
        case report1 = "report1"
        case report2 = "report2"
    }
    @IBAction func cityTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle, let report = Reports(rawValue: title) else {
            return
        }
        
        switch report {
        case .report1:
            print("report1")
        default:
            print("report2")
        
        }
    }

    
}
