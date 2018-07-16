//
//  DBUploadHandler.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/18/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import Foundation
import AWSDynamoDB

class DBUploadHandler
{
    func createSpot(_ spot: Spot, completionHandler: @escaping (_ error: Error?) -> Void) {
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        

        
        //Save a new item
        dynamoDbObjectMapper.save(spot, completionHandler: completionHandler)
    }
    func createSesh(_ sesh: Session, completionHandler: @escaping (_ error: Error?) -> Void) {
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()

        dynamoDbObjectMapper.save(sesh, completionHandler: completionHandler)
    }
    func createLocDP(_ locDP: LocationDataPoint)
    {
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        
        dynamoDbObjectMapper.save(locDP, completionHandler: {
            (error: Error?) -> Void in
            
            if let error = error {
                print("Amazon DynamoDB Save Error: \(error)")
                return
            }
            print("An item was saved.")
        })
    }
    func createGear(_ gear: Gear, completionHandler: @escaping (_ error: Error?) -> Void) {
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()

        dynamoDbObjectMapper.save(gear, completionHandler: completionHandler)
    }
    func createWind(_ wind: Wind, completionHandler: @escaping (_ error: Error?) -> Void) {
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()

        dynamoDbObjectMapper.save(wind, completionHandler: completionHandler)
    }
}

let DBUpload = DBUploadHandler()
