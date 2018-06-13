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
    
    var pickSpotState = "min"//"max"
    var pickedSpot = spot()
    
    var windSpeedStuff = windSpeed()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seshDetailsTableView.delegate = self
        seshDetailsTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension addViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section)
        {
        case 0:
            switch(pickSpotState)
            {
            case "max":
                return allSpots.count
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
        case 0:
            return makeSpotPickerCell(tableView: tableView, indexPath: indexPath)
        case 1:
            return makeWindSpeedPickerCell(tableView: tableView, indexPath: indexPath)
        default:
            return UITableViewCell()
        }
        
        
        
    }
    func makeSpotPickerCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "justTitleCell")! as! justTitleTableViewCell
        

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
            return cell
        case "picked":
            let cell = tableView.dequeueReusableCell(withIdentifier: "justTitleCell")! as! justTitleTableViewCell
            cell.title.text = "Wind Speed: \(windSpeedStuff.speedFrom)-\(windSpeedStuff.speedTo)\(windSpeedStuff.units)"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "windPickerCell")! as! windSpeedPickerTableViewCell
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.section)
        {
        case 0:
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
        case 1:
            switch(windSpeedStuff.pickerState)
            {
            case "min":
                windSpeedStuff.pickerState = "max"
                break
            case "max":
                windSpeedStuff.pickerState = "picked"
                break
            default:
                windSpeedStuff.pickerState = "min"
            }
            break
        default:
            break
        }
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch(indexPath.section)
        {
        case 0:
            return 50
        case 1:
            switch(windSpeedStuff.pickerState)
            {
            case "max":
                return 200
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
        default:
            return windSpeedStuff.speedUnits.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch(pickerView.tag)
        {
        case 0:
            return "\(row)"
        case 1:
            return "\(row)"
        default:
            return windSpeedStuff.speedUnits[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch(pickerView.tag)
        {
        case 0:
            windSpeedStuff.speedFrom = row
        case 1:
            windSpeedStuff.speedTo = row
        default:
            return windSpeedStuff.units = windSpeedStuff.speedUnits[row]
        }
    }
    
}
