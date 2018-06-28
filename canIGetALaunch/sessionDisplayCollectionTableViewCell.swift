//
//  sessionDisplayCollectionTableViewCell.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/28/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit
import MapKit

class sessionDisplayCollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var kiterNameLabel: UILabel!
    @IBOutlet weak var gearLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var spotTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sessionDataCollView: UICollectionView!
    @IBOutlet weak var kiterImage: UIImageView!
    
    var locations = [CLLocation]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sessionDataCollView.delegate = self
        sessionDataCollView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension sessionDisplayCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collCell = collectionView.dequeueReusableCell(withReuseIdentifier: "sessionMapCollCell", for: indexPath) as! sessionMapCollectionViewCell
        collCell.locations = self.locations
        return collCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let c = cell as? sessionMapCollectionViewCell
        {
            if(c.locations.count == 0 && locations.count > 0)
            {
                c.locations = locations
            }
            if(c.locations.count > 0 && !c.lineDisplayed)
            {
                c.makeLine()
            }
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.width)
    }
    
}
