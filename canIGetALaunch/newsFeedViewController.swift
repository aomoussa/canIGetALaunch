//
//  newsFeedViewController.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/16/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit
import AWSDynamoDB
import AWSAuthCore

class newsFeedViewController: UIViewController {
    
    var selectedSessionIndex = 0
    var numOfSessions = 0
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        if(allSessions.count == 0)
        {
            getSessions()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //getSessions()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                    
                    self.getKiterWithID(id: normalSession.dbSesh?._kiterId ?? thisKiter.id, forSesh: normalSession)
                }
            }
        }
        DBDownload.querySessions(completionHandler: completionHandler)
    }
    func getKiterWithID(id: String, forSesh: session)
    {
        let completionHandler = {(output: AWSDynamoDBPaginatedOutput?, error: Error?) in
            if error != nil {
                print("The request failed. Error: \(String(describing: error))")
            }
            if output != nil {
                for dkiter in output!.items {
                    let kiterItem = dkiter as? Kiter
                    print("\(kiterItem!._kiterName!)")
                    let normalKiter = kiter(fromDBKiter: kiterItem!)
                    forSesh.seshKiter = normalKiter
                }
                self.getGearWithID(id: (forSesh.dbSesh?._gearID)!, forSesh: forSesh)
                
                //keep going
            }
        }
        DBDownload.queryKiterWithID(id: id, completionHandler: completionHandler)
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
extension newsFeedViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section)
        {
        case 0:
            return 1
        case 1:
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
            return makeMultipleSessionCell(tableView: tableView, indexPath: indexPath)
        default:
            return makeSessionCell(tableView: tableView, indexPath: indexPath)
        }
    }
    func makeViewDescriptionCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as! descriptionTableViewCell
        cell.descriptionLabel.text = "Wanna see how your buddies living the kite life have been conquering beaches, lakes, and rivers around the world? Zoom in to see, these public sessions fellow kiters wanted to share, close up:"
        return cell
    }
    func makeMultipleSessionCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "multipleSessionCell", for: indexPath) as! multipleSessionsTableViewCell
        cell.titleLabel.text = "Public Sessions"
        return cell
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
        cell.seshNum = indexPath.row
        cell.sessionDataCollView.tag = indexPath.row
        
        cell.sessionDataCollView.reloadData()
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
            return self.view.frame.width*1.2
        default:
            return self.view.frame.width*1.2
        }
    }
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedSessionIndex = indexPath.row
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        
    }*/
    
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "showSessionDetails" {
     if let vc = segue.destination as? sessionDisplayViewController {
     vc.sesh = selectedSession
     }
     }
     }*/
}
