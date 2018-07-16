//
//  createSpotViewController.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/14/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit
import MapKit

class createSpotViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var spotNameSection = 0
    var spotLocationsSection = 1
    var difficultySection = 2
    var windDirectionSection = 3
    var seasonSection = 4
    var submitSection = 5
    
    var spotNameState = "max"//min//picked
    var spotLocationPickerState = "max"//min//saved?
    var difficultyState = "max"//min
    var windDirectionState = "max"//min//picked
    var seasonState = "max"//"min"
    var submitState = "unpicked"//picked
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension createSpotViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.section)
        {
        case spotNameSection:
            return makeSpotNameCell(tableView: tableView, cellForRowAt: indexPath)
        case spotLocationsSection:
            return makeSpotLocationsCell(tableView: tableView, cellForRowAt: indexPath)
        case difficultySection:
            return makeDifficultyCell(tableView: tableView, cellForRowAt: indexPath)
        case windDirectionSection:
            return makeWindDirectionsCell(tableView: tableView, cellForRowAt: indexPath)
        case submitSection:
            return makeSubmitCell(tableView: tableView, cellForRowAt: indexPath)
        case seasonSection:
            return makeSeasonCell(tableView: tableView, cellForRowAt: indexPath)
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "justTitleCell")! as! justTitleTableViewCell
            cell.title.text = "Shouldn't happen"
            return cell
        }
        
    }
    
    func makeSubmitCell(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "justTitleCell")! as! justTitleTableViewCell
        cell.title.text = "Submit"

        cell.backgroundColor = UIColor.blue
        return cell
    }
    func makeDifficultyCell(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch(difficultyState)
        {
        case "max":
            let cell = tableView.dequeueReusableCell(withIdentifier: "difficultyCell", for: indexPath) as! difficultyTableViewCell
            cell.backgroundColor = UIColor.white
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "justTitleCell")! as! justTitleTableViewCell
            cell.title.text = "Difficulty"
            cell.backgroundColor = UIColor.white
            return cell
        }
    }
    func makeSeasonCell(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch(seasonState)
        {
        case "max":
            let cell = tableView.dequeueReusableCell(withIdentifier: "seasonCell", for: indexPath) as! seasonTableViewCell
            cell.backgroundColor = UIColor.white
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "justTitleCell")! as! justTitleTableViewCell
            cell.title.text = "Season"
            cell.backgroundColor = UIColor.white
            return cell
        }
    }
    func makeWindDirectionsCell(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch(windDirectionState)
        {
        case "max":
            let cell = tableView.dequeueReusableCell(withIdentifier: "windDirectionsCell", for: indexPath) as! windDirectionsTableViewCell
            cell.backgroundColor = UIColor.white
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "justTitleCell")! as! justTitleTableViewCell
            cell.title.text = "Wind directions"
            cell.backgroundColor = UIColor.white
            return cell
        }
    }
    func makeSpotLocationsCell(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch(spotLocationPickerState)
        {
        case "max":
            let cell = tableView.dequeueReusableCell(withIdentifier: "spotLocationCell", for: indexPath) as! spotLocationPickerTableViewCell
            cell.backgroundColor = UIColor.white
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "justTitleCell")! as! justTitleTableViewCell
            cell.title.text = "Spot Locations"
            cell.backgroundColor = UIColor.white
            return cell
        }
    }
    
    func makeSpotNameCell(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch(spotNameState)
        {
        case "max":
            let cell = tableView.dequeueReusableCell(withIdentifier: "spotNameCell", for: indexPath) as! spotNameTableViewCell
            cell.spotNameTextField.delegate = self
            cell.backgroundColor = UIColor.white
            return cell
        case "picked":
            let cell = tableView.dequeueReusableCell(withIdentifier: "justTitleCell")! as! justTitleTableViewCell
            cell.title.text = "Spot Name: \(theSpot.title)"
            cell.backgroundColor = UIColor.white
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "justTitleCell")! as! justTitleTableViewCell
            cell.title.text = "Spot Name"
            cell.backgroundColor = UIColor.white
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch(indexPath.section)
        {
        case spotNameSection:
            switch(spotNameState)
            {
            case "max":
                return 100
            default:
                return 50
            }
            
        case spotLocationsSection:
            switch(spotLocationPickerState)
            {
            case "max":
                return self.view.frame.height
            default:
                return 50
            }
        case difficultySection:
            switch(difficultyState)
            {
            case "max":
                return 150
            default:
                return 50
            }
        case windDirectionSection:
            switch(windDirectionState)
            {
            case "max":
                return 150
            default:
                return 50
            }
        case seasonSection:
            switch(seasonState)
            {
            case "max":
                return 150
            default:
                return 50
            }
        default:
            return 100
        }
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.section)
        {
        case spotNameSection:
            switch(spotNameState)
            {
            case "max":
                spotNameState = "picked"
                break
            default:
                spotNameState = "max"
            }
            break
        case spotLocationsSection:
            switch(spotLocationPickerState)
            {
            case "max":
                spotLocationPickerState = "min"
                break
            default:
                spotLocationPickerState = "max"
            }
            break
        case difficultySection:
            switch(difficultyState)
            {
            case "max":
                difficultyState = "min"
                break
            default:
                difficultyState = "max"
            }
            break
        case windDirectionSection:
            switch(windDirectionState)
            {
            case "max":
                windDirectionState = "min"
                break
            default:
                windDirectionState = "max"
            }
            break
        case seasonSection:
            switch(seasonState)
            {
            case "max":
                seasonState = "min"
                break
            default:
                seasonState = "max"
            }
            break
        case submitSection:
            switch(submitState)
            {
            case "unpicked":
                
                DBUpload.createSpot(theSpot.makeDBSpot(), completionHandler: {
                    (error: Error?) -> Void in
                    
                    if let error = error {
                        print("Amazon DynamoDB Save Error: \(error)")
                        return
                    }
                    self.tabBarController?.selectedIndex = 0
                    self.performSegue(withIdentifier: "toSpots", sender: self)
                    print("An item was saved.")
                })
                allSpots.append(theSpot)
                //do something with "theSpot"
            default:
                break
            }
            break
        default:
            break
        }
        tableView.reloadData()
    }
    
}
extension createSpotViewController: UITextFieldDelegate
{
    func textFieldDidChange(_ textField: UITextField) {
        theSpot.title = textField.text!
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        theSpot.title = textField.text!
    }
}
