//
//  Accounts.swift
//  BankApp
//
//  Created by Joseph Reusing on 2018-01-19.
//  Copyright © 2018 reusjos. All rights reserved.
//

import Foundation


struct Account {
    var uid: String
    var email: String
    let type: String
    var transactions: [Transaction]
    
    init(uid: String, email: String, type: String){
        self.uid = uid
        self.email = email
        self.type = type
        self.transactions = []
        
    }
    
}
