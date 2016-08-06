//
//  AddEditGestureTableViewController.swift
//  sBlue
//
//  Created by Hunter Leise on 8/5/16.
//  Copyright © 2016 Vivo Applications. All rights reserved.
//

import UIKit

class AddEditGestureTableViewController: UITableViewController, DefaultGesturesSelectionTableViewDelegate {

    var gestureTableViewControllerType = String()
    var gestureName = String()
    var gestureSlots = [String](count: 5, repeatedValue: "None")
    var gestureID = Int()
    
    @IBOutlet weak var gestureTableViewControllerTitle: UINavigationItem!
    @IBOutlet weak var barButtonRight: UIBarButtonItem!
    @IBOutlet weak var gestureNameTextField: UITextField!
    @IBOutlet weak var deleteCell: UITableViewCell!
    @IBOutlet weak var gesture1Label: UILabel!
    @IBOutlet weak var gesture2Label: UILabel!
    @IBOutlet weak var gesture3Label: UILabel!
    @IBOutlet weak var gesture4Label: UILabel!
    @IBOutlet weak var gesture5Label: UILabel!
    
    @IBAction func deleteLink(sender: AnyObject) {
        customGestures.removeAtIndex(gestureID)
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gestureNameTextField.text = gestureName
        var labelArray = [gesture1Label, gesture2Label, gesture3Label, gesture4Label, gesture5Label]
        for i in 0..<5 {
            let defaultGestureID = Int(customGestures[gestureID][i + 2])
            
            if (defaultGestureID == nil) {
                labelArray[i].text = "None"
            } else {
                gestureSlots[i] = defaultGestures[defaultGestureID!][1]
                labelArray[i].text = gestureSlots[i]
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = gestureTableViewControllerType
        gestureTableViewControllerTitle.title = gestureTableViewControllerType
        
        precondition(gestureTableViewControllerType == "Add Gesture" || gestureTableViewControllerType == "Edit Gesture", "Unknown gestureTableViewControllerType")
        
        if (gestureTableViewControllerType == "Add Gesture") {
            barButtonRight.title = "Save"
            deleteCell.hidden = true
        } else {
            barButtonRight.title = "Done"
            deleteCell.hidden = false
        }
        
        var labelArray = [gesture1Label, gesture2Label, gesture3Label, gesture4Label, gesture5Label]
        for i in 0..<5 {
            labelArray[i].text = gestureSlots[i]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return super.numberOfSectionsInTableView(tableView)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return super.tableView(tableView, numberOfRowsInSection: section)
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
    
    func setDefaultGesture(defaultGestureName: String, gestureNum: Int) {
        gestureSlots[gestureNum] = defaultGestureName
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toSelectDefaultGesture") {
            if let destination = segue.destinationViewController as? DefaultGestureSelectionTableViewController {
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    destination.gestureName = gestureSlots[indexPath.row]
                    destination.gestureNum = indexPath.row
                    destination.delegate = self
                }
            }
        }
    }

}
