//
//  neViewController.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/15/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import AWSDynamoDB
import MapKit

class friendsViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var numOfSessions = 0
    /*
     @IBAction func kiterPicButton(_ sender: UIButton) {
     thisKiter.getFBStuff()
     kiterNameLabel.text = thisKiter.name
     kiterPic.image = thisKiter.image
     
     }*/
    var kiterImage = UIImage(named: "launch.png")
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        if(allSessions.count == 0)
        {
            getSessions()
        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(friendsViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
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
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        
    }
    
    
}
extension friendsViewController: UITextViewDelegate
{
    override func paste(_ sender: Any?) {
        let textAttachment = NSTextAttachment()
        textAttachment.image = UIPasteboard.general.image
        let attributedText = NSAttributedString(attachment: textAttachment)
        thisKiter.bitmoji = attributedText
        thisKiter.bitmojiLength = attributedText.length
        thisKiter.image = thisKiter.imageFromBitmoji()
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        self.view.endEditing(true)
    }
}
extension friendsViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section)
        {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        default:
            return allSessions.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.section)
        {
        case 0:
            return makeViewDescriptionCell(tableView: tableView, indexPath: indexPath)
        case 1:
            return makeProfileCell(tableView: tableView, indexPath: indexPath)
        case 2:
            return makeMultipleSessionCell(tableView: tableView, indexPath: indexPath)
        default:
            return makeSessionCell(tableView: tableView, indexPath: indexPath)
        }
    }
    func makeViewDescriptionCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as! descriptionTableViewCell
        cell.descriptionLabel.text = "If drawing out your kite sessions all over the world and sharing them with fellow wind worshipers sounds as epic to you as it does to me, perhaps you would like to use the personal sessions map feature of the app, check it out!"
        return cell
    }
    func makeMultipleSessionCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "multipleSessionCell", for: indexPath) as! multipleSessionsTableViewCell
        cell.titleLabel.text = "\(thisKiter.name)'s Sessions"
        return cell
    }
    func makeProfileCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kiterProfileCell", for: indexPath) as! kiterProfileTableViewCell
        cell.kiterNameLabel.text = thisKiter.name
        cell.kiterPic.image = thisKiter.image
        circleImageView(image: cell.kiterPic)
        return cell
    }
    @objc func deleteSession(_ sender: UIButton)
    {
        print(allSessions[sender.tag].seshSpot.title)
        for loc in allSessions[sender.tag].locDPs
        {
            DBUpload.removeItem(itemToDelete: loc)
        }
        DBUpload.removeItem(itemToDelete: allSessions[sender.tag].seshGear.dbGear!)
        DBUpload.removeItem(itemToDelete: allSessions[sender.tag].seshWindSpeed.dbWind!)
        DBUpload.removeItem(itemToDelete: allSessions[sender.tag].dbSesh!)
        allSessions.remove(at: sender.tag)
        tableView.reloadData()
    }
    func makeSessionCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sessionDisplayControllerCell", for: indexPath) as! sessionDisplayCollectionTableViewCell
        cell.gearLabel.text = allSessions[indexPath.row].seshGear.toString()
        cell.gearLabel.adjustsFontSizeToFitWidth = true
        cell.kiterNameLabel.text = allSessions[indexPath.row].seshKiter.name
        cell.kiterImage = roundPic(image: allSessions[indexPath.row].seshKiter.image, picView: cell.kiterImage)
        cell.spotTitleLabel.text = allSessions[indexPath.row].seshSpot.title
        cell.windLabel.text = allSessions[indexPath.row].seshWindSpeed.toString()
        cell.dateLabel.text = allSessions[indexPath.row].getFormattedDate()
        //cell.locations = allSessions[indexPath.row].locations
        cell.deleteSessionButton.tag = indexPath.row
        cell.deleteSessionButton.addTarget(self, action: #selector(friendsViewController.deleteSession(_:)), for: .touchUpInside)
        cell.seshNum = indexPath.row
        return cell
    }
    func roundPic(image: UIImage, picView: UIImageView) -> UIImageView
    {
        picView.image = image
        picView.layer.borderWidth = 1
        picView.layer.masksToBounds = false
        picView.layer.borderColor = UIColor(red: 1, green: 57/255, blue: 105/255, alpha: 1).cgColor
        picView.layer.cornerRadius = picView.frame.width/1.9
        picView.clipsToBounds = true
        return picView
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let c = cell as? sessionDisplayCollectionTableViewCell
        {
            if(allSessions[indexPath.row].locations.count == 0){
                c.getLocDPs()
                //tableView.reloadData()
            }
            else{
                c.checkTags(cellIndex: indexPath.row)
            }
            
            /*if(allSessions[indexPath.row].locations.count == 0)
             {
             self.getLocDPs(forSesh: allSessions[indexPath.row], cell: c)
             }
             else{
             c.locations = allSessions[indexPath.row].locations
             }*/
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch(indexPath.section)
        {
        case 0:
            return self.view.frame.height*0.3
        case 1:
            return self.view.frame.width*0.8
        default:
            return self.view.frame.width*1.2
        }
        
    }
    func getSessions()
    {
        let completionHandler = {(output: AWSDynamoDBPaginatedOutput?, error: Error?) in
            if error != nil {
                print("The request failed. Error: \(String(describing: error))")
            }
            if output != nil {
                for dSesh in output!.items {
                    self.numOfSessions = self.numOfSessions+1
                    let sessionItem = dSesh as? Session
                    print("\(sessionItem!._spotTitle!)")
                    let normalSession = session(fromDBSession: sessionItem!)
                    //allSessions.append(normalSession)
                    
                    self.getSpotWithID(id: (normalSession.dbSesh?._spotID)!, forSesh: normalSession)
                }
            }
        }
        DBDownload.querySessions(completionHandler: completionHandler)
    }
    func getSpotWithID(id: String, forSesh: session)
    {
        let completionHandler = {(output: AWSDynamoDBPaginatedOutput?, error: Error?) in
            if error != nil {
                print("The request failed. Error: \(String(describing: error))")
            }
            if output != nil {
                for dspot in output!.items {
                    let spotItem = dspot as? Spot
                    print("\(spotItem!._parkHereLon!)")
                    let normalSpot = spot(fromSpot: spotItem!)
                    forSesh.seshSpot = normalSpot
                }
                
                self.getGearWithID(id: (forSesh.dbSesh?._gearID)!, forSesh: forSesh)
                
                //keep going
            }
        }
        DBDownload.querySpotWithID(id: id, completionHandler: completionHandler)
    }
    func getGearWithID(id: String, forSesh: session)
    {
        let completionHandler = {(output: AWSDynamoDBPaginatedOutput?, error: Error?) in
            if error != nil {
                print("The request failed. Error: \(String(describing: error))")
            }
            if output != nil {
                for dgear in output!.items {
                    let gearItem = dgear as? Gear
                    print("\(gearItem!._boardType!)")
                    let normalGear = gear(fromGear: gearItem!)
                    forSesh.seshGear = normalGear
                }
                self.getWindWithID(id: (forSesh.dbSesh?._windSpeedID)!, forSesh: forSesh)
                
                //keep going
            }
        }
        DBDownload.queryGearWithID(id: id, completionHandler: completionHandler)
    }
    func getWindWithID(id: String, forSesh: session)
    {
        let completionHandler = {(output: AWSDynamoDBPaginatedOutput?, error: Error?) in
            if error != nil {
                print("The request failed. Error: \(String(describing: error))")
            }
            if output != nil {
                for dwind in output!.items {
                    let windItem = dwind as? Wind
                    print("\(windItem!._speedFrom!)")
                    let normalWind = windSpeed(fromWind: windItem!)
                    forSesh.seshWindSpeed = normalWind
                }
                allSessions.append(forSesh)
                allSessions.sort(by: {$0.date.compare($1.date as Date) == ComparisonResult.orderedDescending})
                if(allSessions.count == self.numOfSessions)
                {
                    self.tableView.reloadData()
                }
                
                //keep going
            }
        }
        DBDownload.queryWindWithID(id: id, completionHandler: completionHandler)
    }
    func getLocDPs(forSesh: session, cell: sessionDisplayCollectionTableViewCell)
    {
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
                    cell.locations = forSesh.locations
                    cell.sessionDataCollView.reloadData()
                })
                //keep going
            }
        }
        DBDownload.queryLocDPsFromSessionWithID(id: (forSesh.dbSesh?._sessionID)!, completionHandler: completionHandler)
    }
}
