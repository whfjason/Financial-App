//
//  Account.swift
//  Mobile-Financial-App
//
//  Created by Jason Wong on 2018-03-31.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import Foundation
import UIKit

class Account {
    
    // MARK: Properties
    
    var accountNameLabel: String
    var accountTypeLabel: String
    var accountBalance: String
    
    
    // MARK: Initialization
    
    init?(accountNameLabel: String, accountTypeLabel: String, accountBalance: String) {

        // TODO: Include cases when the string is consist of empty white space
        // TODO: Include validation on data integrity
        
        if (accountNameLabel.isEmpty || accountTypeLabel.isEmpty) {
            return nil
        }
        
        self.accountNameLabel = accountNameLabel
        self.accountTypeLabel = accountTypeLabel
        self.accountBalance = accountBalance
        
    }

}
