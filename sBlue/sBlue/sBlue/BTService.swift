//
//  BTService.swift
//  Arduino_Servo
//
//  Created by Owen L Brown on 10/11/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import Foundation
import CoreBluetooth

var selectedCharUUID : CBUUID? = nil

/* Services & Characteristics UUIDs */
let BLEServiceUUID = CBUUID(string: "A7DD6091-F051-B715-6B1E-EF10A2AA9F7A")
let PositionCharUUID = CBUUID(string: "A7DD6091-F051-B715-6B1E-EF10A2AA9F7B")
let PositionCharUUID1 = CBUUID(string: "A7DD6091-F051-B715-6B1E-EF10A2AA9F7C")
let PositionCharUUID2 = CBUUID(string: "A7DD6091-F051-B715-6B1E-EF10A2AA9F7D")
let PositionCharUUID3 = CBUUID(string: "A7DD6091-F051-B715-6B1E-EF10A2AA9F7E")

let BLEServiceUUID2 = CBUUID(string: "B7DD6091-F051-B715-6B1E-EF10A2AA9F7A")
let PositionCharUUID4 = CBUUID(string: "B7DD6091-F051-B715-6B1E-EF10A2AA9F7B")

let BLEServiceChangedStatusNotification = "kBLEServiceChangedStatusNotification"

class BTService: NSObject, CBPeripheralDelegate {
  var peripheral: CBPeripheral?
  var positionCharacteristic: CBCharacteristic?
  
  init(initWithPeripheral peripheral: CBPeripheral) {
    super.init()
    
    self.peripheral = peripheral
    self.peripheral?.delegate = self
  }
  
  deinit {
    self.reset()
  }
  
  func startDiscoveringServices() {
    self.peripheral?.discoverServices([BLEServiceUUID, BLEServiceUUID2])
  }
  
  func reset() {
    if peripheral != nil {
      peripheral = nil
    }
    
    // Deallocating therefore send notification
    self.sendBTServiceNotificationWithIsBluetoothConnected(false)
  }
  
  // Mark: - CBPeripheralDelegate
  
  func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
    let uuidsForBTService: [CBUUID] = [PositionCharUUID, PositionCharUUID1, PositionCharUUID2, PositionCharUUID3, PositionCharUUID4]
    
    if (peripheral != self.peripheral) {
      // Wrong Peripheral
      return
    }
    
    if (error != nil) {
      return
    }
    
    if ((peripheral.services == nil) || (peripheral.services!.count == 0)) {
      // No Services
      return
    }
    
    for service in peripheral.services! {
      if service.UUID == BLEServiceUUID {
        peripheral.discoverCharacteristics(uuidsForBTService, forService: service)
      }
      if service.UUID == BLEServiceUUID2 {
        peripheral.discoverCharacteristics(uuidsForBTService, forService: service)
      }
    }
  }
  
  func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
    if (peripheral != self.peripheral) {
      // Wrong Peripheral
      return
    }
    
    if (error != nil) {
      return
    }
    
    if let characteristics = service.characteristics {
        print("selectedCharUUID: \(selectedCharUUID)")
      for characteristic in characteristics
      {
        if characteristic.UUID == selectedCharUUID {
          self.positionCharacteristic = (characteristic)
          peripheral.setNotifyValue(true, forCharacteristic: characteristic)
          
          // Send notification that Bluetooth is connected and all required characteristics are discovered
          self.sendBTServiceNotificationWithIsBluetoothConnected(true)
        }
      }
    }
  }
  
  // Mark: - Private
  
    func writeCode(code: UInt) {
        print("writeposition: \(code)")
        // See if characteristic has been discovered before writing to it
        if let positionCharacteristic = self.positionCharacteristic {
            // Need a mutable var to pass to writeValue function
            //little endian
            var positionValue = 0
            if (code == 1) {
                positionValue = 84017665
            }
            if (code == 2) {
                positionValue = 84017409
            }
            
            //Keep this as UInt8 in NSData
        let data = NSData(bytes: &positionValue, length: sizeof(UInt8))
        
            //without response for Arduino Uno
            //with response for Arduino 101
            self.peripheral?.writeValue(data, forCharacteristic: positionCharacteristic, type: CBCharacteristicWriteType.WithResponse)
           
        }
    }
  
  func sendBTServiceNotificationWithIsBluetoothConnected(isBluetoothConnected: Bool) {
    let connectionDetails = ["isConnected": isBluetoothConnected]
    NSNotificationCenter.defaultCenter().postNotificationName(BLEServiceChangedStatusNotification, object: self, userInfo: connectionDetails)
  }
  
}