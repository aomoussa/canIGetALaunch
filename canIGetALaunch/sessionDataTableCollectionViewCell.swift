//
//  sessionDataTableCollectionViewCell.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 7/2/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//
import MapKit
import UIKit

class sessionDataTableCollectionViewCell: UICollectionViewCell {
    var locations = [CLLocation]()
    
    var highestSpeed = 10 as CLLocationSpeed
    var highestAltitude = 10 as CLLocationDistance
    var initialTime = Date()
    var finalTime = Date()
    var lineDisplayed = false
    
    
    func makeTable()
    {
        initialTime = (locations.first?.timestamp)!
        finalTime = (locations.last?.timestamp)!
        for loc in locations{
            if(abs(loc.speed) > highestSpeed)
            {
                highestSpeed = abs(loc.speed)
            }
            if( abs(loc.altitude) > highestAltitude)
            {
                highestAltitude =  abs(loc.altitude)
            }
        }
        addAxisMarkers()
        let spdLine = makeLine(points: makeSpeedPoints())
        spdLine.strokeColor = UIColor.red.cgColor
        let altLine = makeLine(points: makeAltitudePoints())
        altLine.strokeColor = UIColor.blue.cgColor
        self.layer.addSublayer(spdLine)
        self.layer.addSublayer(altLine)
        lineDisplayed = true
    }
    func addAxisMarkers()
    {
        let halfLine = makeLine(points: makeGraphLinePoints(atY: 0.5))
        halfLine.strokeColor = UIColor.lightGray.cgColor
        let pointEightLine = makeLine(points: makeGraphLinePoints(atY: 0.8))
        pointEightLine.strokeColor = UIColor.lightGray.cgColor
        let pointTwoLine = makeLine(points: makeGraphLinePoints(atY: 0.2))
        pointTwoLine.strokeColor = UIColor.lightGray.cgColor
        self.layer.addSublayer(halfLine)
        self.layer.addSublayer(pointEightLine)
        self.layer.addSublayer(pointTwoLine)
        let halfLineLabel = UILabel(frame: CGRect(x: 0, y: self.frame.height*0.5-10, width: 40, height: 10))
        halfLineLabel.text = "\(highestSpeed*0.5)m/s"
        halfLineLabel.adjustsFontSizeToFitWidth = true
        let pointEightLineLabel = UILabel(frame: CGRect(x: 0, y: self.frame.height*0.2-10, width: 40, height: 10))
        pointEightLineLabel.text = "\(highestSpeed*0.8)m/s"
        pointEightLineLabel.adjustsFontSizeToFitWidth = true
        let pointTwoLineLabel = UILabel(frame: CGRect(x: 0, y: self.frame.height*0.8-10, width: 40, height: 10))
        pointTwoLineLabel.text = "\(highestSpeed*0.2)m/s"
        pointTwoLineLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(halfLineLabel)
        self.addSubview(pointTwoLineLabel)
        self.addSubview(pointEightLineLabel)
    }
    func makeGraphLinePoints(atY: CGFloat) -> [CGPoint]
    {
        var points = [CGPoint]()
        
        let y = (1 - atY) * self.frame.height
        points.append(CGPoint(x: 0, y: y))
        points.append(CGPoint(x: self.frame.width, y: y))
        return points
    }
    func makeAltitudePoints() -> [CGPoint]
    {
        let timeRange = finalTime.timeIntervalSince(initialTime)
        var points = [CGPoint]()
        for loc in locations
        {
            let x = CGFloat(loc.timestamp.timeIntervalSince(initialTime)/timeRange) * self.frame.width
            let y = CGFloat(1 - loc.altitude/(highestAltitude)) * self.frame.height
            points.append(CGPoint(x: x, y: y))
        }
        return points
    }
    func makeSpeedPoints() -> [CGPoint]
    {
        let timeRange = finalTime.timeIntervalSince(initialTime)
        var points = [CGPoint]()
        for loc in locations
        {
            let x = CGFloat(loc.timestamp.timeIntervalSince(initialTime)/timeRange) * self.frame.width
            let y = CGFloat(1 - loc.speed/(highestSpeed)) * self.frame.height
            points.append(CGPoint(x: x, y: y))
        }
        return points
    }
    func makeLine(points: [CGPoint]) -> CAShapeLayer{
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        
        for i in 0...(points.count-2)
        {
            linePath.move(to: points[i])
            linePath.addLine(to: points[i+1])
        }
        line.path = linePath.cgPath
        line.lineWidth = 1
        line.lineJoin = "round"//CAShapeLayerLineJoin.round
        return line
        
        
    }
    
}
