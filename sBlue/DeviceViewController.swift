//
//  DeviceViewController.swift
//  sBlue
//
//  Created by Hunter Leise on 7/23/16.
//  Copyright © 2016 Vivo Applications. All rights reserved.
//

import UIKit

class DeviceViewController: UIViewController {
    @IBOutlet weak var linksTableView: UIView!
    @IBOutlet weak var gesturesTableView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showComponent(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UIView.animateWithDuration(0, animations: {
                self.linksTableView.alpha = 1
                self.gesturesTableView.alpha = 0
            })
        } else {
            UIView.animateWithDuration(0, animations: {
                self.linksTableView.alpha = 0
                self.gesturesTableView.alpha = 1
            })
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
