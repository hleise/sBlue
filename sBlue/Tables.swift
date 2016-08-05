//
//  Tables.swift
//  sBlue
//
//  Created by Hunter Leise on 8/4/16.
//  Copyright © 2016 Vivo Applications. All rights reserved.
//

import Foundation

// commandName | commandID
var commands : [[String]] = [["modify", "00"],
                             ["clear", "01"],
                             ["query", "02"]]

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
                                   ["02", "Party", "01", "02", "FF", "FF", "FF"]]

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

// linkID | contactID | gestureType | gestureID
var links : [[String]] = [["00", "00", "01", "00"],
                          ["01", "01", "01", "01"],
                          ["02", "02", "00", "08"]]