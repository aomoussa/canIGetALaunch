//
//  spot.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/10/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import Foundation
import MapKit
class spot{
    
    var title = "defaultTitle"
    var spotKiter = kiter()
    
    var parkHere = CLLocationCoordinate2D()
    var rigHere = CLLocationCoordinate2D()
    var launchHere = CLLocationCoordinate2D()
    var waterStartHere = CLLocationCoordinate2D()
    
    var windDirections = [String]()
    var season = [String]()
    var difficulties = [String]()
    var dbSpot = Spot()
    
    init(title: String, parkHere: CLLocationCoordinate2D, rigHere: CLLocationCoordinate2D, launchHere: CLLocationCoordinate2D, waterStartHere: CLLocationCoordinate2D)
    {
        self.title = title
        self.parkHere = parkHere
        self.rigHere = rigHere
        self.launchHere = launchHere
        self.waterStartHere = waterStartHere
    }
    init()
    {
        
    }
    init(fromSpot: Spot)
    {
        dbSpot = fromSpot
        title = fromSpot._title!
        
        parkHere.latitude = fromSpot._parkHereLat as! CLLocationDegrees
        parkHere.longitude = fromSpot._parkHereLon as! CLLocationDegrees
        
        rigHere.latitude = fromSpot._rigHereLat as! CLLocationDegrees
        rigHere.longitude = fromSpot._rigHereLon as! CLLocationDegrees
        
        launchHere.latitude = fromSpot._launchHereLat as! CLLocationDegrees
        launchHere.longitude = fromSpot._launchHereLon as! CLLocationDegrees
        
        waterStartHere.latitude = fromSpot._waterStartHereLat as! CLLocationDegrees
        waterStartHere.longitude = fromSpot._waterStartHereLon as! CLLocationDegrees
        
        for wd in fromSpot._windDirections!
        {
            windDirections.append(wd)
        }
        for d in fromSpot._difficulties!
        {
            difficulties.append(d)
        }
        for s in fromSpot._seasons!
        {
            season.append(s)
        }
        
    }
    func makeDBSpot() -> Spot
    {
        let dbspot = Spot()
        dbspot?._id = NSUUID().uuidString
        dbspot?._title = self.title
        dbspot?._kiterId = thisKiter.id
        dbspot?._parkHereLat = NSNumber(value: self.parkHere.latitude)
        dbspot?._parkHereLon = NSNumber(value: self.parkHere.longitude)
        dbspot?._rigHereLat = NSNumber(value: self.rigHere.latitude)
        dbspot?._rigHereLon = NSNumber(value: self.rigHere.longitude)
        dbspot?._launchHereLat = NSNumber(value: self.launchHere.latitude)
        dbspot?._launchHereLon = NSNumber(value: self.launchHere.longitude)
        dbspot?._waterStartHereLat = NSNumber(value: self.waterStartHere.latitude)
        dbspot?._waterStartHereLon = NSNumber(value: self.waterStartHere.longitude)
        
        dbspot?._windDirections = []
        dbspot?._seasons = []
        dbspot?._difficulties = ["upwinding"]
        for wd in self.windDirections
        {
            dbspot?._windDirections?.insert(wd)
        }
        for s in self.season
        {
            dbspot?._seasons?.insert(s)
        }
        for d in self.difficulties
        {
            dbspot?._difficulties?.insert(d)
        }
        
        return dbspot!
    }
}
var allSpots = [spot]()
var theSpot = spot()

