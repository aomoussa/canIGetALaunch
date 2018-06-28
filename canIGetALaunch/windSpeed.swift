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
    var id: String
    var speedFrom: Int
    var speedTo: Int
    var units: String//"knts" or "mph"
    var direction: String
    
    var pickerState = "min"//"max"
    let speedUnits = ["knts","mph"]
    
    init()
    {
        self.id = NSUUID().uuidString
        self.speedFrom = 0
        self.speedTo = 0
        self.units = "knts"
        self.direction = "n"
    }
    init(speedFrom: Int, speedTo: Int, units: String)
    {
        self.id = NSUUID().uuidString
        self.speedFrom = speedFrom
        self.speedTo = speedTo
        self.units = units
        self.direction = "n"
    }
    init(fromWind: Wind)
    {
        self.id = NSUUID().uuidString
        self.speedFrom = fromWind._speedFrom as! Int
        self.speedTo = fromWind._speedTo as! Int
        if(fromWind._units == 0)
        {
        self.units = "kts"
        }
        else{
            self.units = "mph"
        }
        self.direction = fromWind._direction!
    }
    func makeDBWind() -> Wind
    {
        let dbwind = Wind()
        dbwind?._spotId = self.id
        dbwind?._speedFrom = self.speedFrom as NSNumber?
        dbwind?._speedTo = self.speedTo as NSNumber?
        dbwind?._direction = self.direction
        if(self.units == "kts")
        {
            dbwind?._units = true
        }
        else
        {
            dbwind?._units = false
        }
        return dbwind!
    }
    func toString() -> String{
        return "\(speedFrom)-\(speedTo) \(units)"
    }
}
