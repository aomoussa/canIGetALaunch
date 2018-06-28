//
//  Wind.swift
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

class Wind: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var _spotId: String?
    var _direction: String?
    var _speedFrom: NSNumber?
    var _speedTo: NSNumber?
    var _units: NSNumber?
    
    class func dynamoDBTableName() -> String {

        return "thekitelife-mobilehub-374752204-wind"
    }
    
    class func hashKeyAttribute() -> String {

        return "_spotId"
    }
    
    override class func jsonKeyPathsByPropertyKey() -> [AnyHashable: Any] {
        return [
               "_spotId" : "spotId",
               "_direction" : "direction",
               "_speedFrom" : "speedFrom",
               "_speedTo" : "speedTo",
               "_units" : "units",
        ]
    }
}
