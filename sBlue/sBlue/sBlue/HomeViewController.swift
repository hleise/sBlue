//
//  HomeViewController.swift
//  sBlue
//
//  Created by Jose Canizares on 7/2/16.
//  Copyright © 2016 Sinnply Blue. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if let vc = segue.destinationViewController as? BlueViewController {
                switch identifier {
                case "Show Gestures":
                        vc.selectedCharacteristic = 1
                        print("1")
       1         case "Show Elements":
                        vc.selectedCharacteristic = 2
                        print("2")
                case "Show Profile":
                        vc.selectedCharacteristic = 3
                        print("3")
                case "Show Links":
                        vc.selectedCharacteristic = 4
                        print("4")
                default: break
                }

            }
        }
    }
    

}
