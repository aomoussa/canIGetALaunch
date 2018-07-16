//
//  neViewController.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/15/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class friendsViewController: UIViewController {
    
    @IBOutlet weak var bitmoji: UITextView!
    @IBOutlet weak var bitmojiLabel: UILabel!
    @IBOutlet weak var kiterNameLabel: UILabel!
    @IBOutlet weak var kiterPic: UIImageView!
    @IBAction func kiterPicButton(_ sender: UIButton) {
        thisKiter.getFBStuff()
        kiterNameLabel.text = thisKiter.name
        kiterPic.image = thisKiter.image
        
    }
    var kiterImage = UIImage(named: "launch.png")
    override func viewDidLoad() {
        super.viewDidLoad()
        kiterPic.image = kiterImage
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(friendsViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        kiterNameLabel.text = thisKiter.name
        kiterPic.image = thisKiter.image
        circleImageView(image: kiterPic)
    }
    func circleImageView(image: UIImageView)
    {
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.width/2.5
        image.clipsToBounds = true
    }
    
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension friendsViewController: UITextViewDelegate
{
    override func paste(_ sender: Any?) {
        let textAttachment = NSTextAttachment()
        textAttachment.image = UIPasteboard.general.image
        let attributedText = NSAttributedString(attachment: textAttachment)
        bitmojiLabel.attributedText = attributedText
        thisKiter.bitmoji = attributedText
        thisKiter.bitmojiLength = bitmoji.attributedText.length
        thisKiter.image = thisKiter.imageFromBitmoji()
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        self.view.endEditing(true)
    }
}
