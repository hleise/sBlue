//
//  Tables.swift
//  sBlue
//
//  Created by Hunter Leise on 8/4/16.
//  Copyright © 2016 Vivo Applications. All rights reserved.
//
    
import Foundation
    
// commandName | commandID
var commands : [String:String] = ["modify": "00",
                             "clear": "01",
                             "query": "02"]

// gestureElementID | gestureElementName
var defaultGestures : [[String]] = [["00", "Blink"],
                                    ["01", "Random RGB"],
                                    ["02", "Servo 360"],
                                    ["03", "Red Light"],
                                    ["04", "Blue Light"],
                                    ["05", "Green Light"],
                                    ["06", "Yellow Light"],
                                    ["07", "Orange Light"],
                                    ["08", "Purple Light"],
                                    ["09", "White Light"]]


//gesture slots, not gesture types, fill the rest with FFs
// gestureID | gestureName | gesture1 | gesture2 | gesture3 | gesture4 | gesture5 
var customGestures : [[String]] = [["00", "Dancing", "00", "FF", "FF", "FF", "FF"],
                                   ["01", "Walking", "01", "03", "FF", "FF", "FF"],
                                   ["02", "Party", "01", "02", "FF", "FF", "FF"],
                                   ["03", "Rainbow", "00", "FF", "FF", "FF", "FF"],
                                   ["04", "Wag Tail", "01", "03", "FF", "FF", "FF"],
                                   ["05", "Cry", "01", "02", "FF", "FF", "FF"]]

// appID | appName | appIdentifier
var apps : [[String]] = [["00", "Whatsapp", "com.whatsapp"],
                         ["01", "Facebook", "com.facebook"],
                         ["02", "Messenger", "com.messenger"],
                         ["03", "Skype", "com.skype"],
                         ["04", "Call", "com.call"],
                         ["05", "Missed Call", "com.missedcall"],
                         ["06", "Messages", "com.messages"],
                         ["07", "Twitter", "com.twitter"]]

// contactID | appID | contactName
var contacts : [[String]] = [["00", "01", "Hunter Leise"],
                             ["01", "07", "@andresrubiop"],
                             ["02", "07", "@ViveFaux"]]

//gestureType 01 = custom
//00 default
// linkID | contactID | gestureType | gestureID
var links : [[String]] = [["00", "00", "01", "00"],
                          ["01", "01", "01", "01"],
                          ["02", "02", "00", "08"]]



func getGestureIDWithName(gestureName: String, gestureType: String) -> String {
    
    if gestureType == "00" {
        for gesture in defaultGestures {
            if gesture[1] == gestureName {
                return gesture[0]
            }
        }
    } else {
        for gesture in customGestures {
            if gesture[1] == gestureName {
                return gesture[0]
            }
        }
    }
    
    
    return "FF"
}



func getContactIDWithName(contactName: String) -> String {
    
    for i in 0..<contacts.count {
        if contacts[i][2] == contactName {
            return contacts[i][0]
        }
    }
    
    return "FF"
}


func getAppIDWithName(appName: String) -> String {
    
    for i in 0..<apps.count {
        if apps[i][1] == appName {
            return apps[i][0]
        }
    }
    
    return "FF"
}


func getGestureNameWithID(gestureID: String, gestureType: String) -> String {
    
    if gestureType == "00" {
        for i in 0..<defaultGestures.count {
            if defaultGestures[i][0] == gestureID {
                return defaultGestures[i][1]
            }
        }
    } else {
        for i in 0..<customGestures.count {
            if customGestures[i][0] == gestureID {
                return customGestures[i][1]
            }
        }
    }
    
    return "FF"
}


func getContactNameWithID(contactID: String) -> String {
    
    for i in 0..<contacts.count {
        if contacts[i][0] == contactID {
            return contacts[i][2]
        }
    }
    
    return ""
}


func getAppNameWithID(appID: String) -> String {
    
    for i in 0..<apps.count {
        if apps[i][0] == appID {
            return apps[i][1]
        }
    }
    
    return ""
}

func getGestureTypeWithName(gestureName: String) -> String {
    for gesture in defaultGestures {
        if gestureName == gesture[1] {
            return "00"
        }
    }
    
    for gesture in customGestures {
        if gestureName == gesture[1] {
            return "01"
        }
    }
    
    precondition(true, "Gesture name not found")
    return "FF"
}

func getContactIndexWithContactID(contactID: String) -> Int {
    for i in 0..<contacts.count {
        if contacts[i][0] == contactID {
            return i
        }
    }
    precondition(true, "Contact index not found")
    return -1
}

func getNextAvailableID(table: [[String]]) -> String {
    var availableIDs = Set([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
    for element in table {
        if let elementID = Int(element[0]) {
            if availableIDs.contains(elementID) {
                availableIDs.remove(elementID)
            }
        } else {
            precondition(true, "Element id is nil")
        }
    }
    return "0" + String(availableIDs.minElement()!)
}

func deleteGesture(gestureName: String, gestureType: String) -> String {
    
    var code = ""
    
    if let command = commands["clear"] {
        code = command
    }
    
    if gestureType == "default" {
        code += getGestureIDWithName(gestureName, gestureType: "00")
    } else {
        code += getGestureIDWithName(gestureName, gestureType: "01")

    }
    
    code += "FFFF"
    
    return code
}