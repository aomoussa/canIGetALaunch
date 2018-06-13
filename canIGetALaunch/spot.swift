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
    
    var parkHere = CLLocationCoordinate2D()
    var rigHere = CLLocationCoordinate2D()
    var launchHere = CLLocationCoordinate2D()
    var waterStartHere = CLLocationCoordinate2D()
    
    
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
}

var allSpots = [spot]()

