//
//  AccountTableViewCell.swift
//  BankApp
//
//  Created by Joseph Reusing on 2018-01-23.
//  Copyright © 2018 reusjos. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    @IBOutlet weak var AccountName: UILabel!
    @IBOutlet weak var AccountNumber: UILabel!
    @IBOutlet weak var AccountBalance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
