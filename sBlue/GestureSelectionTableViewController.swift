//
//  GestureSelectionTableViewController.swift
//  sBlue
//
//  Created by Hunter Leise on 8/5/16.
//  Copyright © 2016 Vivo Applications. All rights reserved.
//

import UIKit

class GestureSelectionTableViewController: UITableViewController {
    
    var gestureName = String()

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
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0: return customGestures.count
        case 1: return defaultGestures.count
        default:
            print("Table View section was \(section), it should be 0 or 1")
            return -1
        }
    }
    
    private struct Storyboard {
        static let MyGestureCellIdentifier = "My Gesture"
        static let DefaultGestureCellIdentifier = "Default Gesture"
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.MyGestureCellIdentifier, forIndexPath: indexPath)
            
            if let myGestureCell = cell as? MyGestureTableViewCell {
                let data = customGestures[indexPath.row]
                myGestureCell.myGestureLabel.text = data[1]
                
                if (gestureName == data[1]) {
                    myGestureCell.accessoryType = .Checkmark
                } else {
                    myGestureCell.accessoryType = .None
                }
            }
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.DefaultGestureCellIdentifier, forIndexPath: indexPath)
            
            if let defaultGestureCell = cell as? DefaultGestureTableViewCell {
                let data = defaultGestures[indexPath.row]
                defaultGestureCell.defaultGestureLabel?.text = data[1]
                
                if (gestureName == data[1]) {
                    defaultGestureCell.accessoryType = .Checkmark
                } else {
                    defaultGestureCell.accessoryType = .None
                }
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.MyGestureCellIdentifier, forIndexPath: indexPath)
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        precondition(indexPath.section == 0 || indexPath.section == 1, "Unknown Index Path Section \(indexPath.section)")
        
        if (indexPath.section == 0) {
            let data = customGestures[indexPath.row]
            gestureName = data[1]
        } else {
            let data = defaultGestures[indexPath.row]
            gestureName = data[1]
        }
        
        tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
