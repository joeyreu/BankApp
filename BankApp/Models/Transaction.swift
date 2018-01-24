//
//  Transactions.swift
//  BankApp
//
//  Created by Joseph Reusing on 2018-01-19.
//  Copyright © 2018 reusjos. All rights reserved.
//

import Foundation



struct Transaction {
    var dateTime: Double
    var vendor: String
    var amount: Double
    var type: String
    
    init(dateTime: Double, vendor: String, amount: Double, type: String){
        self.dateTime = dateTime
        self.vendor = vendor
        self.amount = amount
        self.type = type
    }
}
