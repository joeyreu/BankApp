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
    
    init(){
        self.uid = ""
        self.model = DataModel()
        
        // check if email is stored in keychain
        if let storedUsername = UserDefaults.standard.value(forKey: "email") as? String {
            self.email = storedUsername
        } else {
            self.email = ""
        }
    }
    
    // helper function that checks if input is a valid email
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    // updateInfo():
    //      returns true and updates properties if valid email, false otherwise
    func updateEmail( email: String) -> Bool {
        if isValidEmail(testStr: email) {
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
                UserDefaults.standard.setValue(self.email, forKey: "email") // add email to keychain
                self.uid = self.model.getUid()
                print("userid: \(self.model.getUid())")
            }
            completion(result)
        }
    }
    
    // MARK: LOADING DATA
    func loadAccounts(completion: @escaping () -> Void){
        model.fetchAccounts(uid: self.uid) {
            dict in
            // PARSE THE DICTIONARY HERE
            var newSpAs: [Account] = []
            var newSAs: [Account] = []
            dict?.forEach({
                (key, value) in
                let acc = value as? Dictionary<String, Any>
                let newAcc = Account(name: acc!["Account Name"] as! String,
                                     number: acc!["Account Number"] as! Int,
                                     balance: acc!["Account Balance"] as! Double,
                                     type: acc!["Account Type"] as! String,
                                     accid: key)
                newAcc.accType == "Spending" ? newSpAs.append(newAcc) : newSAs.append(newAcc)
            })
            self.spendingAccounts = newSpAs
            self.savingAccounts = newSAs
            completion()
        }
    }
    func loadTransactions(acc: Account, completion: @escaping () -> Void) {
        model.fetchTransactions(uid: self.uid, acc: acc) {
            (dict) in
            var transA: [Transaction] = []
            dict?.forEach({
                (key, value) in
                let trans = value as? Dictionary<String, Any>
                let newTrans = Transaction(dateTime: trans!["DateTime"] as! Double,
                                           vendor: trans!["Vendor"] as! String,
                                           amount: trans!["Amount"] as! Double,
                                           type: trans!["Type"] as! String)
                transA.append(newTrans)
            })
            self.transactionList = transA.sorted(by: { $0.dateTime > $1.dateTime })
            completion()
        }
        
    }
    
    // LOGOUT FUNCTION
    func logout(completion: @escaping (Bool) -> Void) {
        model.logout() {
            (result) in
            if result {
                self.spendingAccounts = []
                self.savingAccounts = []
                self.transactionList = []
            }
            completion(result)
        }
    }
    
}
