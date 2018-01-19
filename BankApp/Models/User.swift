//
//  User.swift
//  BankApp
//
//  Created by Joseph Reusing on 2018-01-19.
//  Copyright © 2018 reusjos. All rights reserved.
//

import Foundation

struct User {
    var uid: String // user id
    var email: String // email
    
    init(authData: User) {
        uid = authData.uid
        email = authData.email
    }
    
    init(uid: String, email: String){
        self.uid = uid
        self.email = email
    }
    
    // helper function that checks if input is a valid email
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    mutating func updateInfo(uid: String, email: String){
        if isValidEmail(testStr: email) {
            self.uid = uid
            self.email = email
        } else {
            // error handle
            print("invalid email")
        }
        
    }
}
