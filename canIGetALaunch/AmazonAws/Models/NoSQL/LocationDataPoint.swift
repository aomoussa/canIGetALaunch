//
//  LocationDataPoint.swift
//  MySampleApp
//
//
// Copyright 2018 Amazon.com, Inc. or its affiliates (Amazon). All Rights Reserved.
//
// Code generated by AWS Mobile Hub. Amazon gives unlimited permission to 
// copy, distribute and modify it.
//
// Source code generated from template: aws-my-sample-app-ios-swift v0.21
//

import Foundation
import UIKit
import AWSDynamoDB

class LocationDataPoint: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var _sessionId: String?
    var _timestamp: NSNumber?
    var _iD: String?
    var _altitude: NSNumber?
    var _course: NSNumber?
    var _lat: NSNumber?
    var _lon: NSNumber?
    var _speed: NSNumber?
    
    class func dynamoDBTableName() -> String {

        return "thekitelife-mobilehub-374752204-locationDataPoint"
    }
    
    class func hashKeyAttribute() -> String {

        return "_sessionId"
    }
    
    class func rangeKeyAttribute() -> String {

        return "_timestamp"
    }
    
    override class func jsonKeyPathsByPropertyKey() -> [AnyHashable: Any] {
        return [
               "_sessionId" : "sessionId",
               "_timestamp" : "timestamp",
               "_iD" : "ID",
               "_altitude" : "altitude",
               "_course" : "course",
               "_lat" : "lat",
               "_lon" : "lon",
               "_speed" : "speed",
        ]
    }
}
