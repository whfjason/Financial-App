//
//  Transaction.swift
//  Mobile-Financial-App
//
//  Created by Jason Wong on 2018-04-01.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import Foundation
import UIKit

class Transaction {
    
    // MARK: Properties
    
    var transactionDateLabel: String
    var transactionNameLabel: String
    var transactionAmountLabel: String
    var transactionBalanceLabel: String
    
    // MARK: Initialization
    
    init?(transactionDateLabel: String, transactionNameLabel: String, transactionAmountLabel: String, transactionBalanceLabel: String) {
        
        // TODO: Add more validation and error handling
        
        if (transactionDateLabel.isEmpty || transactionNameLabel.isEmpty || transactionAmountLabel.isEmpty || transactionBalanceLabel.isEmpty) {
            return nil
        }
        
        self.transactionDateLabel = transactionDateLabel
        self.transactionNameLabel = transactionNameLabel
        self.transactionAmountLabel = transactionAmountLabel
        self.transactionBalanceLabel = transactionBalanceLabel
        
    }

}
