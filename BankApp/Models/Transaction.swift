//
//  Transactions.swift
//  BankApp
//
//  Created by Joseph Reusing on 2018-01-19.
//  Copyright © 2018 reusjos. All rights reserved.
//

import Foundation



struct Transaction {
    var dateTime: String
    var vendor: String
    var amount: Double
    
    init(dateTime: String, vendor: String, amount: Double){
        self.dateTime = dateTime
        self.vendor = vendor
        self.amount = amount
    }
}
