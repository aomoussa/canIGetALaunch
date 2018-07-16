//
//  FBSDKRequestHandler.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 7/7/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

class FBSDKRequestHandler{
    static var fbHandler = FBSDKRequestHandler()
    
    func returnUserData(completionHandler: @escaping FBSDKGraphRequestHandler){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: completionHandler)
        }
        else{
            print("access token is nil, why?")
        }
    }

}
