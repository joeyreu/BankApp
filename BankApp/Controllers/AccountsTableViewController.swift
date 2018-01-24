//
//  AccountsTableViewController.swift
//  BankApp
//
//  Created by Joseph Reusing on 2018-01-22.
//  Copyright © 2018 reusjos. All rights reserved.
//

import UIKit

class AccountsTableViewController: UITableViewController {
    
    var user: User!
    var progressHUD: ProgressHUD!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create and add the progress view to the screen.
        progressHUD = ProgressHUD(text: "Loading Accounts")
        self.view.addSubview(progressHUD)
        
        
        // load accounts on database update - reload data
        user.loadAccounts() {
            (result) in
            if result {
                self.tableView.reloadData()
                self.progressHUD.hide()
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Get Accounts and info from database
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return user.spendingAccounts.count
        } else {
            return user.savingAccounts.count
        }
        //return user.accounts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath)
        if let accCell = cell as? AccountTableViewCell {
            // Configure the cell...
            var account: Account
            if indexPath.section == 0 {
                account = self.user.spendingAccounts[indexPath.row]
            } else {
                account = self.user.savingAccounts[indexPath.row]
            }
            
            accCell.AccountName.text! = account.accName.description
            accCell.AccountNumber.text! = account.accNum.description
            accCell.AccountBalance.text! = String(format: "%.2f", account.accBal)
        }
        
        return cell
            
        
    }

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Spending"
        } else{
            return "Saving"
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navVC = segue.destination as? TransactionTableViewController
        navVC?.user = self.user
        
        let indexPath = tableView.indexPathForSelectedRow
        if indexPath?.section == 0 {
            navVC?.account = self.user.spendingAccounts[(indexPath?.row)!]
        } else {
            navVC?.account = self.user.savingAccounts[(indexPath?.row)!]
        }
    }
 
    
    @IBAction func logoutPressed(_ sender: Any) {
        print("logout")
        let progressHUD2 = ProgressHUD(text: "Logging Out")
        self.view.addSubview(progressHUD2)
        progressHUD2.show()
        self.user.logout() {
            _ in
            progressHUD2.hide()
            self.dismiss(animated: true, completion: nil) // dismiss modal view
        }
    }
    

    

}
