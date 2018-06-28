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
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        getSessions()
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
                    let sessionItem = dSesh as? Session
                    print("\(sessionItem!._spotTitle!)")
                    let normalSession = session(fromDBSession: sessionItem!)
                    
                    self.getGearWithID(id: (normalSession.dbSesh?._gearID)!, forSesh: normalSession)
                }
            }
        }
        DBDownload.querySessions(completionHandler: completionHandler)
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
                self.tableView.reloadData()
                
                
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
                    print("\(locItem!._timestamp!)")
                    forSesh.addLoc(dbLocDP: locItem!)
                }
                cell.locations = forSesh.locations
                cell.sessionDataCollView.reloadData()
                //keep going
            }
        }
        DBDownload.queryLocDPsFromSessionWithID(id: (forSesh.dbSesh?._sessionID)!, completionHandler: completionHandler)
    }
    
}
extension newsFeedViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSessions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sessionDisplayControllerCell", for: indexPath) as! sessionDisplayCollectionTableViewCell
        cell.gearLabel.text = allSessions[indexPath.row].seshGear.toString()
        cell.kiterNameLabel.text = "Ahmed Moussa"
        cell.spotTitleLabel.text = allSessions[indexPath.row].seshSpot.title
        cell.windLabel.text = allSessions[indexPath.row].seshWindSpeed.toString()
        cell.dateLabel.text = allSessions[indexPath.row].date.description
        
        return cell
        /*let cell = tableView.dequeueReusableCell(withIdentifier: "sessionDisplayCell", for: indexPath) as! sessionDisplayTableViewCell
         cell.gear.text = allSessions[indexPath.row].seshGear.toString()
         cell.kiterName.text = "Ahmed Moussa"
         cell.spotTitle.text = allSessions[indexPath.row].seshSpot.title
         cell.wind.text = allSessions[indexPath.row].seshWindSpeed.toString()
         cell.date.text = allSessions[indexPath.row].date.description
         
         return cell*/
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let c = cell as? sessionDisplayCollectionTableViewCell
        {
            if(c.locations.count == 0)
            {
                self.getLocDPs(forSesh: allSessions[indexPath.row], cell: c)
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch(indexPath.row)
        {
        case selectedSessionIndex:
            return self.view.frame.height
        default:
            return 300
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSessionIndex = indexPath.row
        //self.performSegue(withIdentifier: "showSessionDetails", sender: allSessions[indexPath.row])
        return
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSessionDetails" {
            if let vc = segue.destination as? sessionDisplayViewController {
                vc.sesh = selectedSession
            }
        }
    }*/
}
