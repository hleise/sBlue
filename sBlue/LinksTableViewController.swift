//
//  LinksTableViewController.swift
//  sBlue
//
//  Created by Jose Canizares on 7/21/16.
//  Copyright © 2016 Vivo Applications. All rights reserved.
//

import UIKit

class LinksTableViewController: UITableViewController {
    @IBAction func unwindToLinks(segue: UIStoryboardSegue) {}
    
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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        } else {
            return links.count
        }
    }
    
    
    private struct Storyboard {
        static let NewLinkCellIdentifier  = "New Link"
        static let LinkCellIdentifier = "Link"
    }
    
    override func tableView(tv: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch(indexPath.section){
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.NewLinkCellIdentifier, forIndexPath: indexPath)
                
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.LinkCellIdentifier, forIndexPath: indexPath)
                
                if let linkCell = cell as? LinksTableViewCell {
                    let data = links[indexPath.row]
                    for i in (0..<contacts.count) {
                        if contacts[i][0] == data[1] {
                            linkCell.linkContact.text = contacts[i][2]
                        }
                    }
                    
                    //custom gesture
                    if data[2] == "01" {
                        for i in (0..<customGestures.count) {
                            if customGestures[i][0] == data[3] {
                                linkCell.linkGesture.text = customGestures[i][1]
                            }
                        }
                    } else {
                        for i in (0..<defaultGestures.count) {
                            if defaultGestures[i][0] == data[3] {
                                linkCell.linkGesture.text = defaultGestures[i][1]
                            }
                        }
                    }
                    
                    //contact name
                    var contactApp = ""
                    for i in (0..<contacts.count) {
                        if contacts[i][0] == data[1] {
                            contactApp = contacts[i][1]
                        }
                    }
                    
                    // app icon
                    for i in (0..<apps.count) {
                        if apps[i][0] == contactApp {
                            linkCell.linkIcon.image = UIImage(named: "\(apps[i][1].lowercaseString)" + "Icon")
                            linkCell.linkApp = apps[i][1]
                        }
                    }
                }
                
            return cell

        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.NewLinkCellIdentifier, forIndexPath: indexPath)
            return cell
        }
    }
    
    // Returns if you can swipe left on a given cell
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if (indexPath.section == 0) {
            return false
        } else if (indexPath.section == 1) {
            return true
        } else {
            print("Section was \(indexPath.section), but should be 0 or 1")
            return false
        }
     }
    
    // Determines what to do when the user swipes left on a cell and selects delete
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
         if editingStyle == .Delete {
            contacts.removeAtIndex(lookUpContactIndexWithContactID(links[indexPath.row][1]))
            links.removeAtIndex(indexPath.row)
            tableView.reloadData()
         }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        precondition(segue.identifier == "toAddLink" || segue.identifier == "toEditLink", "Unknown Segue Identifier \(segue.identifier)")
        
        if (segue.identifier == "toAddLink") {
            let destination = segue.destinationViewController as! AddEditLinkTableViewController
            destination.linkTableViewControllerType = "Add Link"
        } else {
            let destination = segue.destinationViewController as! AddEditLinkTableViewController
            destination.linkTableViewControllerType = "Edit Link"
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                destination.linkID = indexPath.row as Int
                
                // get the cell associated with the indexPath selected.
                let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! LinksTableViewCell
                destination.app = cell.linkApp
                destination.contact = cell.linkContact.text!
                destination.gesture = cell.linkGesture.text!
            }
        }
    }
    
}
