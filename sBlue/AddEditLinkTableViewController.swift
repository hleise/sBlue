//
//  AddEditLinkTableViewController.swift
//  sBlue
//
//  Created by Hunter Leise on 8/5/16.
//  Copyright © 2016 Vivo Applications. All rights reserved.
//

import UIKit

protocol deleteLinkDelegate : class {
    func deleteLink(appName: String, contactName: String, gestureName: String)
}

protocol saveLinkDelegate : class {
    func newLink(appName: String, contactName: String, gestureName: String)
}


class AddEditLinkTableViewController: UITableViewController, AppsTableViewDelegate, ContactTableViewDelegate, GestureTableViewDelegate {
    
    weak var linkDeleteDelegate : deleteLinkDelegate?
    
    weak var linkSaveDelegate : saveLinkDelegate?
    
    
    var linkTableViewControllerType = String()
    var linkID = Int()
    var app = "None"
    var contact = "None"
    var gesture = "None"
    
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var gestureNameLabel: UILabel!
    @IBOutlet weak var linkTableViewControllerTitle: UINavigationItem!
    @IBOutlet weak var barButtonRight: UIBarButtonItem!
    @IBOutlet weak var deleteCell: UITableViewCell!
    
    @IBAction func unwindToAddEditLink(segue: UIStoryboardSegue) {}
    
    @IBAction func deleteLink(sender: AnyObject) {
        //use getNextAvailableID and set the rows to FFs
        contacts.removeAtIndex(getContactIndexWithContactID(links[linkID][1]))
        links.removeAtIndex(linkID)
        linkDeleteDelegate?.deleteLink(app, contactName: contact, gestureName: gesture)
    }
    
    @IBAction func saveLink(sender: AnyObject) {
        precondition(barButtonRight.title == "Done" || barButtonRight.title == "Save", "barButtonRight item \(barButtonRight.title) not recognized.")
        
        let contactID = getNextAvailableID(contacts)
        let gestureType = getGestureTypeWithName(gesture)
        
        if (barButtonRight.title == "Save") {
            //use getNextAvailableID and set that row
            contacts.append([contactID, getAppIDWithName(app), contact])
            links.append([getNextAvailableID(links), contactID, gestureType, getGestureIDWithName(gesture, gestureType: gestureType)])
            linkSaveDelegate?.newLink(app, contactName: contact, gestureName: gesture)
            
        } else {
            contacts[Int(links[linkID][1])!][1] = getAppIDWithName(app)
            contacts[Int(links[linkID][1])!][2] = contact
            links[linkID][2] = gestureType
            links[linkID][3] = getGestureIDWithName(gesture, gestureType: gestureType)
            linkSaveDelegate?.newLink(app, contactName: contact, gestureName: gesture)
        }
        
        performSegueWithIdentifier("unwindToGestures", sender: sender)
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
        
        self.title = linkTableViewControllerType
        linkTableViewControllerTitle.title = linkTableViewControllerType
        
        precondition(linkTableViewControllerType == "Add Link" || linkTableViewControllerType == "Edit Link", "Unknown linkTableViewControllerType")
        
        if (linkTableViewControllerType == "Add Link") {
            barButtonRight.title = "Save"
            deleteCell.hidden = true
        } else {
            barButtonRight.title = "Done"
            deleteCell.hidden = false
        }
        
        appNameLabel.text = app
        contactNameLabel.text = contact
        gestureNameLabel.text = gesture
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
    
    func setAppName(appName: String) {
        app = appName
    }
    
    func setContactName(contactName: String) {
        contact = contactName
    }
    
    func setGestureName(gestureName: String) {
        gesture = gestureName
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toSelectApp") {
            if let destination = segue.destinationViewController as? AppsTableViewController {
                destination.appName = app
                destination.delegate = self
            }
        } else if (segue.identifier == "toSelectContact"){
            if let destination = segue.destinationViewController as? ContactTableViewController {
                destination.contactName = contact
                destination.delegate = self
            }
        } else if (segue.identifier == "toSelectGesture"){
            if let destination = segue.destinationViewController as? GestureSelectionTableViewController {
                destination.gestureName = gesture
                destination.delegate = self
            }
        }
    }

}
