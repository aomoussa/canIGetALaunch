//
//  sessionDisplayViewController.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/25/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit

class sessionDisplayViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var sesh = session()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
extension sessionDisplayViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let width = self.view.frame.width
        let height = self.view.frame.height
        let cell = tableView.dequeueReusableCell(withIdentifier: "sessionDisplayCell", for: indexPath) as! sessionDisplayTableViewCell
        cell.gear.text = sesh.seshGear.toString()
        cell.kiterName.text = "Ahmed Moussa"
        cell.spotTitle.text = sesh.seshSpot.title
        cell.wind.text = sesh.seshWindSpeed.toString()
        cell.date.text = sesh.date.description
        cell.locations = sesh.locations
        
        let windArrow = UILabel(frame: CGRect(x: width*0.2, y: height*0.4, width: width*0.1, height: width*0.2))
        windArrow.transform = CGAffineTransform(rotationAngle: 2*CGFloat.pi*0.1)
        cell.addSubview(windArrow)
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let c = cell as? sessionDisplayTableViewCell
        {
            c.makeLine()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
}
