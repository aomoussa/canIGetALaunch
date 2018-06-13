//
//  windSpeedPickerTableViewCell.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/12/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit

class windSpeedPickerTableViewCell: UITableViewCell {

    @IBOutlet weak var speedFrom: UIPickerView!
    @IBOutlet weak var speedTo: UIPickerView!
    @IBOutlet weak var speedUnits: UIPickerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
