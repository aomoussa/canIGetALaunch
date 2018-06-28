//
//  seasonTableViewCell.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/15/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit

class seasonTableViewCell: UITableViewCell {
    
    var goodMonths = [String]()
    var badMonths = ["jan","feb", "apr", "may", "june", "july", "aug", "sep", "oct", "nov","dec"]
    var state = "good"//"bad"

    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var badButton: UIButton!
    
    @IBAction func goodTap(_ sender: UIButton) {
        goodButton.backgroundColor = UIColor.green
        badButton.backgroundColor = UIColor.gray
        state = "good"
    }
    @IBAction func badTap(_ sender: UIButton) {
        goodButton.backgroundColor = UIColor.gray
        badButton.backgroundColor = UIColor.red
        state = "bad"
    }
    @IBAction func janTap(_ sender: UIButton) {
        switch(state)
        {
        case "good":
            sender.backgroundColor = UIColor.green
            if(badMonths.contains("jan"))
            {
                badMonths.remove(at: badMonths.index(of: "jan")!)
            }
            if(!goodMonths.contains("jan"))
            {
                goodMonths.append("jan")
            }
        default:
            sender.backgroundColor = UIColor.red
            if(goodMonths.contains("jan"))
            {
                goodMonths.remove(at: goodMonths.index(of: "jan")!)
            }
            if(!badMonths.contains("jan"))
            {
                badMonths.append("jan")
            }
        }

    }
    @IBAction func febTap(_ sender: UIButton) {
        switch(state)
        {
        case "good":
            sender.backgroundColor = UIColor.green
            if(badMonths.contains("feb"))
            {
                badMonths.remove(at: badMonths.index(of: "feb")!)
            }
            if(!goodMonths.contains("feb"))
            {
                goodMonths.append("feb")
            }
        default:
            sender.backgroundColor = UIColor.red
            if(goodMonths.contains("feb"))
            {
                goodMonths.remove(at: goodMonths.index(of: "feb")!)
            }
            if(!badMonths.contains("feb"))
            {
                badMonths.append("feb")
            }
        }
    }
    @IBAction func marTap(_ sender: UIButton) {
        switch(state)
        {
        case "good":
            sender.backgroundColor = UIColor.green
            if(badMonths.contains("mar"))
            {
                badMonths.remove(at: badMonths.index(of: "mar")!)
            }
            if(!goodMonths.contains("mar"))
            {
                goodMonths.append("mar")
            }
        default:
            sender.backgroundColor = UIColor.red
            if(goodMonths.contains("mar"))
            {
                goodMonths.remove(at: goodMonths.index(of: "mar")!)
            }
            if(!badMonths.contains("mar"))
            {
                badMonths.append("mar")
            }
        }
    }
    @IBAction func aprTap(_ sender: UIButton) {
        switch(state)
        {
        case "good":
            sender.backgroundColor = UIColor.green
            if(badMonths.contains("apr"))
            {
                badMonths.remove(at: badMonths.index(of: "apr")!)
            }
            if(!goodMonths.contains("apr"))
            {
                goodMonths.append("apr")
            }
        default:
            sender.backgroundColor = UIColor.red
            if(goodMonths.contains("apr"))
            {
                goodMonths.remove(at: goodMonths.index(of: "apr")!)
            }
            if(!badMonths.contains("apr"))
            {
                badMonths.append("apr")
            }
        }
    }
    @IBAction func mayTap(_ sender: UIButton) {
        switch(state)
        {
        case "good":
            sender.backgroundColor = UIColor.green
            if(badMonths.contains("may"))
            {
                badMonths.remove(at: badMonths.index(of: "may")!)
            }
            if(!goodMonths.contains("may"))
            {
                goodMonths.append("may")
            }
        default:
            sender.backgroundColor = UIColor.red
            if(goodMonths.contains("may"))
            {
                goodMonths.remove(at: goodMonths.index(of: "may")!)
            }
            if(!badMonths.contains("may"))
            {
                badMonths.append("may")
            }
        }
    }
    @IBAction func juneTap(_ sender: UIButton) {
        switch(state)
        {
        case "good":
            sender.backgroundColor = UIColor.green
            if(badMonths.contains("june"))
            {
                badMonths.remove(at: badMonths.index(of: "june")!)
            }
            if(!goodMonths.contains("june"))
            {
                goodMonths.append("june")
            }
        default:
            sender.backgroundColor = UIColor.red
            if(goodMonths.contains("june"))
            {
                goodMonths.remove(at: goodMonths.index(of: "june")!)
            }
            if(!badMonths.contains("june"))
            {
                badMonths.append("june")
            }
        }
    }
    @IBAction func julyTap(_ sender: UIButton) {
        switch(state)
        {
        case "good":
            sender.backgroundColor = UIColor.green
            if(badMonths.contains("july"))
            {
                badMonths.remove(at: badMonths.index(of: "july")!)
            }
            if(!goodMonths.contains("july"))
            {
                goodMonths.append("july")
            }
        default:
            sender.backgroundColor = UIColor.red
            if(goodMonths.contains("july"))
            {
                goodMonths.remove(at: goodMonths.index(of: "july")!)
            }
            if(!badMonths.contains("july"))
            {
                badMonths.append("july")
            }
        }
    }
    @IBAction func augTap(_ sender: UIButton) {
        switch(state)
        {
        case "good":
            sender.backgroundColor = UIColor.green
            if(badMonths.contains("aug"))
            {
                badMonths.remove(at: badMonths.index(of: "aug")!)
            }
            if(!goodMonths.contains("aug"))
            {
                goodMonths.append("aug")
            }
        default:
            sender.backgroundColor = UIColor.red
            if(goodMonths.contains("aug"))
            {
                goodMonths.remove(at: goodMonths.index(of: "aug")!)
            }
            if(!badMonths.contains("aug"))
            {
                badMonths.append("aug")
            }
        }
    }
    @IBAction func sepTap(_ sender: UIButton) {
        switch(state)
        {
        case "good":
            sender.backgroundColor = UIColor.green
            if(badMonths.contains("sep"))
            {
                badMonths.remove(at: badMonths.index(of: "sep")!)
            }
            if(!goodMonths.contains("sep"))
            {
                goodMonths.append("sep")
            }
        default:
            sender.backgroundColor = UIColor.red
            if(goodMonths.contains("sep"))
            {
                goodMonths.remove(at: goodMonths.index(of: "sep")!)
            }
            if(!badMonths.contains("sep"))
            {
                badMonths.append("sep")
            }
        }
    }
    @IBAction func octTap(_ sender: UIButton) {
        switch(state)
        {
        case "good":
            sender.backgroundColor = UIColor.green
            if(badMonths.contains("oct"))
            {
                badMonths.remove(at: badMonths.index(of: "oct")!)
            }
            if(!goodMonths.contains("oct"))
            {
                goodMonths.append("oct")
            }
        default:
            sender.backgroundColor = UIColor.red
            if(goodMonths.contains("oct"))
            {
                goodMonths.remove(at: goodMonths.index(of: "oct")!)
            }
            if(!badMonths.contains("oct"))
            {
                badMonths.append("oct")
            }
        }
    }
    @IBAction func novTap(_ sender: UIButton) {
        switch(state)
        {
        case "good":
            sender.backgroundColor = UIColor.green
            if(badMonths.contains("nov"))
            {
                badMonths.remove(at: badMonths.index(of: "nov")!)
            }
            if(!goodMonths.contains("nov"))
            {
                goodMonths.append("nov")
            }
        default:
            sender.backgroundColor = UIColor.red
            if(goodMonths.contains("nov"))
            {
                goodMonths.remove(at: goodMonths.index(of: "nov")!)
            }
            if(!badMonths.contains("nov"))
            {
                badMonths.append("nov")
            }
        }
    }
    @IBAction func decTap(_ sender: UIButton) {
        switch(state)
        {
        case "good":
            sender.backgroundColor = UIColor.green
            if(badMonths.contains("dec"))
            {
                badMonths.remove(at: badMonths.index(of: "dec")!)
            }
            if(!goodMonths.contains("dec"))
            {
                goodMonths.append("dec")
            }
        default:
            sender.backgroundColor = UIColor.red
            if(goodMonths.contains("dec"))
            {
                goodMonths.remove(at: goodMonths.index(of: "dec")!)
            }
            if(!badMonths.contains("dec"))
            {
                badMonths.append("dec")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        theSpot.season = goodMonths
        // Configure the view for the selected state
    }

}
