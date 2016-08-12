//
//  DeviceViewController.swift
//  sBlue
//
//  Created by Hunter Leise on 7/23/16.
//  Copyright © 2016 Vivo Applications. All rights reserved.
//

import UIKit

class DeviceViewController: UIViewController, deleteLinkDelegate, saveLinkDelegate {
    @IBOutlet weak var linksTableView: UIView!
    @IBOutlet weak var gesturesTableView: UIView!
    
    
    @IBOutlet weak var connectionLabel: UIBarButtonItem!
    
    @IBAction func sendSomething(sender: UIBarButtonItem) {
        sendCode("00", characteristic: 4)
    }
    
    
    
    var timerTXDelay: NSTimer?
    var allowTX = true
    var selectedCharacteristic : Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(animated: Bool)
    {
        print("selected characteristic: \(selectedCharacteristic)")
        if self.selectedCharacteristic == nil {
            chosenCharacteristic = 4
        }
        
        // Watch Bluetooth connection
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DeviceViewController.connectionChanged(_:)), name: BLEServiceChangedStatusNotification, object: nil)
        
        // Start the Bluetooth discovery process
        btDiscoverySharedInstance
        
        connectionLabel.title = "✕"
        
        
        
    
    }
    
    
    //deinit called right before MVC leaves the heap
    deinit {
        //btDiscoverySharedInstance.bleService?.reset()
        print("deallocated")
        NSNotificationCenter.defaultCenter().removeObserver(self, name: BLEServiceChangedStatusNotification, object: nil)
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.stopTimerTXDelay()
    }
    
    func connectionChanged(notification: NSNotification) {
        // Connection status changed. Indicate on GUI.
        let userInfo = notification.userInfo as! [String: Bool]
        
        dispatch_async(dispatch_get_main_queue(), {
            if let isConnected: Bool = userInfo["isConnected"] {
                if isConnected {
                    if (self.connectionLabel != nil) {
                        self.connectionLabel.title = "✓"
                    }
                    
                    print("connected")
                    
                    // Send current slider position
                    //self.sendGesture(UInt( self.positionSlider.value))
                } else if (self.connectionLabel != nil) {
                    self.connectionLabel.title = "✕"
                    print("disconnected")
                    
                }
            }
        });
    }
    
    // Valid position range: 0 to 180
    func sendCode(code: String, characteristic: Int) {
        if !allowTX {
            return
        }
        
        // Send code to BLE Shield (if service exists and is connected)
        if let bleService = btDiscoverySharedInstance.bleService {
            bleService.writeCode(code, characteristic: characteristic)
            
            // Start delay timer
            allowTX = false
            if timerTXDelay == nil {
                timerTXDelay = NSTimer.scheduledTimerWithTimeInterval(0.1,
                                                                      target: self,
                                                                      selector: #selector(DeviceViewController.timerTXDelayElapsed),
                                                                      userInfo: nil,
                                                                      repeats: false)
            }
        }
    }
    
    func timerTXDelayElapsed() {
        self.allowTX = true
        self.stopTimerTXDelay()
        
    }
    
    func stopTimerTXDelay() {
        if self.timerTXDelay == nil {
            return
        }
        
        timerTXDelay?.invalidate()
        self.timerTXDelay = nil
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
    
    
    func deleteGesture(gestureName: String) {
        
        var code = ""
        
        if let command = commands["clear"] {
            code = command
        }
        code += getGestureIDWithName(gestureName, gestureType: "01")
        
        
        code += "FFFF"
        
        sendCode(code, characteristic: 1)
    }
    
    func deleteLink(appName: String, contactName: String, gestureName: String) {
        
        //link id, gesture id, profile id,
        
        var code = ""
        
        if let command = commands["clear"] {
            code = command
        }
        
        //let type = getGestureTypeWithName(gestureName)
        
//        if type == "01" {
//            code += getGestureIDWithName(gestureName, gestureType: "01")
//        } else {
//            code += getGestureIDWithName(gestureName, gestureType: "00")
//        }
        
        code += getGestureIDWithName(gestureName, gestureType: "00")
        
        code += "FFFF"
        
        sendCode(code, characteristic: 3)
    }
    
    
    func deleteLink2(contactName: String, gestureName: String) {
        var code = ""
        if let command = commands["clear"] {
            code = command
        }
        let contactID = getContactIDWithName(contactName)
        let type = getGestureTypeWithName(gestureName)
        
        if type == "01" {
            code += getGestureIDWithName(gestureName, gestureType: "01")
        } else {
            code += getGestureIDWithName(gestureName, gestureType: "00")
        }
        code += "FFFF"
        sendCode(code, characteristic: 1)
    }
    
    
    func newGesture(gestureName: String) {
        var code = ""
        if let command = commands["clear"] {
            code = command
        }
        code += getGestureIDWithName(gestureName, gestureType: "01")
        code += "FFFF"
        sendCode(code, characteristic: 1)
    }
    
    
    func newLink(appName: String, contactName: String, gestureName: String) {
        
        //ADD LINK FORMAT: command "modify", link id, gesture id, profile/contact id
        
        var addLinkCode = ""
        if let command = commands["modify"] {
            print("MODIFY")
            addLinkCode = command
        }
        
            let contactID = getContactIDWithName(contactName)
        
        addLinkCode += getLinkIDWithContactID(contactID)
        
        let type = getGestureTypeWithName(gestureName)
        if type == "01" {
            addLinkCode += getGestureIDWithName(gestureName, gestureType: "01")
        } else {
            addLinkCode += getGestureIDWithName(gestureName, gestureType: "00")
        }
        
        addLinkCode += contactID
        
        
        //send add link code to bluetooth device
        sendCode(addLinkCode, characteristic: 3)

        //ADD CONTACT FORMAT: command "modify", contact id, app id, size, 12 bytes
        //only if contact does not already exist
        
        if contactID == "FF" {
            
            var addContactCode = ""
            if let command = commands["modify"] {
                addContactCode = command
            }
            
            addContactCode += contactID
            addContactCode += "0C"
            print(String(contactName.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)))
            //code2 += String(contactName.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
            addContactCode += "@andresrubio"
            print(contactName.trunc(contactName.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)))
            //code2 += contactName.trunc(contactName.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
            
            
            /*timerTXDelay = NSTimer.scheduledTimerWithTimeInterval(0.1,
             target: self,
             selector: #selector(DeviceViewController.timerTXDelayElapsed),
             userInfo: nil,
             repeats: false)*/
            //send add contact code to bluetooth device
            //sendCode(code2, characteristic: 2)

            
            print("contact does not already exist, so we created a new one.")
        }
        
        
    }
    
    
    

}



extension String {
    func trunc(length: Int, trailing: String? = "...") -> String {
        if self.characters.count > length {
            return self.substringToIndex(self.startIndex.advancedBy(length)) + (trailing ?? "")
        } else {
            return self
        }
    }
}
