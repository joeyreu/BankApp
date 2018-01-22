//
//  LoginViewController.swift
//  BankApp
//
//  Created by Joseph Reusing on 2018-01-19.
//  Copyright © 2018 reusjos. All rights reserved.
//

import UIKit

// Keychain Configuration
struct KeychainConfiguration {
    static let serviceName = "TouchMeIn"
    static let accessGroup: String? = nil
}



class LoginViewController: UIViewController {

    // MARK: - Variables
    var user: User!
    
    // MARK: Properties
//    var managedObjectContext: NSManagedObjectContext?
//    let touchMe = BiometricIDAuth()
    var passwordItems: [KeychainPasswordItem] = []
    let createLoginButtonTag = 0
    let loginButtonTag = 1
    
    // MARK: - Outlets
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // initalize user object
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // function to display an alert
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction);
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Actions
    @IBAction func loginDidTouch(_ sender: AnyObject) {
        // 1
        // Check that text has been entered into both the username and password fields.
        guard let newAccountName = emailField.text,
            let newPassword = passField.text,
            !newAccountName.isEmpty,
            !newPassword.isEmpty else {
                displayAlert(title: "Error", message: "Enter username and password")
                return
        }
        // 2
        emailField.resignFirstResponder()
        passField.resignFirstResponder()
        
        // 3
        if sender.tag == createLoginButtonTag {
            // 4
            let hasLoginKey = UserDefaults.standard.bool(forKey: "hasLoginKey")
            if !hasLoginKey && emailField.hasText {
                UserDefaults.standard.setValue(emailField.text, forKey: "email")
            }
            
            // 5
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
            //loginButton.tag = loginButtonTag
            //performSegue(withIdentifier: "dismissLogin", sender: self)
        } else if sender.tag == loginButtonTag {
            // 7
//            if checkLogin(username: newAccountName, password: newPassword) {
//                performSegue(withIdentifier: "dismissLogin", sender: self)
//            } else {
//                // 8
//                showLoginFailedAlert()
//            }
        }
        
        
        let emailStr = emailField.text!
        let passStr = passField.text!
        
        if user == nil {
            // create user object
            user = User.init(uid: "", email: "")
            
        }
        // update user object
        if user.updateInfo(uid: "", email: emailStr) {
            // authenticate
            if user.authenticateUser(password: passStr) { // need to think about callback functionality
                // then segue
                displayAlert(title: "Success", message: "function in development")
            } else {
                displayAlert(title: "Error", message: "The email or password you have entered is incorrect")
            }
        } else {
            displayAlert(title: "Error", message: "You have entered an invalid email")
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
