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
    
    // MARK: Constants
    let loginToAccounts = "LoginToAccounts"
    
    // MARK: - Variables
    var user: User!
    var progressHUD: ProgressHUD!
    
    // MARK: Properties
    
    // MARK: - Outlets
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create and add the progress view to the screen.
        progressHUD = ProgressHUD(text: "Logging in")
        self.view.addSubview(progressHUD)
        progressHUD.hide()
        
        
    
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
        // Check that text has been entered into both the username and password fields.
        guard let newAccountName = emailField.text,
            let newPassword = passField.text,
            !newAccountName.isEmpty,
            !newPassword.isEmpty else {
                displayAlert(title: "Missing Field", message: "Enter username and password")
                return
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
            progressHUD.show()
            user.authenticateUser(password: passStr, completion: completeLogin) 
        } else {
            displayAlert(title: "Error", message: "You have entered an invalid email")
        }
        
        // clear password field
        self.passField.text = ""
    }
    
    // on login complete, completion handler
    func completeLogin(result: Bool){
        progressHUD.hide()
        if result {
            //self.displayAlert(title: "Success", message: "You have been authenticated successfully")
            self.performSegue(withIdentifier: self.loginToAccounts, sender: nil)
        } else {
            self.displayAlert(title: "Error", message: "The email or password you have entered is incorrect")
        }
        
    }
    
    

    
    
    // MARK: - Navigation
    
    // pass user to next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navVC = segue.destination as? UINavigationController
        let tableVC = navVC?.viewControllers.first as! AccountsTableViewController
        tableVC.user = self.user
    }
}
    
    



