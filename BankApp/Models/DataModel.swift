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
        FirebaseApp.configure()
    }
    // login,
    func authenticate(email: String, password: String, completion: @escaping (Bool) -> Void){
        print(email)
        print(password)

        Auth.auth().signIn(withEmail: email, password: password) {
            (user, error) in
            var result = false
            if error != nil{
                print("test")
                // login error
                result = false
            } else {
                print("test2")
                // login successful
                result = true
            }
            completion(result)
        }
    }
    
}
