//
//  LinkTableViewController.swift
//  sBlue
//
//  Created by Jose Canizares on 7/21/16.
//  Copyright © 2016 Vivo Applications. All rights reserved.
//

import UIKit

class LinkTableViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBAction func unwindToLinks(segue: UIStoryboardSegue) {}
    
    var links = [Link]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        links.append(Link(app: "facebook", profiles: ["Michael"], gesture: "Dancing"))
        links.append(Link(app: "twitter", profiles: ["José"], gesture: "LED (Red)"))
        links.append(Link(app: "facebook", profiles: ["Hunter"], gesture: "Twirl"))
        links.append(Link(app: "messages", profiles: ["John"], gesture: "LED (Blue)"))
        links.append(Link(app: "messages", profiles: ["William"], gesture: "LED (Flash Red)"))
        links.append(Link(app: "facebook", profiles: ["Anna"], gesture: "Walk)"))
        links.append(Link(app: "twitter", profiles: ["Chris"], gesture: "Shake"))
        links.append(Link(app: "twitter", profiles: ["Mark"], gesture: "Sit"))
        links.append(Link(app: "messages", profiles: ["Bill Gates"], gesture: "LED (Flash Green)"))
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.tableView.contentOffset.y == 0 {
            self.tableView.contentOffset = CGPoint(x: 0.0, y: self.searchBar.frame.size.height)
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return links.count
    }
    
    private struct Storyboard {
        static let LinkCellIdentifier = "LinkPrototype"
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.LinkCellIdentifier, forIndexPath: indexPath)
        if let linkCell = cell as? LinkTableViewCell {
            
            let linkData = links[indexPath.row]
            
            linkCell.SenderName?.text = linkData.profiles[0]
            linkCell.GestureName?.text = linkData.gesture
            linkCell.AppIcon?.image = UIImage(named: "\(linkData.app)Icon")
//            linkCell.Linkage?.backgroundColor = UIColor(red: 0.8, green: 0.6, blue: 0.5, alpha: 1.0)
            
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
