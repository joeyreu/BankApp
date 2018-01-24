//
//  TransactionTableViewCell.swift
//  BankApp
//
//  Created by Joseph Reusing on 2018-01-23.
//  Copyright © 2018 reusjos. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    @IBOutlet weak var vendor: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
