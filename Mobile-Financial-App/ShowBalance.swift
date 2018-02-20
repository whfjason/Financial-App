//
//  ShowBalance.swift
//  Mobile-Financial-App
//
//  Created by Eric Xiao on 2018/2/16.
//  Copyright © 2018年 55487145. All rights reserved.
//

import UIKit

class fViewController: UIViewController{
   
    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstButton.buttonDesign()
        secondButton.buttonDesign()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension UIButton{
    func buttonDesign(){
        backgroundColor = UIColor.darkGray
        layer.cornerRadius = frame.height/2
        setTitleColor(UIColor.white, for: .normal)
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 0)
        
}
}
