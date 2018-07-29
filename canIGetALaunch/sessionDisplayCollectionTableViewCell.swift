//
//  sessionDisplayCollectionTableViewCell.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/28/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit
import MapKit
import AWSDynamoDB

class sessionDisplayCollectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var kiterNameLabel: UILabel!
    @IBOutlet weak var gearLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var spotTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sessionDataCollView: UICollectionView!
    @IBOutlet weak var kiterImage: UIImageView!
    @IBOutlet weak var deleteSessionButton: UIButton!
    
    var seshNum = 0
    var locations = [CLLocation]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sessionDataCollView.delegate = self
        sessionDataCollView.dataSource = self
    }
    override func prepareForReuse() {
        
       
        if let mapCell = self.sessionDataCollView.cellForItem(at: IndexPath(item: 0, section: 0)) as? sessionMapCollectionViewCell
        {
            mapCell.lineDisplayed = false
            /*self.locations = allSessions[seshNum].locations
            mapCell.makeLine(locations: self.locations)
            getLocDPs()*/
        }
        
        
        super.prepareForReuse()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func checkTags(cellIndex: Int){
        if(cellIndex != self.seshNum || cellIndex > 2)
        {
            print("whyy?")
            self.seshNum = cellIndex
            self.getLocDPs()
        }
    }
    func getLocDPs()
    {
        /*
        if(self.sessionDataCollView.tag > 2){
            /*let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 300, height: 300)//CGRect(x: 0, y: 0, width: 200, height: 200)
            layout.scrollDirection = UICollectionViewScrollDirection.horizontal
            self.sessionDataCollView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 300, height: 300), collectionViewLayout: layout)*/
            self.sessionDataCollView.reloadData()
        }*/
        let forSesh = allSessions[seshNum]
        if let foundSpot = allSpots.enumerated().first(where: {$0.element.dbSpot?._id == forSesh.dbSesh?._spotID})
        {
            let spot = foundSpot.element
            self.locations.append(CLLocation(latitude: spot.parkHere.latitude, longitude: spot.parkHere.longitude))
            self.locations.append(CLLocation(latitude: spot.rigHere.latitude, longitude: spot.rigHere.longitude))
            self.locations.append(CLLocation(latitude: spot.launchHere.latitude, longitude: spot.launchHere.longitude))
            self.locations.append(CLLocation(latitude: spot.waterStartHere.latitude, longitude: spot.waterStartHere.longitude))
            self.sessionDataCollView.reloadData()
        }
        else{
            print("couldn't find spot")
        }
        if(self.locations.count == 0 && forSesh.locations.count != 0)
        {
            self.locations = forSesh.locations
            self.sessionDataCollView.reloadData()
            return
        }
        let completionHandler = {(output: AWSDynamoDBPaginatedOutput?, error: Error?) in
            if error != nil {
                print("The request failed. Error: \(String(describing: error))")
            }
            if output != nil {
                for dLoc in output!.items {
                    let locItem = dLoc as? LocationDataPoint
                    print("\(locItem!._sessionId!)")
                    forSesh.addLoc(dbLocDP: locItem!)
                }
                DispatchQueue.main.async(execute: {
                    self.locations = forSesh.locations
                    self.sessionDataCollView.reloadData()
                })
                //keep going
            }
        }
        DBDownload.queryLocDPsFromSessionWithID(id: (forSesh.dbSesh?._sessionID)!, completionHandler: completionHandler)
    }
}
extension sessionDisplayCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch(indexPath.row)
        {
        case 0:
            let collCell = collectionView.dequeueReusableCell(withReuseIdentifier: "sessionMapCollCell", for: indexPath) as! sessionMapCollectionViewCell
            collCell.locations = self.locations
            collCell.cellIndex = self.seshNum
            collCell.makeLine(locations: self.locations)
            return collCell
        default:
            let collCell = collectionView.dequeueReusableCell(withReuseIdentifier: "sessionDataTable", for: indexPath) as! sessionDataTableCollectionViewCell
            collCell.locations = self.locations
            return collCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let c = cell as? sessionMapCollectionViewCell
        {
            if(c.locations.count == 0 && locations.count > 0)
            {
                c.locations = locations
                c.cellIndex = seshNum
            }
            if(c.locations.count > 0 && !c.lineDisplayed)
            {
                c.makeLine(locations: c.locations)
            }
        }
        if let c = cell as? sessionDataTableCollectionViewCell
        {
            if(c.locations.count == 0 && locations.count > 0)
            {
                c.locations = locations
            }
            if(c.locations.count > 0 && !c.lineDisplayed)
            {
                c.makeTable()
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width*0.95, height: self.frame.width*0.95)
    }
    
}
