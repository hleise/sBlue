//
//  AddEditGestureTableViewController.swift
//  sBlue
//
//  Created by Hunter Leise on 8/5/16.
//  Copyright © 2016 Vivo Applications. All rights reserved.
//

import UIKit

class AddEditGestureTableViewController: UITableViewController {

    var gestureTableViewControllerType = String()
    var gestureName = String()
    var gestureID = Int()
    
    @IBOutlet weak var gestureTableViewControllerTitle: UINavigationItem!
    @IBOutlet weak var barButtonRight: UIBarButtonItem!
    @IBOutlet weak var deleteCell: UITableViewCell!
    @IBOutlet weak var gesture1Label: UILabel!
    @IBOutlet weak var gesture2Label: UILabel!
    @IBOutlet weak var gesture3Label: UILabel!
    @IBOutlet weak var gesture4Label: UILabel!
    @IBOutlet weak var gesture5Label: UILabel!
    
    @IBAction func deleteLink(sender: AnyObject) {
        customGestures.removeAtIndex(gestureID)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        
        //var labelArray = [gesture1Label, gesture2Label, gesture3Label, gesture4Label, gesture5Label]
        for i in 0..<5 {
            precondition(links[gestureID][2] == "00" || links[gestureID][2] == "01", "Unknown Gesture Type \(links[i][2])")
            
            //labelArray[i].text = defaultGestures[Int(customGestures[gestureID][i + 2])!][1]
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

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toSelectGesture") {
            let destination = segue.destinationViewController as! GestureSelectionTableViewController
            destination.gestureName = "Dancing"
        }
    }

}
