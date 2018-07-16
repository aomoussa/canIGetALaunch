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
    //let textAttachment = NSTextAttachment()
    var sessions = [session]()
    init()
    {
        name = "Ahmed Moussa"
        bitmoji = NSAttributedString()
        bitmojiLength = 0
        image = UIImage(named: "launch.png")!
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
                let facebookID : NSString? = data["id"]! as? NSString
                let fbPP:[String:AnyObject] = data["picture"] as! [String : AnyObject]
                let fbPPData:[String:AnyObject] = fbPP["data"] as! [String : AnyObject]
                let profilePictureUrl = fbPPData["url"]! as? NSString//"https://graph.facebook.com/\(facebookID)/picture?type=large"
                let url = URL(string: profilePictureUrl as! String)
                self.downloadImage(url: url!)
                
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
