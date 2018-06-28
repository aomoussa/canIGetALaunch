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
    var submitState = "untapped"//tapped
    var trackerState = "max"//"in progress"
    
    
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
        cell.title.text = "Submit"
        cell.backgroundColor = UIColor.blue
        return cell
    
    }
    func makeTrackerCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    {
        switch(trackerState)
        {
        case "min":
            let cell = tableView.dequeueReusableCell(withIdentifier: "justTitleCell")! as! justTitleTableViewCell
            cell.title.text = "Tracking Session"
            cell.backgroundColor = UIColor.white
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "trackerCell")! as! sessionTrackerTableViewCell
            //cell.trackerMap.delegate = self
            cell.backgroundColor = UIColor.white
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
            break
        case submitSectionNum:
            switch(submitState)
            {
            case "tapped":
                break
            default:
                submitState = "tapped"
                theSesh.seshGear = gearStuff
                theSesh.seshSpot = pickedSpot
                theSesh.seshWindSpeed = windSpeedStuff
                theSesh.active = true
                allSessions.append(theSesh)
                let dbGear = theSesh.seshGear.makeDBGear()
                let dbWind = theSesh.seshWindSpeed.makeDBWind()
                DBUpload.createGear(dbGear)
                DBUpload.createWind(dbWind)
                DBUpload.createSesh(theSesh.makeDBSession(fromGear: dbGear, fromWindSpeed: dbWind))
                tabBarController?.selectedIndex = 0
            }
            
        default:
            break
        }
        tableView.reloadData()
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
