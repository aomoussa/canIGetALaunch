//
//  windSpeed.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/13/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import Foundation
class windSpeed
{
    var speedFrom: Int
    var speedTo: Int
    var units: String//"knts" or "mph"
    
    var pickerState = "min"//"max"
    let speedUnits = ["knts","mph"]
    
    init()
    {
        self.speedFrom = 0
        self.speedTo = 0
        self.units = "knts"
    }
    init(speedFrom: Int, speedTo: Int, units: String)
    {
        self.speedFrom = speedFrom
        self.speedTo = speedTo
        self.units = units
    }
}
