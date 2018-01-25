//
//  DataModel.swift
//  BankApp
//
//  Created by Joseph Reusing on 2018-01-19.
//  Copyright © 2018 reusjos. All rights reserved.
//

import Foundation

import Firebase
import FirebaseAuth
import FirebaseDatabase


class DataModel {
    
    
    init() {
        print("DataModel - init and FirebaseApp configured")
        FirebaseApp.configure()
    }
    
    // login
    func authenticate(email: String, password: String, completion: @escaping (Bool) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) {
            (user, error) in
            var result = false
            if error == nil { result = true }
            completion(result)
        }
    }
    
    func getUid() -> String {
        return Auth.auth().currentUser!.uid
    }
    
    
    func fetchAccounts(uid: String, completion: @escaping (Dictionary<String, Any>?) -> Void){
        let accountsReference = Database.database().reference(withPath: "Accounts/\(uid)")
        accountsReference.observe(.value, with: {
            snapshot in
            print(snapshot)
            // converting to a dictionary and using key and value
            let dict = snapshot.value as? Dictionary<String, Any>
            completion(dict)
            /*
            var spendArr: [Account] = []
            var saveArr: [Account] = []
            // iterate through accounts
            for item in snapshot.children {
                let itemDS = item as! DataSnapshot
                let key: String = itemDS.key
                let snapshotValue = itemDS.value as! [String: AnyObject]
                let accName: String = snapshotValue["Account Name"] as! String
                let accNum: Int = snapshotValue["Account Number"] as! Int
                let accBal: Double = snapshotValue["Account Balance"] as! Double
                let accType: String = snapshotValue["Account Type"] as! String
                
                let newAcc = Account(name: accName, number: accNum, balance: accBal, type: accType, accid: key)
                
                if accType == "Spending" {
                    spendArr.append(newAcc)
                } else {
                    saveArr.append(newAcc)
                }
                
                print("accName: \(accName)")
                print("accNum: \(accNum)")
                print("accBal: \(accBal)")
            }*/
        })
    }
    
    func fetchTransactions(uid: String, acc: Account, completion: @escaping (Dictionary<String, Any>?) -> Void){
        let transactionsReference = Database.database().reference(withPath: "Transactions/\(uid)/\(acc.accid)")
        transactionsReference.queryOrdered(byChild: "DateTime").observe(.value, with: {
            snapshot in
            print(snapshot)
            //let dict = snapshot.value as? NSDictionary
            let dict2 = snapshot.value as? Dictionary<String, Any>
            print(dict2!)
            completion(dict2)
            /*var transArr: [Transaction] = []
            // iterate through accounts
            for item in snapshot.children {
                let itemDS = item as! DataSnapshot
                let snapshotValue = itemDS.value as! [String: AnyObject]
                let vendor: String = snapshotValue["Vendor"] as! String
                let dateTime: Double = snapshotValue["DateTime"] as! Double
                let amount: Double = snapshotValue["Amount"] as! Double
                let type: String = snapshotValue["Type"] as! String
                
                let newTrans = Transaction(dateTime: dateTime, vendor: vendor, amount: amount, type: type)
                
                transArr.append(newTrans)
                print("vendor: \(vendor)")
                print("dateTime: \(dateTime)")
                print("amount: \(amount)")
            }
            completion(transArr.reversed())*/
        })
    }
    
    
    
    func logout(completion: @escaping (Bool) -> Void) {
        do{
            try Auth.auth().signOut()
            completion(true)
        }catch{
            print("Error while signing out!")
            completion(false)
        }
        
    }

    
    
    
}
