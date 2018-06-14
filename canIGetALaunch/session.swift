//
//  session.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/13/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import Foundation
class session
{
    var date: NSDate
    var seshSpot: spot
    var seshGear: gear
    var seshWindSpeed: windSpeed
    
    var active = false
    init()
    {
        date = NSDate()
        self.seshSpot = spot()
        self.seshGear = gear()
        self.seshWindSpeed = windSpeed()
    }
}
var allSessions = [session]()
