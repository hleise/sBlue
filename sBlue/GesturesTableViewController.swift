//
//  GesturesTableViewController.swift
//  sBlue
//
//  Created by Hunter Leise on 8/4/16.
//  Copyright © 2016 Vivo Applications. All rights reserved.
//

import UIKit

class GesturesTableViewController: UITableViewController {
    @IBAction func unwindToGestures(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0: return customGestures.count + 1
        case 1: return defaultGestures.count
        default:
            print("Table View section was \(section), it should be 0 or 1")
            return -1
        }
    }
    
    private struct Storyboard {
        static let NewGestureCellIdentifier  = "New Gesture"
        static let MyGestureCellIdentifier = "My Gesture"
        static let DefaultGestureCellIdentifier = "Default Gesture"
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.NewGestureCellIdentifier, forIndexPath: indexPath)
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.MyGestureCellIdentifier, forIndexPath: indexPath)
                
                if let myGestureCell = cell as? MyGestureTableViewCell {
                    let data = customGestures[indexPath.row - 1]
                    myGestureCell.myGestureLabel.text = data[1]
                }
                
                return cell
            }
            
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.DefaultGestureCellIdentifier, forIndexPath: indexPath)
            
            if let defaultGestureCell = cell as? DefaultGestureTableViewCell {
                let data = defaultGestures[indexPath.row]
                defaultGestureCell.defaultGestureLabel?.text = data[1]
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.NewGestureCellIdentifier, forIndexPath: indexPath)
            print("indexPath.section was \(indexPath.section), it should be 0 or 1")
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "My Gestures"
        case 1: return "Default Gestures"
        default:
            print("Section number is \(section), but should be 0 or 1")
            return nil
        }
    }

    // Returns if you can swipe left on a given cell
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if (indexPath.section == 0) && (indexPath.row != 0) {
            return true
        } else {
            return false
        }
    }

    // Determines what to do when the user swipes left on a cell and selects delete
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            customGestures.removeAtIndex(indexPath.row - 1)
            tableView.reloadData()
        } 
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        precondition(segue.identifier == "toAddGesture" || segue.identifier == "toEditGesture", "Unknown Segue Identifier")
        
        if (segue.identifier == "toAddGesture") {
            let destination = segue.destinationViewController as! AddEditGestureTableViewController
            destination.gestureTableViewControllerType = "Add Gesture"
        } else {
            if let destination = segue.destinationViewController as? AddEditGestureTableViewController {
                destination.gestureTableViewControllerType = "Edit Gesture"
                
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    destination.gestureID = indexPath.row - 1 as Int
                    destination.gestureName = "Test"
                }
            }
        }
    }
    
    /*
    class oldgesturesTableViewController: UITableViewController {
        @IBOutlet weak var gesturesNavigation: UIButton!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false
            
            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        // MARK: - Table view data source
        
        override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return super.numberOfSectionsInTableView(tableView)
        }
        
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
        
        @IBAction func gesturesDropdownClicked(sender: UIButton) {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            alert.addAction(UIAlertAction(
                title: "My Gestures",
                style: .Default)
            { (action: UIAlertAction) -> Void in }
            )
            
            alert.addAction(UIAlertAction(
                title: "Default Gestures",
                style: .Default)
            { (action: UIAlertAction) -> Void in }
            )
            
            alert.addAction(UIAlertAction(
                title: "Cancel",
                style: .Cancel)
            { (action: UIAlertAction) -> Void in }
            )
            
            alert.modalPresentationStyle = .Popover
            let ppc = alert.popoverPresentationController
            ppc?.sourceView = gesturesNavigation
            
            presentViewController(alert, animated: true, completion: nil)
        }
        */

}
