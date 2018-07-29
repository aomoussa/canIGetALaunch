//
//  SecondViewController.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 5/27/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit

class addViewController: UIViewController {
    
    @IBOutlet weak var seshDetailsTableView: UITableView!
    
    var spotSectionNum = 0
    var dateSectionNum = 1
    var windSpeedSectionNum = 2
    var gearSectionNum = 3
    var trackerSectionNum = 4
    var submitSectionNum = 5
    
    var pickSpotState = "min"//"max"
    var pickedSpot = spot()
    
    var dateState = "min"//"max"
    var windSpeedStuff = windSpeed()
    var gearStuff = gear()
    var submitState = "untapped"//tapped//tappedNotTracking
    var trackerState = "max"//"min"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seshDetailsTableView.delegate = self
        seshDetailsTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        submitState = "untapped"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //let defaults = UserDefaults.standard
        //defaults.set((thisSession as String), forKey: "sessions")
        // Dispose of any resources that can be recreated.
    }
    
}
extension addViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section)
        {
        case spotSectionNum:
            switch(pickSpotState)
            {
            case "max":
                return allSpots.count
            default:
                return 1
            }
        case gearSectionNum:
            switch(gearStuff.pickerState)
            {
            case "picked":
                return 2
            default:
                return 1
            }
        default:
            return 1
        }
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch(indexPath.section)
        {
        case spotSectionNum:
            return makeSpotPickerCell(tableView: tableView, indexPath: indexPath)
        case dateSectionNum:
            return makeDatePickerCell(tableView: tableView, indexPath: indexPath)
        case windSpeedSectionNum:
            return makeWindSpeedPickerCell(tableView: tableView, indexPath: indexPath)
        case gearSectionNum:
            return makeGearPickerCell(tableView: tableView, indexPath: indexPath)
        case submitSectionNum:
            return makeSubmitCell(tableView: tableView, indexPath: indexPath)
        case trackerSectionNum:
            return makeTrackerCell(tableView: tableView, indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }
    func makeSubmitCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "justTitleCell")! as! justTitleTableViewCell
        cell.backgroundColor = UIColor(red: 1, green: 57/255, blue: 105/255, alpha: 0.8)
        switch(submitState)
        {
        case "tracking":
            cell.title.text = "Submit"
            break
        case "submittedNotTracking":
            cell.title.text = "Submitted, Resume?"
            break
        case "submittedTracking":
            cell.title.text = "Submitted, Still Tracking... Stop?"
            break
        case "submitting":
            cell.title.text = "Currently Uploading..."
            cell.backgroundColor = UIColor.lightGray
            break
        case "problemUploading":
            cell.title.text = "Problem Uploading... Tap to try again"
            cell.title.adjustsFontSizeToFitWidth = true
            cell.backgroundColor = UIColor.lightGray
            break
        default://"untapped"
            cell.title.text = "Start Tracking"
        }
        return cell
        
    }
    func makeTrackerCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    {
        switch(trackerState)
        {
        case "min":
            let cell = tableView.dequeueReusableCell(withIdentifier: "justTitleCell")! as! justTitleTableViewCell
            switch(submitState)
            {
            case "tracking":
                
                cell.title.text = "Session Tracker: Tracking! Tap submit to complete session"
                break
            case "submittedNotTracking":
                
                cell.title.text = "Session Tracker: Submitted! tap resume to keep tracking"
                break
            case "submittedTracking":
                
                cell.title.text = "Session Tracker: Tracking! tap stop tracking when done"
                break
            case "submitting":
                
                cell.title.text = "Session Tracker: Working on uploading this session"
                break
            case "problemUploading":
                
                cell.title.text = "Awkward :/ your datapoints are uploaded tho so hmu to fix this"
                
                cell.backgroundColor = UIColor.lightGray
                break
            default://"untapped"
                
                cell.title.text = "Session Tracker: Tap Start Tracking to start logging session"
            }
            cell.title.adjustsFontSizeToFitWidth = true
            cell.backgroundColor = UIColor.white
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "trackerCell")! as! sessionTrackerTableViewCell
            /*
             switch(submitState)
             {
             case "tapped":
             
             cell.titleLabel.text = "Session Tracker: Tracking! Tap submit to complete session"
             break
             case "tappedNotTracking":
             
             cell.titleLabel.text = "Session Tracker: Submitted! tap resume to keep tracking"
             break
             case "submitting":
             
             cell.titleLabel.text = "Session Tracker: Working on uploading this session"
             break
             case "problemUploading":
             
             cell.titleLabel.text = "Awkward :/ your datapoints are uploaded tho so hmu to fix this"
             cell.backgroundColor = UIColor.lightGray
             break
             default://"untapped"
             
             cell.titleLabel.text = "Session Tracker: Tap Start Tracking to start logging session"
             }
             cell.titleLabel.adjustsFontSizeToFitWidth = true
             cell.backgroundColor = UIColor.white
             */
            return cell
        }
    }
    func makeDatePickerCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    {
        switch(dateState)
        {
        case "min":
            let cell = tableView.dequeueReusableCell(withIdentifier: "justTitleCell")! as! justTitleTableViewCell
            cell.title.text = "Pick Date"
            cell.backgroundColor = UIColor.white
            return cell
        case "picked":
            let cell = tableView.dequeueReusableCell(withIdentifier: "justTitleCell")! as! justTitleTableViewCell
            cell.title.text = "Picked Date: \(theSesh.date)"
            cell.backgroundColor = UIColor.white
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell")! as! datePickerTableViewCell
            cell.datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
            cell.backgroundColor = UIColor.white
            return cell
        }
    }
    func dateChanged(_ Sender: UIDatePicker)
    {
        theSesh.date = Sender.date as NSDate
    }
    func makeSpotPickerCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "justTitleCell")! as! justTitleTableViewCell
        cell.backgroundColor = UIColor.white
        
        switch(pickSpotState)
        {
        case "min":
            cell.title.text = "pick spot"
            break
        case "picked":
            cell.title.text = "picked spot: \(pickedSpot.title)"
            break
        default:
            cell.title.text = allSpots[indexPath.row].title
        }
        return cell
    }
    func makeWindSpeedPickerCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    {
        switch(windSpeedStuff.pickerState)
        {
        case "min":
            let cell = tableView.dequeueReusableCell(withIdentifier: "justTitleCell")! as! justTitleTableViewCell
            cell.title.text = "Wind Speed"
            cell.backgroundColor = UIColor.white
            return cell
        case "picked":
            let cell = tableView.dequeueReusableCell(withIdentifier: "justTitleCell")! as! justTitleTableViewCell
            cell.title.text = "Wind Speed: \(windSpeedStuff.speedFrom)-\(windSpeedStuff.speedTo)\(windSpeedStuff.units)"
            cell.backgroundColor = UIColor.white
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "windPickerCell")! as! windSpeedPickerTableViewCell
            cell.backgroundColor = UIColor.white
            cell.speedFrom.delegate = self
            cell.speedFrom.dataSource = self
            cell.speedFrom.tag = 0
            cell.speedTo.delegate = self
            cell.speedTo.dataSource = self
            cell.speedTo.tag = 1
            cell.speedUnits.delegate = self
            cell.speedUnits.dataSource = self
            cell.speedUnits.tag = 2
            return cell
        }
        
    }
    func makeGearPickerCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    {
        switch(gearStuff.pickerState)
        {
        case "min":
            let cell = tableView.dequeueReusableCell(withIdentifier: "justTitleCell")! as! justTitleTableViewCell
            cell.title.text = "Gear"
            cell.backgroundColor = UIColor.white
            return cell
        case "picked":
            let cell = tableView.dequeueReusableCell(withIdentifier: "justTitleCell")! as! justTitleTableViewCell
            switch(indexPath.row)
            {
            case 0:
                cell.title.text = "Board: \(gearStuff.boardType)-\(gearStuff.boardSize)cm \(gearStuff.boardBrand)\n"
            default:
                cell.title.text = "Kite: \(gearStuff.kiteType)-\(gearStuff.kiteSize)m \(gearStuff.kiteBrand)"
            }
            cell.backgroundColor = UIColor.white
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "gearPickerCell")! as! gearPickerTableViewCell
            cell.backgroundColor = UIColor.white
            cell.boardBrandPicker.delegate = self
            cell.boardBrandPicker.dataSource = self
            cell.boardBrandPicker.tag = 3
            
            cell.boardSizePicker.delegate = self
            cell.boardSizePicker.dataSource = self
            cell.boardSizePicker.tag = 4
            
            cell.boardTypePicker.delegate = self
            cell.boardTypePicker.dataSource = self
            cell.boardTypePicker.tag = 5
            
            cell.kiteBrandPicker.delegate = self
            cell.kiteBrandPicker.dataSource = self
            cell.kiteBrandPicker.tag = 6
            
            cell.kiteSizePicker.delegate = self
            cell.kiteSizePicker.dataSource = self
            cell.kiteSizePicker.tag = 7
            
            cell.kiteTypePicker.delegate = self
            cell.kiteTypePicker.dataSource = self
            cell.kiteTypePicker.tag = 8
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.section)
        {
        case spotSectionNum:
            switch(pickSpotState)
            {
            case "min":
                pickSpotState = "max"
                break
            case "max":
                pickSpotState = "picked"
                pickedSpot = allSpots[indexPath.row]
            default:
                pickSpotState = "min"
            }
            tableView.reloadSections([spotSectionNum], with: UITableViewRowAnimation.fade)
            break
        case dateSectionNum:
            switch(dateState)
            {
            case "min":
                dateState = "max"
                break
            case "max":
                dateState = "picked"
                break
            default:
                dateState = "max"
            }
            tableView.reloadSections([dateSectionNum], with: UITableViewRowAnimation.fade)
            break
        case windSpeedSectionNum:
            switch(windSpeedStuff.pickerState)
            {
            case "min":
                windSpeedStuff.pickerState = "max"
                break
            case "max":
                windSpeedStuff.pickerState = "picked"
                break
            default:
                windSpeedStuff.pickerState = "max"
            }
            tableView.reloadSections([windSpeedSectionNum], with: UITableViewRowAnimation.fade)
            break
        case gearSectionNum:
            switch(gearStuff.pickerState)
            {
            case "min":
                gearStuff.pickerState = "max"
                break
            case "max":
                gearStuff.pickerState = "picked"
                break
            default:
                gearStuff.pickerState = "max"
            }
            tableView.reloadSections([gearSectionNum], with: UITableViewRowAnimation.fade)
            break
        case trackerSectionNum:
            switch(trackerState)
            {
            case "min":
                trackerState = "max"
                break
            default:
                trackerState = "min"
            }
            tableView.reloadSections([trackerSectionNum], with: UITableViewRowAnimation.fade)
            break
        case submitSectionNum:
            switch(submitState)
            {
            case "problemUploading":
                submitState = ""
            case "tracking":
                submitState = "submitting"
                theSesh.seshGear = gearStuff
                theSesh.seshSpot = pickedSpot
                theSesh.seshWindSpeed = windSpeedStuff
                theSesh.active = false
                allSessions.append(theSesh)
                let dbGear = theSesh.seshGear.makeDBGear()
                let dbWind = theSesh.seshWindSpeed.makeDBWind()
                let sessionCompletionHandler = {
                    (error: Error?) -> Void in
                    
                    if let error = error {
                        print("Amazon DynamoDB Save Error: \(error)")
                        self.submitState = "problemUploading"
                        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
                        if(self.trackerState == "min")
                        {
                            tableView.reloadRows(at: [IndexPath.init(row: 0, section: self.trackerSectionNum)], with: UITableViewRowAnimation.fade)
                        }
                        return
                    }
                    DispatchQueue.main.async(execute: {
                        print("An item was saved.")
                        self.submitState = "submittedNotTracking"
                        tableView.reloadSections([self.submitSectionNum], with: UITableViewRowAnimation.fade)
                        if(self.trackerState == "min")
                        {
                            tableView.reloadRows(at: [IndexPath.init(row: 0, section: self.trackerSectionNum)], with: UITableViewRowAnimation.fade)
                        }
                    })
                }
                let windCompletionHandler = {
                    (error: Error?) -> Void in
                    
                    if let error = error {
                        print("Amazon DynamoDB Save Error: \(error)")
                        self.submitState = "problemUploading"
                        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
                        if(self.trackerState == "min")
                        {
                            tableView.reloadRows(at: [IndexPath.init(row: 0, section: self.trackerSectionNum)], with: UITableViewRowAnimation.fade)
                        }
                        return
                    }
                    print("An item was saved.")
                    DBUpload.createSesh(theSesh.makeDBSession(fromGear: dbGear, fromWindSpeed: dbWind), completionHandler: sessionCompletionHandler)
                    
                }
                let gearCompletionHandler = {
                    (error: Error?) -> Void in
                    
                    if let error = error {
                        print("Amazon DynamoDB Save Error: \(error)")
                        self.submitState = "problemUploading"
                        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
                        if(self.trackerState == "min")
                        {
                            tableView.reloadRows(at: [IndexPath.init(row: 0, section: self.trackerSectionNum)], with: UITableViewRowAnimation.fade)
                        }
                        return
                    }
                    print("An item was saved.")
                    DBUpload.createWind(dbWind, completionHandler: windCompletionHandler)
                }
                
                
                DBUpload.createGear(dbGear, completionHandler: gearCompletionHandler)
                
                
                break
            case "submittedTracking":
                theSesh.active = false
                submitState = "submittedNotTracking"
                tableView.reloadSections([self.submitSectionNum], with: UITableViewRowAnimation.fade)
                break
            case "submittedNotTracking":
                theSesh.active = true
                submitState = "submittedTracking"
                tableView.reloadSections([self.submitSectionNum], with: UITableViewRowAnimation.fade)
                break
            case "submitting":
                //do nothing until submission complete
                //submitState = "chilllll"
                break
            default://case "untapped": //when not submitted and not tracking
                theSesh.active = true
                submitState = "tracking"
                tableView.reloadSections([self.submitSectionNum], with: UITableViewRowAnimation.fade)
            }
            if(self.trackerState == "min")
            {
                tableView.reloadRows(at: [IndexPath.init(row: 0, section: self.trackerSectionNum)], with: UITableViewRowAnimation.fade)
            }
        default:
            break
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch(indexPath.section)
        {
        case spotSectionNum:
            return 50
        case windSpeedSectionNum:
            switch(windSpeedStuff.pickerState)
            {
            case "max":
                return 200
            default:
                return 50
            }
        case dateSectionNum:
            switch(dateState)
            {
            case "max":
                return 200
            default:
                return 50
            }
        case gearSectionNum:
            switch(gearStuff.pickerState)
            {
            case "max":
                return 400
            default:
                return 50
            }
        case trackerSectionNum:
            switch(trackerState)
            {
            case "max":
                return 400
            default:
                return 50
            }
        default:
            return 50
        }
    }
    
}
extension addViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch(pickerView.tag)
        {
        case 0:
            return 40
        case 1:
            return 40
        case 2:
            return windSpeedStuff.speedUnits.count
            
        //board stuff
        case 3://brand
            return gearStuff.brands.count
        case 4://size
            return 40
        case 5://type
            return gearStuff.boardTypes.count
            
        //kite stuff
        case 6://brand
            return gearStuff.brands.count
        case 7://size
            return 20
        case 8://type
            return gearStuff.kiteTypes.count
            
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch(pickerView.tag)
        {
        case 0:
            return "\(row)"
        case 1:
            return "\(row)"
        case 2:
            return windSpeedStuff.speedUnits[row]
            
        //board stuff
        case 3://brand
            return gearStuff.brands[row]
        case 4://size
            return "\(120 + row)"
        case 5://type
            return gearStuff.boardTypes[row]
            
        //kite stuff
        case 6://brand
            return gearStuff.brands[row]
        case 7://size
            return "\(row + 1)"
        case 8://type
            return gearStuff.kiteTypes[row]
            
        default:
            return "\(row)"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch(pickerView.tag)
        {
        case 0:
            windSpeedStuff.speedFrom = row
        case 1:
            windSpeedStuff.speedTo = row
        case 2:
            windSpeedStuff.units = windSpeedStuff.speedUnits[row]
            
        //board stuff
        case 3://brand
            gearStuff.boardBrand = gearStuff.brands[row]
        case 4://size
            gearStuff.boardSize = 120 + row
        case 5://type
            gearStuff.boardType = gearStuff.boardTypes[row]
            
        //kite stuff
        case 6://brand
            gearStuff.kiteBrand = gearStuff.brands[row]
        case 7://size
            gearStuff.kiteSize = row + 1
        case 8://type
            gearStuff.kiteType = gearStuff.kiteTypes[row]
            
        default:
            return
        }
    }
    
}
