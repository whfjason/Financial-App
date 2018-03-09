//
//  ShowBalanceTableViewCell.swift
//  Mobile-Financial-App
//
//  Created by Eric Xiao on 2018/3/8.
//  Copyright © 2018年 Eric Xiao. All rights reserved.
//

import UIKit

class ShowBalanceTableViewCell: UITableViewCell {


    @IBOutlet weak var accountBalance: UILabel!
    @IBOutlet weak var accountTp: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
