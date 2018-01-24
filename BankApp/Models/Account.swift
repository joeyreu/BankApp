//
//  Accounts.swift
//  BankApp
//
//  Created by Joseph Reusing on 2018-01-19.
//  Copyright © 2018 reusjos. All rights reserved.
//

import Foundation


struct Account {
    var accName: String
    var accNum: Int
    var accBal: Double
    var accType: String
    var accid: String
    
    
    init(name: String, number: Int, balance: Double, type: String, accid: String){
        self.accName = name
        self.accNum = number
        self.accBal = balance
        self.accType = type
        self.accid = accid
    }
    

    
}
