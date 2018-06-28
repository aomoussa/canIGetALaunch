//
//  session.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/13/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import Foundation
import MapKit

class session
{
    var id: String
    var date: NSDate
    var seshSpot: spot
    var seshGear: gear
    var seshWindSpeed: windSpeed
    var locations = [CLLocation]()
    var dbSesh = Session()
    var locDPs = [LocationDataPoint]()
    
    var active = false
    init()
    {
        self.id = NSUUID().uuidString
        date = NSDate()
        self.seshSpot = spot()
        self.seshGear = gear()
        self.seshWindSpeed = windSpeed()
        
        //locations.append(CLLocation())
    }
    init(fromDBSession: Session)
    {
        self.dbSesh =  fromDBSession
        self.id = fromDBSession._sessionID!
        date = NSDate(timeIntervalSince1970: TimeInterval(exactly: Double(fromDBSession._date!)!)!)
        self.seshSpot = spot()
        self.seshSpot.title = fromDBSession._spotTitle!
        self.seshGear = gear()
        self.seshWindSpeed = windSpeed()
    }
    init(fromDBSession: Session, fromSpot: spot, fromGear: gear, fromWind: windSpeed, fromLocDPs: [LocationDataPoint]
        )
    {
        self.id = fromDBSession._sessionID!
        date = NSDate(timeIntervalSince1970: TimeInterval(exactly: Double(fromDBSession._date!)!)!)
        self.seshSpot = fromSpot
        self.seshGear = fromGear
        self.seshWindSpeed = fromWind
        for loc in fromLocDPs
        {
            locations.append(CLLocation(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(loc._lat!), longitude: CLLocationDegrees(loc._lon!)), altitude: CLLocationDistance(loc._altitude!), horizontalAccuracy: CLLocationAccuracy(), verticalAccuracy: CLLocationAccuracy(), course: CLLocationDirection(loc._course!), speed: CLLocationSpeed(loc._speed!), timestamp: NSDate(timeIntervalSince1970: TimeInterval(loc._timestamp!)) as Date))
        }
    }
    func makeDBSession(fromGear: Gear, fromWindSpeed: Wind) -> Session
    {
        let dbSesh = Session()
        dbSesh?._sessionID = self.id
        dbSesh?._date = String(self.date.timeIntervalSince1970)
        dbSesh?._gearID = fromGear._gearId
        dbSesh?._windSpeedID = fromWindSpeed._spotId
        
        dbSesh?._spotID = self.seshSpot.title
        dbSesh?._spotTitle = self.seshSpot.title
        dbSesh?._active = self.active as NSNumber
        
        dbSesh?._locationDataPointsIDs = []
        
        for locDP in locDPs
        {
            dbSesh?._locationDataPointsIDs?.insert(locDP._iD!)
        }
        
        return dbSesh!
    }
    func addLoc(dbLocDP: LocationDataPoint)
    {
        locations.append(CLLocation(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(dbLocDP._lat!), longitude: CLLocationDegrees(dbLocDP._lon!)), altitude: CLLocationDistance(dbLocDP._altitude!), horizontalAccuracy: CLLocationAccuracy(), verticalAccuracy: CLLocationAccuracy(), course: CLLocationDirection(dbLocDP._course!), speed: CLLocationSpeed(dbLocDP._speed!), timestamp: NSDate(timeIntervalSince1970: TimeInterval(dbLocDP._timestamp!)) as Date))
    }
    func makeDPAndSave(loc: CLLocation)
    {
        locations.append(loc)
        
        let locDP = LocationDataPoint()
        locDP?._iD = NSUUID().uuidString
        locDP?._sessionId = self.id
        locDP?._lat = NSNumber(value: loc.coordinate.latitude)
        locDP?._lon = NSNumber(value: loc.coordinate.longitude)
        locDP?._speed = NSNumber(value: loc.speed)
        locDP?._course = NSNumber(value: loc.course)
        locDP?._altitude = NSNumber(value: loc.altitude)
        locDP?._timestamp = NSNumber(value: loc.timestamp.timeIntervalSince1970)
        locDPs.append(locDP!)
        
        DBUpload.createLocDP(locDP!)
    }
}
var allSessions = [session]()
var theSesh = session()
