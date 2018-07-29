//
//  kiter.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/13/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit

class kiter
{
    var name: String
    var bitmoji: NSAttributedString
    var bitmojiLength: Int
    var image: UIImage
    var id: String
    var profilePictureUrl: String
    //let textAttachment = NSTextAttachment()
    var sessions = [session]()
    var dbKiter = Kiter()
    init()
    {
        name = "Ahmed Moussa"
        id = "1"
        bitmoji = NSAttributedString()
        bitmojiLength = 0
        image = UIImage(named: "launch.png")!
        profilePictureUrl = "ahmed.com"
    }
    init(fromDBKiter: Kiter)
    {
        dbKiter = fromDBKiter
        name = fromDBKiter._kiterName!
        id = fromDBKiter._kiterId!
        bitmoji = NSAttributedString()
        bitmojiLength = 0
        image = UIImage(named: "launch.png")!
        profilePictureUrl = fromDBKiter._kiterBitmoji!
        downloadImage(url: URL(string: profilePictureUrl)!)
    }
    func createDBKiter() -> Kiter
    {
        let dbKiter = Kiter()
        dbKiter?._kiterBitmoji = profilePictureUrl
        dbKiter?._kiterId = id
        dbKiter?._kiterName = name
        return dbKiter!
    }
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.image = UIImage(data: data)!
            }
        }
    }
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    func getFBStuff()
    {
        let completionHandler: FBSDKGraphRequestHandler = { (connection, result, error) -> Void in
            if (error == nil){
                print("facebook login result: \(result)")
                
                let data:[String:AnyObject] = result as! [String : AnyObject]
                
                
                if let userName = data["name"]! as? NSString
                {
                    self.name = userName as String
                }
                if let facebookID = data["id"]! as? NSString
                {
                    self.id = facebookID as String
                }
                let fbPP:[String:AnyObject] = data["picture"] as! [String : AnyObject]
                let fbPPData:[String:AnyObject] = fbPP["data"] as! [String : AnyObject]
                self.profilePictureUrl = fbPPData["url"]! as? NSString as! String//"https://graph.facebook.com/\(facebookID)/picture?type=large"
                let url = URL(string: self.profilePictureUrl )
                self.downloadImage(url: url!)
                DBUpload.createKiter(self.createDBKiter(), completionHandler: {
                    (error: Error?) -> Void in
                    
                    if let error = error {
                        print("Amazon DynamoDB Save Error: \(error)")
                        return
                    }
                    print("An item was saved.")
                })
                //let firstName : NSString? = data["first_name"]! as? NSString
                //let lastName : NSString? = data["last_name"]! as? NSString
                //let email : NSString? = data["email"]! as? NSString
                //print("\(firstName) \(lastName)")
            }
            else
            {
                print(error)
            }
        }
        FBSDKRequestHandler.fbHandler.returnUserData(completionHandler: completionHandler)
    }
    func imageFromBitmoji() -> UIImage
    {
        let range = NSRange(location: 0, length: bitmojiLength)
        if (bitmoji.containsAttachments(in: range)) {
            let attrString = bitmoji
            var location = 0
            while location < range.length {
                var r = NSRange()
                let attrDictionary = attrString.attributes(at: location, effectiveRange: &r)
                if attrDictionary != nil {
                    // Swift.print(attrDictionary!)
                    let attachment = attrDictionary[NSAttachmentAttributeName] as? NSTextAttachment
                    if attachment != nil {
                        if attachment!.image != nil {
                            // your code to use attachment!.image as appropriate
                            return attachment!.image!
                        }
                    }
                    location += r.length
                }
            }
        }
        return UIImage(named: "launch.jpg")!
    }
    
}
var allKiters = [kiter]()
var thisKiter = kiter()
