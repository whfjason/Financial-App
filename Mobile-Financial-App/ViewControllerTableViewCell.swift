//
//  ViewControllerTableViewCell.swift
//  Mobile-Financial-App
//
//  Created by Jason Wong on 2018-03-06.
//  Copyright © Jason Wong. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTransactionName: UILabel!
    @IBOutlet weak var labelTransactionAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

    }

}
