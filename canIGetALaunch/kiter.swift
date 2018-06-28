//
//  kiter.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/13/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import Foundation
import UIKit

class kiter
{
    var name: String
    var bitmoji: NSAttributedString
    var bitmojiLength: Int
    //let textAttachment = NSTextAttachment()
    var sessions = [session]()
    init()
    {
        name = "Ahmed Moussa"
        bitmoji = NSAttributedString()
        bitmojiLength = 0
        
    }
    /*
    func imageFromBitmoji() -> UIImage
    {
        var image: UIImage? = nil
        var allGood = false
        bitmoji.enumerateAttribute(NSAttachmentAttributeName, in: NSRange(location: 0, length: bitmojiLength), options: [], using: {(value,range,stop) -> Void in
            if (value is NSTextAttachment) {
                let attachment: NSTextAttachment? = (value as? NSTextAttachment)
                
                
                if ((attachment?.image) != nil) {
                    image = attachment?.image
                } else {
                    image = attachment?.image(forBounds: (attachment?.bounds)!, textContainer: nil, characterIndex: range.location)
                }
                
                if image != nil {
                    print("bitmoji good to go")
                    allGood = true
                }
            }
        })
        if(allGood)
        {
            return image!
        }
        return UIImage(named: "launch.jpg")!
    }*/
    
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
