//
//  LoginTextField.swift
//  Mobile-Financial-App
//
//  Created by 55487145 on 2018-02-14.
//  Copyright © 2018 55487145. All rights reserved.
//

import UIKit

@IBDesignable
class LoginTextField: UITextField {
    
    @IBInspectable var iconLeftPadding: CGFloat = 8
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderColor = UIColor(white: 231 / 255, alpha: 1).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 2
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 10, dy: 7)
        var textRect = super.textRect(forBounds: bounds)
        textRect.origin.x += iconLeftPadding
        return textRect
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds);
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 12, dy: 12)  // control the size the icon element
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += iconLeftPadding    // add left padding to the icon
        return textRect
    }
    
    /* source code: https://stackoverflow.com/questions/27903500/swift-add-icon-in-uitextfield/41151566 */
    @IBInspectable var leftImage: UIImage? {
        didSet {
            if let image = leftImage {
                leftViewMode = UITextFieldViewMode.always
                let imageView = UIImageView(frame: CGRect(x: 25, y: 0, width: 25, height: 30))
                imageView.contentMode = .scaleAspectFit
                imageView.image = image
                leftView = imageView
            } else  {
                leftViewMode = UITextFieldViewMode.never
                leftView = nil
            }
        }
    }
}
