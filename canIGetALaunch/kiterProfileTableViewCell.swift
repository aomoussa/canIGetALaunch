//
//  kiterProfileTableViewCell.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 7/20/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit

class kiterProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var kiterPic: UIImageView!
    @IBOutlet weak var kiterNameLabel: UILabel!
    @IBOutlet weak var changePicButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
