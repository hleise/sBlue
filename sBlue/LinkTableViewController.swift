//
//  LinkTableViewController.swift
//  sBlue
//
//  Created by Jose Canizares on 7/21/16.
//  Copyright © 2016 Vivo Applications. All rights reserved.
//

import UIKit

class LinkTableViewController: UITableViewController {
    @IBAction func unwindToLinks(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.LinkCellIdentifier, forIndexPath: indexPath)
        
        let data = links[indexPath.row]
        
        
        
        if let linkCell = cell as? LinkTableViewCell {
            
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
            
            for i in (0..<apps.count) {
                if apps[i][0] == contactApp {
                    
                linkCell.linkIcon.image = UIImage(named: "\(apps[i][1].lowercaseString)" + "Icon")
                    
                }
            }
            
            
        }
        
        return cell
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
