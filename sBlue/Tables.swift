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
var gestureElements : [[String]] = [["00", "Blink"],
                                    ["01", "Random RGB"],
                                    ["02", "Servo 360"],
                                    ["03", "Red Light"],
                                    ["04", "Blue Light"],
                                    ["05", "Green Light"],
                                    ["06", "Yellow Light"],
                                    ["07", "Orange Light"],
                                    ["08", "Purple Light"],
                                    ["09", "White Light"]]

// gestureID | gestureName | gesture1 | gesture2 | gesture3 | gesture4 | gesture5
var gestures : [[String]] = [["00", "Blink", "00", "FF", "FF", "FF", "FF"],
                             ["01", "Random RGB", "01", "FF", "FF", "FF", "FF"],
                             ["02", "Servo 360", "02", "FF", "FF", "FF", "FF"],
                             ["03", "Red Light", "03", "FF", "FF", "FF", "FF"],
                             ["04", "Blue Light", "04", "FF", "FF", "FF", "FF"],
                             ["05", "Green Light", "05", "FF", "FF", "FF", "FF"],
                             ["06", "Yellow Light", "06", "FF", "FF", "FF", "FF"],
                             ["07", "Orange Light", "07", "FF", "FF", "FF", "FF"],
                             ["08", "Purple Light", "08", "FF", "FF", "FF", "FF"],
                             ["09", "White Light", "09", "FF", "FF", "FF", "FF"]]

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
var contacts : [[String]] = [[]]

// linkId | contactID | gestureID
var links : [[String]] = [[]]