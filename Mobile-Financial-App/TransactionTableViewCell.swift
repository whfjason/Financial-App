//
//  TransactionTableViewCell.swift
//  Mobile-Financial-App
//
//  Created by Jason Wong on 2018-04-01.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var transactionDateLabel: UILabel!
    @IBOutlet weak var transactionNameLabel: UILabel!
    @IBOutlet weak var transactionAmountLabel: UILabel!
    @IBOutlet weak var transactionBalanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
