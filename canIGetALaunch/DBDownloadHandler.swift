//
//  DBDownloadHandler.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/18/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import Foundation
import AWSDynamoDB
import AWSAuthCore

class DBDownloadHandler
{
    func querySpots(completionHandler: @escaping (_ response: AWSDynamoDBPaginatedOutput?, _ error: Error?) -> Void) {
        // 1) Configure the query
        let scanExpression = AWSDynamoDBScanExpression()

        
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        
        dynamoDbObjectMapper.scan(Spot.self, expression: scanExpression, completionHandler: {(response: AWSDynamoDBPaginatedOutput?, error: Error?) -> Void in
            DispatchQueue.main.async(execute: {
                completionHandler(response, error)
                
            })
        })
    }
    func queryGearWithID(id: String, completionHandler: @escaping (_ response: AWSDynamoDBPaginatedOutput?, _ error: Error?) -> Void) {
        // 1) Configure the query
        let scanExpression = AWSDynamoDBScanExpression()
        scanExpression.filterExpression = "#gearId = :id"
        scanExpression.expressionAttributeNames = [
            "#gearId": "gearId"
        ]
        scanExpression.expressionAttributeValues = [
            ":id": id
        ]
        
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        
        dynamoDbObjectMapper.scan(Gear.self, expression: scanExpression, completionHandler: {(response: AWSDynamoDBPaginatedOutput?, error: Error?) -> Void in
            DispatchQueue.main.async(execute: {
                completionHandler(response, error)
                
            })
        })
    }
    func queryWindWithID(id: String, completionHandler: @escaping (_ response: AWSDynamoDBPaginatedOutput?, _ error: Error?) -> Void) {
        // 1) Configure the query
        let scanExpression = AWSDynamoDBScanExpression()
        scanExpression.filterExpression = "#spotId = :id"
        scanExpression.expressionAttributeNames = [
            "#spotId": "spotId"
        ]
        scanExpression.expressionAttributeValues = [
            ":id": id
        ]
        
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        
        dynamoDbObjectMapper.scan(Wind.self, expression: scanExpression, completionHandler: {(response: AWSDynamoDBPaginatedOutput?, error: Error?) -> Void in
            DispatchQueue.main.async(execute: {
                completionHandler(response, error)
                
            })
        })
    }
    func queryLocDPsFromSessionWithIDAndMinSpeed(id: String, completionHandler: @escaping (_ response: AWSDynamoDBPaginatedOutput?, _ error: Error?) -> Void) {
        // 1) Configure the query
        let minSpeed = 5
        let scanExpression = AWSDynamoDBScanExpression()
        scanExpression.filterExpression = "#sessionId = :id AND #speed > :minSpeed"
        scanExpression.expressionAttributeNames = [
            "#sessionId": "sessionId",
            "#speed": "speed"
        ]
        scanExpression.expressionAttributeValues = [
            ":id": id,
            ":minSpeed": minSpeed
        ]
        
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        
        dynamoDbObjectMapper.scan(LocationDataPoint.self, expression: scanExpression, completionHandler: {(response: AWSDynamoDBPaginatedOutput?, error: Error?) -> Void in
            DispatchQueue.main.async(execute: {
                completionHandler(response, error)
                
            })
        })
    }
    func queryLocDPsFromSessionWithID(id: String, completionHandler: @escaping (_ response: AWSDynamoDBPaginatedOutput?, _ error: Error?) -> Void) {
        // 1) Configure the query
        let scanExpression = AWSDynamoDBScanExpression()
        scanExpression.filterExpression = "#sessionId = :id"
        scanExpression.expressionAttributeNames = [
            "#sessionId": "sessionId"
        ]
        scanExpression.expressionAttributeValues = [
            ":id": id
        ]
        
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        
        dynamoDbObjectMapper.scan(LocationDataPoint.self, expression: scanExpression, completionHandler: {(response: AWSDynamoDBPaginatedOutput?, error: Error?) -> Void in
            DispatchQueue.main.async(execute: {
                completionHandler(response, error)
                
            })
        })
    }
    func queryKiters(completionHandler: @escaping (_ response: AWSDynamoDBPaginatedOutput?, _ error: Error?) -> Void) {
        // 1) Configure the query
        let scanExpression = AWSDynamoDBScanExpression()
        
        
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        
        dynamoDbObjectMapper.scan(Kiter.self, expression: scanExpression, completionHandler: {(response: AWSDynamoDBPaginatedOutput?, error: Error?) -> Void in
            DispatchQueue.main.async(execute: {
                completionHandler(response, error)
                
            })
        })
    }
    func querySessions(completionHandler: @escaping (_ response: AWSDynamoDBPaginatedOutput?, _ error: Error?) -> Void) {
        // 1) Configure the query
        let scanExpression = AWSDynamoDBScanExpression()
        
        
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        
        dynamoDbObjectMapper.scan(Session.self, expression: scanExpression, completionHandler: {(response: AWSDynamoDBPaginatedOutput?, error: Error?) -> Void in
            DispatchQueue.main.async(execute: {
                completionHandler(response, error)
                
            })
        })
    }
}
let DBDownload = DBDownloadHandler()
