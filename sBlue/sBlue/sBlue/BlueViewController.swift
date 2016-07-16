//
//  ViewController.swift
//  sBlue
//
//  Created by Jose Canizares on 5/29/16.
//  Copyright © 2016 Sinnply Blue. All rights reserved.
//

import UIKit

class BlueViewController: UIViewController, UITextFieldDelegate {
    
    var timerTXDelay: NSTimer?
    var allowTX = true
    var selectedCharacteristic : Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textbox.delegate = self //set delegate to self
    }
    
    
    override func viewWillAppear(animated: Bool)
    {
        print("selected characteristic: \(selectedCharacteristic)")
        if self.selectedCharacteristic != nil {
            chosenCharacteristic = selectedCharacteristic
        }
        
        // Watch Bluetooth connection
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BlueViewController.connectionChanged(_:)), name: BLEServiceChangedStatusNotification, object: nil)
        
        // Start the Bluetooth discovery process
        
        btDiscoverySharedInstance
        
        ConnectionLabel.text = "Connected to Characteristic \(selectedCharacteristic)"
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
    
    
    @IBOutlet weak var ConnectionLabel: UILabel! {
        didSet {
            
        }
    }
    
    
    @IBOutlet weak var textbox: UITextField!
    
    
    @IBAction func sendMessage(sender: UIButton) {
        if let text = textbox.text {
            sendCode(UInt(text) ?? 0)
        }
    }
    
    func connectionChanged(notification: NSNotification) {
        // Connection status changed. Indicate on GUI.
        let userInfo = notification.userInfo as! [String: Bool]
        
        dispatch_async(dispatch_get_main_queue(), {
            if let isConnected: Bool = userInfo["isConnected"] {
                if isConnected {
                    if (self.ConnectionLabel != nil) {
                        self.ConnectionLabel.text = "Connected to Characteristic \(self.selectedCharacteristic)"
                    }
                    
                    print("connected")
                    
                    // Send current slider position
                    //self.sendGesture(UInt( self.positionSlider.value))
                } else if (self.ConnectionLabel != nil) {
                    self.ConnectionLabel.text = "Disconnected"
                    print("Disconnected")
                    
                }
            }
        });
    }
    

    
    // Valid position range: 0 to 180
    func sendCode(code: UInt) {
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
                                                                      selector: #selector(BlueViewController.timerTXDelayElapsed),
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}



