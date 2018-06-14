//
//  gearPickerTableViewCell.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/13/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit

class gearPickerTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var boardTypePicker: UIPickerView!
    @IBOutlet weak var boardBrandPicker: UIPickerView!
    @IBOutlet weak var boardSizePicker: UIPickerView!
    @IBOutlet weak var kiteTypePicker: UIPickerView!
    @IBOutlet weak var kiteBrandPicker: UIPickerView!
    @IBOutlet weak var kiteSizePicker: UIPickerView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
