//
//  BTService.swift
//  Arduino_Servo
//
//  Created by Owen L Brown on 10/11/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import Foundation
import CoreBluetooth

var chosenCharacteristic : Int? = nil

/* Services & Characteristics UUIDs */
let BLEServiceUUID = CBUUID(string: "A7DD6091-F051-B715-6B1E-EF10A2AA9F7A")

let PositionCharUUID = CBUUID(string: "A7DD6091-F051-B715-6B1E-EF10A2AA9F7B")
let PositionCharUUID1 = CBUUID(string: "A7DD6091-F051-B715-6B1E-EF10A2AA9F7C")
let PositionCharUUID2 = CBUUID(string: "A7DD6091-F051-B715-6B1E-EF10A2AA9F7D")
let PositionCharUUID3 = CBUUID(string: "A7DD6091-F051-B715-6B1E-EF10A2AA9F7E")


let BLEServiceUUID2 = CBUUID(string: "B8DD6091-F051-B715-6B1E-EF10A2AA9F7A")

let PositionCharUUID4 = CBUUID(string: "A7DD6091-F051-B715-6B1E-EF10A2AA9F8F")


let BLEServiceChangedStatusNotification = "kBLEServiceChangedStatusNotification"

class BTService: NSObject, CBPeripheralDelegate {
  
    var peripheral: CBPeripheral?
    
    var blueCharacteristics: [CBCharacteristic?] = [CBCharacteristic]()
  
    init(initWithPeripheral peripheral: CBPeripheral) {
        super.init()
    
        self.peripheral = peripheral
        self.peripheral?.delegate = self
    }
  
    deinit {
        self.reset()
    }
  
    func startDiscoveringServices() {
        //put services in this array
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
        //let uuidsForBTService2: [CBUUID] = [PositionCharUUID4]
        
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
//            if service.UUID == BLEServiceUUID2 {
//                peripheral.discoverCharacteristics(uuidsForBTService, forService: service)
//            }
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
          for (index, characteristic) in characteristics.enumerate()
          {
            print(service.characteristics?.count)
            print(characteristics.enumerate())
            print("\(characteristics[index].UUID)")
            
            //keep a list of all characteristics. (very first element here is nil I think)
            self.blueCharacteristics.append(characteristic)
            
            //"subscribe" to this characteristic.
            peripheral.setNotifyValue(true, forCharacteristic: characteristic)
            
            // Send notification that Bluetooth is connected and all required characteristics are discovered.
            self.sendBTServiceNotificationWithIsBluetoothConnected(true)
            
            
          }
            
            
        }
      }
      
    // Mark: - Private
      
    func writeCode(code: String) {
        print("writeposition: \(code)")
        // See if characteristic has been discovered before writing to it
        if chosenCharacteristic != nil {
            //this is the current characteristic
            if let blueCharacteristic = self.blueCharacteristics[chosenCharacteristic!] {
                // Need a mutable var to pass to writeValue function
                //little endian

//                let codeArray : [UInt8] = Array(code.utf8)
//                print(codeArray)
                //to utf8 decimals
                
                
//                let string = "00020505"
//                
                //array of uint8s
                var numbers = [UInt8]()
                
                var from = code.startIndex
                while from != code.endIndex {
                    let to = from.advancedBy(2, limit: code.endIndex)
                    numbers.append(UInt8(code[from ..< to], radix: 16) ?? 0)
                    from = to
                }
//
                print(numbers)
                
//                let hex1 = String(format:"%02X", 0) // 00
//                let hex2 = String(format:"%02X", 2) // 00
//                let hex3 = String(format:"%02X", 5) // 00
//                let hex4 = String(format:"%02X", 5) // 00

                
                
                //Keep this as UInt8 in NSData
                
                
                //let data = NSData(bytes: &codeValue, length: sizeof(UInt8))
                
                
                //send as byte array
                let data = NSData(bytes: numbers, length: 4)
                //let data = NSData(bytes: bytesArray , length: 4)
                
                
                //without response for Arduino Uno
                //with response for Arduino 101
                print("position characteristic is: \(blueCharacteristic.UUID)")
                self.peripheral?.writeValue(data, forCharacteristic: blueCharacteristic, type: CBCharacteristicWriteType.WithResponse)
                
            }
        }
        
    }
      
    func sendBTServiceNotificationWithIsBluetoothConnected(isBluetoothConnected: Bool) {
        let connectionDetails = ["isConnected": isBluetoothConnected]
        NSNotificationCenter.defaultCenter().postNotificationName(BLEServiceChangedStatusNotification, object: self, userInfo: connectionDetails)
    }
      
}