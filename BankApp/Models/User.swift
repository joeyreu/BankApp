//
//  User.swift
//  BankApp
//
//  Created by Joseph Reusing on 2018-01-19.
//  Copyright © 2018 reusjos. All rights reserved.
//

import Foundation

class User {
    var uid: String // user id
    var email: String // email
    let model: DataModel
    var spendingAccounts: [Account] = []
    var savingAccounts: [Account] = []
    var transactionList: [Transaction] = []
    
    var passwordItems: [KeychainPasswordItem] = []
    
    
    init(authData: User) {
        uid = authData.uid
        email = authData.email
        model = DataModel()
    }
    
    init(uid: String, email: String){
        self.uid = uid
        self.email = email
        self.model = DataModel()
//        self.uid = self.model.getUid()
//        print("userid init: \(self.model.getUid())")
    }
    
    // helper function that checks if input is a valid email
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    // updateInfo():
    //      returns true and updates properties if valid email, false otherwise
    func updateInfo(uid: String, email: String) -> Bool {
        if isValidEmail(testStr: email) {
            self.uid = uid
            self.email = email
            return true
        }
        // error handle
        return false
    }
    
    // authenticateUser():
    //      authenticates using the DataModel and passes the result to the completion handler
    func authenticateUser(password: String, completion: @escaping (Bool) -> Void) {
        self.model.authenticate(email: self.email, password: password) {
            (result) in
            if result {
                self.uid = self.model.getUid()
                print("userid: \(self.model.getUid())")
            }
            completion(result)
        }
    }
    
    func loadAccounts(completion: @escaping (Bool) -> Void){
        model.fetchAccounts(uid: self.uid) {
            (spendArray, saveArray) in
            self.spendingAccounts = spendArray
            self.savingAccounts = saveArray
            completion(true)
        }
    }
    
    func loadTransactions(acc: Account, completion: @escaping (Bool) -> Void) {
        model.fetchTransactions(uid: self.uid, acc: acc) {
            (transArr) in
            self.transactionList = transArr
            completion(true)
        }
    }
    
    
    
/*    func addToKeychain() {
        let hasLoginKey = UserDefaults.standard.bool(forKey: "hasLoginKey")
        if !hasLoginKey && isValidEmail(testStr: self.email) {
            UserDefaults.standard.setValue(self.email, forKey: "email")
        }

        do {
            // This is a new account, create a new keychain item with the account name.
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                    account: newAccountName,
                                                    accessGroup: KeychainConfiguration.accessGroup)

            // Save the password for the new item.
            try passwordItem.savePassword(newPassword)
        } catch {
            fatalError("Error updating keychain - \(error)")
        }

        // 6
        UserDefaults.standard.set(true, forKey: "hasLoginKey")
        
    }*/
    
    func test() {
        print(self.email)
    }
    
    
    func logout(completion: @escaping (Bool) -> Void) {
        model.logout() {
            (result) in
            completion(result)
        }
    }
    
    
}
