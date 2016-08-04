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

// gestureID | gestureName | gesture1 | gesture2 | gesture3 | gesture4 | gesture5
var customGestures : [[String]] = [[]]

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