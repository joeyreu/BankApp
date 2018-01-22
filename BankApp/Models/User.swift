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
    let model: DataModel
    
    // hardcoded email/password for now
    let userEmail = "jo@google.com"
    let userPass = "123abc"
    
    init(authData: User) {
        uid = authData.uid
        email = authData.email
        model = DataModel()
    }
    
    init(uid: String, email: String){
        self.uid = uid
        self.email = email
        self.model = DataModel()
    }
    
    // helper function that checks if input is a valid email
    // keychain
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    // updates uid and email
    // returns true if successful
    //         false otherwise
    mutating func updateInfo(uid: String, email: String) -> Bool {
        if isValidEmail(testStr: email) {
            self.uid = uid
            self.email = email
            return true
        }
        // error handle
        return false
    }
    
    
    func authenticateUser(password: String) -> Bool {
        self.model.authenticate(email: self.email, password: password) {
            (result) in
            print("got back: \(result)")
        }
        return false
    }
}
