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
    
    
    @IBOutlet weak var connectionLabel: UIBarButtonItem!
    
    @IBAction func sendSomething(sender: UIBarButtonItem) {
        sendCode("00")
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
        
        connectionLabel.title = "\(selectedCharacteristic)"
    
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
                        self.connectionLabel.title = "\(self.selectedCharacteristic)"
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
    func sendCode(code: String) {
        if !allowTX {
            return
        }
        
        // Send code to BLE Shield (if service exists and is connected)
        if let bleService = btDiscoverySharedInstance.bleService {
            bleService.writeCode(code)
            
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

}
