//
//  gear.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/13/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import Foundation
class gear
{
    var id: String
    var pickerState = "min"
    let boardTypes = ["twin tip","surfboard","foil"]
    let kiteTypes = ["inflatable LE", "foil"]
    let brands = ["Naish","North","Cabrinha","Liquid Force","Airrush","Other"]
    
    var boardType = "twin tip"
    var boardSize = 134
    var boardBrand = "North"
    
    var kiteType = "inflatable LE"
    var kiteSize = 9
    var kiteBrand = "Liquid Force"
    init()
    {
        self.id = NSUUID().uuidString
    }
    init(fromGear: Gear)
    {
        self.id = NSUUID().uuidString
        boardType = fromGear._boardType!
        boardSize = Int(fromGear._boardSize!)
        boardBrand = fromGear._boardBrand!
        
        kiteType = fromGear._kiteType!
        kiteSize = Int(fromGear._kiteSize!)
        kiteBrand = fromGear._kiteBrand!
    }
    func toString() -> String
    {
        return "\(boardType) + \(kiteType)"
    }
    func makeDBGear() -> Gear{
        let dbgear = Gear()
        dbgear?._gearId = self.id
        dbgear?._kiteType = self.kiteType
        dbgear?._kiteSize = self.kiteSize as NSNumber?
        dbgear?._kiteBrand = self.kiteBrand
        
        dbgear?._boardType = self.boardType
        dbgear?._boardSize = self.boardSize as NSNumber?
        dbgear?._boardBrand = self.boardBrand
        return dbgear!
    }
}
