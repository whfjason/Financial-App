//
//  AccountTableViewCell.swift
//  Mobile-Financial-App
//
//  Created by Jason Wong on 2018-03-31.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var accountTypeLabel: UILabel!
    @IBOutlet weak var accountBalance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
