//
//  TransactionTableViewController.swift
//  BankApp
//
//  Created by Joseph Reusing on 2018-01-23.
//  Copyright © 2018 reusjos. All rights reserved.
//

import UIKit

class TransactionTableViewController: UITableViewController {
    
    var user: User!
    var account: Account!
    var progressHUD: ProgressHUD!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("LOADING TRANSACTIONS")
        // Create and add the progress view to the screen.
        progressHUD = ProgressHUD(text: "Loading Accounts")
        self.view.addSubview(progressHUD)
        self.title = "\(self.account.accName)"
        user.loadTransactions(acc: account) {
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.user.transactionList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransCell", for: indexPath)
        if let transCell = cell as? TransactionTableViewCell {
            // Configure the cell...
            var transaction: Transaction
            if indexPath.section == 0 {
                transaction = self.user.transactionList[indexPath.row]
            } else {
                transaction = self.user.transactionList[indexPath.row]
            }
            
            transCell.vendor.text! = transaction.vendor.description
            
            let date = Date(timeIntervalSince1970: TimeInterval(transaction.dateTime))
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a"
            let dateString = dayTimePeriodFormatter.string(from: date)
            
            transCell.dateTime.text! = dateString
            
            if transaction.type == "Debit" {
                transCell.amount.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                transCell.amount.text! = "-\(String(format: "%.2f", transaction.amount))"
            } else {
                transCell.amount.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                transCell.amount.text! = "+\(String(format: "%.2f", transaction.amount))"
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Change the selected background view of the cell.
        tableView.deselectRow(at: indexPath, animated: true)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension UINavigationItem{
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        
        
//        let font = UIFont.systemFont(ofSize: 12)
//        backItem.setTitleTextAttributes([NSAttributedStringKey.font:font], for: .normal)
        
        /*Changing color*/
        //backItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.green], for: .normal)
        
        self.backBarButtonItem = backItem
    }
    
}
