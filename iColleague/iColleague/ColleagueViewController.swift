//
//  ColleagueViewController.swift
//  iColleague
//
//  Created by Group7 on 10/13/16.
//  Copyright © 2016 Group7. All rights reserved.
//

/// This is a comment

import UIKit

class ItemsViewController: UITableViewController{
    
    var itemStore: ColleagueStore!
    
    @IBAction func addNewItem(sender: AnyObject) {
        // create new item
        let newItem = ColleagueStore.createColleague()
        
        // Figure out where that item is in the array
        if let index = itemStore.allItems.indexOf(newItem) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            
            // Insert this new row into the table.
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject) {
        if editing {
            // Change text of button to inform user of state
            sender.setTitle("Edit", forState: .Normal)
            
            // Turn off editing mode
            setEditing(false, animated: true)
        }
        else {
            // Change text of button to inform user of state
            sender.setTitle("Done", forState: .Normal)
            
            // Enter editing mode
            setEditing(true, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the height of the status bar
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ColleagueStore.allItems.count
    }
    
    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell, with default appearance
        //let cell = UITableViewCell(style: .Value1, reuseIdentifier:"​U​I​T​a​b​l​e​V​i​e​w​C​e​l​l​")
        
        //        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell",
                                                               forIndexPath: indexPath) as! ItemCell        // Set the text on the cell with the description of the item
        
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        let item = ColleagueStore.allItems[indexPath.row]
        
        cell.nameLabel?.text = item.name
        cell.valueLabel?.text = "$\(item.valueInDollars)"
        cell.serialNumberLabel?.text = item.serialNumber
        
        return cell
    }
    
    // delete row frontend
    //
    //3 step process:
    
    //    a. create an alert control (UIAlertController)
    //    title. message and style
    //    b. Add actions (UIAlertAction)
    //    delete, cancel, OK…
    //    c. Display it (presentViewController)
    
    
    override func tableView(tableView: UITableView,
                            commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                                               forRowAtIndexPath indexPath: NSIndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .Delete {
            let item = ColleagueStore.allColleague[indexPath.row]
            
            //Step-a. Create an alert
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .ActionSheet)
            
            //Step-b. Add actions
            //a. cancel button
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            
            ac.addAction(cancelAction)
            
            //b. delete button
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive,
                                             handler: { (action) -> Void in
                                                // Remove the item from the store
                                                self.itemStore.removeItem(item)
                                                
                                                // Also remove that row from the table view with an animation
                                                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
            
            ac.addAction(deleteAction)
            
            
            //c. Present the alert controller
            presentViewController(ac, animated: true, completion: nil)
            
            
        }
    }
    
    override func tableView(tableView: UITableView,
                            moveRowAtIndexPath sourceIndexPath: NSIndexPath,
                                               toIndexPath destinationIndexPath: NSIndexPath) {
        // Update the model
        itemStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // If the triggered segue is the "ShowItem" segue
        if segue.identifier == "ShowItem" {
            
            // Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                
                // Get the item associated with this row and pass it along
                let item = ColleagueStore.allItems[row]
                let detailViewController = segue.destinationViewController as! DetailViewController
                detailViewController.item = item
            }
        }
    }
}
