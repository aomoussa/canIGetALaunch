//
//  kiterProfileTableViewCell.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 7/20/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class kiterProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var kiterPic: UIImageView!
    @IBOutlet weak var kiterNameLabel: UILabel!
    @IBOutlet weak var changePicButton: UIButton!
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBAction func logout(_ sender: UIButton) {
        FBSDKLoginManager().logOut()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        circleButton(button: logoutButton)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func circleButton(button: UIButton)
    {
        button.layer.borderWidth = 1
        button.layer.masksToBounds = false
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = button.frame.height/3
        button.clipsToBounds = true
    }

}
