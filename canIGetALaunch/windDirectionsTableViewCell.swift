//
//  windDirectionsTableViewCell.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/15/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit

class windDirectionsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var good: UIButton!
    @IBOutlet weak var bad: UIButton!
    @IBOutlet weak var n: UIButton!
    @IBOutlet weak var ne: UIButton!
    @IBOutlet weak var e: UIButton!
    @IBOutlet weak var se: UIButton!
    @IBOutlet weak var s: UIButton!
    @IBOutlet weak var sw: UIButton!
    @IBOutlet weak var w: UIButton!
    @IBOutlet weak var nw: UIButton!
    
    var goodWinds = [String]()
    var badWinds = ["n","ne", "e", "se", "s", "sw", "w", "nw"]
    var state = "good"//"bad"
    
    @IBAction func goodTappd(_ sender: UIButton) {
        good.backgroundColor = UIColor.green
        bad.backgroundColor = UIColor.gray
        state = "good"
    }
    @IBAction func badTapped(_ sender: UIButton) {
        bad.backgroundColor = UIColor.red
        good.backgroundColor = UIColor.gray
        state = "bad"
    }
    
    @IBAction func northTapped(_ sender: UIButton) {
        switch(state)
        {
        case "good":
            n.backgroundColor = UIColor.green
            if(badWinds.contains("n"))
            {
                badWinds.remove(at: badWinds.index(of: "n")!)
            }
            if(!goodWinds.contains("n"))
            {
                goodWinds.append("n")
            }
        default:
            n.backgroundColor = UIColor.red
            if(goodWinds.contains("n"))
            {
                goodWinds.remove(at: goodWinds.index(of: "n")!)
            }
            if(!badWinds.contains("n"))
            {
                badWinds.append("n")
            }
        }
        theSpot.windDirections = goodWinds
    }
    @IBAction func neTapped(_ sender: UIButton) {
        switch(state)
        {
        case "good":
            ne.backgroundColor = UIColor.green
            if(badWinds.contains("ne"))
            {
                badWinds.remove(at: badWinds.index(of: "ne")!)
            }
            if(!goodWinds.contains("ne"))
            {
                goodWinds.append("ne")
            }
        default:
            ne.backgroundColor = UIColor.red
            if(goodWinds.contains("ne"))
            {
                goodWinds.remove(at: goodWinds.index(of: "ne")!)
            }
            if(!badWinds.contains("ne"))
            {
                badWinds.append("ne")
            }
        }
        theSpot.windDirections = goodWinds
    }
    @IBAction func eTapped(_ sender: UIButton) {
        switch(state)
        {
        case "good":
            e.backgroundColor = UIColor.green
            if(badWinds.contains("e"))
            {
                badWinds.remove(at: badWinds.index(of: "e")!)
            }
            if(!goodWinds.contains("e"))
            {
                goodWinds.append("e")
            }
        default:
            e.backgroundColor = UIColor.red
            if(goodWinds.contains("e"))
            {
                goodWinds.remove(at: goodWinds.index(of: "e")!)
            }
            if(!badWinds.contains("e"))
            {
                badWinds.append("e")
            }
        }
        theSpot.windDirections = goodWinds
    }
    @IBAction func seTapped(_ sender: UIButton) {
        switch(state)
        {
        case "good":
            se.backgroundColor = UIColor.green
            if(badWinds.contains("se"))
            {
                badWinds.remove(at: badWinds.index(of: "se")!)
            }
            if(!goodWinds.contains("se"))
            {
                goodWinds.append("se")
            }
        default:
            se.backgroundColor = UIColor.red
            if(goodWinds.contains("se"))
            {
                goodWinds.remove(at: goodWinds.index(of: "se")!)
            }
            if(!badWinds.contains("se"))
            {
                badWinds.append("se")
            }
        }
        theSpot.windDirections = goodWinds
    }
    @IBAction func sTapped(_ sender: UIButton) {
        switch(state)
        {
        case "good":
            s.backgroundColor = UIColor.green
            if(badWinds.contains("s"))
            {
                badWinds.remove(at: badWinds.index(of: "s")!)
            }
            if(!goodWinds.contains("s"))
            {
                goodWinds.append("s")
            }
        default:
            s.backgroundColor = UIColor.red
            if(goodWinds.contains("s"))
            {
                goodWinds.remove(at: goodWinds.index(of: "s")!)
            }
            if(!badWinds.contains("s"))
            {
                badWinds.append("s")
            }
        }
        theSpot.windDirections = goodWinds
    }
    @IBAction func swTapped(_ sender: UIButton) {
        switch(state)
        {
        case "good":
            sw.backgroundColor = UIColor.green
            if(badWinds.contains("sw"))
            {
                badWinds.remove(at: badWinds.index(of: "sw")!)
            }
            if(!goodWinds.contains("sw"))
            {
                goodWinds.append("sw")
            }
        default:
            sw.backgroundColor = UIColor.red
            if(goodWinds.contains("sw"))
            {
                goodWinds.remove(at: goodWinds.index(of: "sw")!)
            }
            if(!badWinds.contains("sw"))
            {
                badWinds.append("sw")
            }
        }
        theSpot.windDirections = goodWinds
    }
    @IBAction func wTapped(_ sender: UIButton) {
        switch(state)
        {
        case "good":
            w.backgroundColor = UIColor.green
            if(badWinds.contains("w"))
            {
                badWinds.remove(at: badWinds.index(of: "w")!)
            }
            if(!goodWinds.contains("w"))
            {
                goodWinds.append("w")
            }
        default:
            w.backgroundColor = UIColor.red
            if(goodWinds.contains("w"))
            {
                goodWinds.remove(at: goodWinds.index(of: "w")!)
            }
            if(!badWinds.contains("w"))
            {
                badWinds.append("w")
            }
        }
        theSpot.windDirections = goodWinds
    }
    @IBAction func nwTapped(_ sender: UIButton) {
        switch(state)
        {
        case "good":
            nw.backgroundColor = UIColor.green
            if(badWinds.contains("nw"))
            {
                badWinds.remove(at: badWinds.index(of: "nw")!)
            }
            if(!goodWinds.contains("nw"))
            {
                goodWinds.append("nw")
            }
        default:
            nw.backgroundColor = UIColor.red
            if(goodWinds.contains("nw"))
            {
                goodWinds.remove(at: goodWinds.index(of: "nw")!)
            }
            if(!badWinds.contains("nw"))
            {
                badWinds.append("nw")
            }
        }
        theSpot.windDirections = goodWinds
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        theSpot.windDirections = goodWinds
        // Configure the view for the selected state
    }
    
}
