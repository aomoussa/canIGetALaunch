//
//  spotLocationPickerTableViewself.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/14/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit
import MapKit

class spotLocationPickerTableViewCell: UITableViewCell {

    @IBOutlet weak var parkHereImage: UIImageView!
    @IBOutlet weak var rigHereImage: UIImageView!
    @IBOutlet weak var launchHereImage: UIImageView!
    @IBOutlet weak var waterStartHereImage: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    
    var parkCoordinates = CLLocationCoordinate2D()
    var rigCoordinates = CLLocationCoordinate2D()
    var launchCoordinates = CLLocationCoordinate2D()
    var waterStartCoordinates = CLLocationCoordinate2D()
    
    @objc func draggedParkView(_ sender:UIPanGestureRecognizer)
    {
        self.bringSubview(toFront: parkHereImage)
        let translation = sender.translation(in: self)
        parkHereImage.center = CGPoint(x: parkHereImage.center.x + translation.x, y: parkHereImage.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self)
        
        let point = sender.location(in: self.mapView)
        parkCoordinates = mapView.convert(point, toCoordinateFrom: self.mapView)
        theSpot.parkHere = parkCoordinates
    }
    @objc func draggedRigView(_ sender:UIPanGestureRecognizer)
    {
        self.bringSubview(toFront: rigHereImage)
        let translation = sender.translation(in: self)
        rigHereImage.center = CGPoint(x: rigHereImage.center.x + translation.x, y: rigHereImage.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self)
        
        let point = sender.location(in: self.mapView)
        rigCoordinates = mapView.convert(point, toCoordinateFrom: self.mapView)
        theSpot.rigHere = rigCoordinates
    }
    @objc func draggedLaunchView(_ sender:UIPanGestureRecognizer)
    {
        self.bringSubview(toFront: launchHereImage)
        let translation = sender.translation(in: self)
        launchHereImage.center = CGPoint(x: launchHereImage.center.x + translation.x, y: launchHereImage.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self)
        
        let point = sender.location(in: self.mapView)
        launchCoordinates = mapView.convert(point, toCoordinateFrom: self.mapView)
        theSpot.launchHere = launchCoordinates
    }
    @objc func draggedWaterStartView(_ sender:UIPanGestureRecognizer)
    {
        self.bringSubview(toFront: waterStartHereImage)
        let translation = sender.translation(in: self)
        waterStartHereImage.center = CGPoint(x: waterStartHereImage.center.x + translation.x, y: waterStartHereImage.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self)
        
        let point = sender.location(in: self.mapView)
        waterStartCoordinates = mapView.convert(point, toCoordinateFrom: self.mapView)
        theSpot.waterStartHere = waterStartCoordinates
    }
    
    var parkDrag = UIPanGestureRecognizer()
    var rigDrag = UIPanGestureRecognizer()
    var launchDrag = UIPanGestureRecognizer()
    var waterStartDrag = UIPanGestureRecognizer()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mapView.mapType = .hybrid
        parkDrag = UIPanGestureRecognizer(target: self, action: #selector(self.draggedParkView(_:)))
        self.parkHereImage.isUserInteractionEnabled = true
        self.parkHereImage.addGestureRecognizer(parkDrag)
        
        rigDrag = UIPanGestureRecognizer(target: self, action: #selector(self.draggedRigView(_:)))
        self.rigHereImage.isUserInteractionEnabled = true
        self.rigHereImage.addGestureRecognizer(rigDrag)
        
        launchDrag = UIPanGestureRecognizer(target: self, action: #selector(self.draggedLaunchView(_:)))
        self.launchHereImage.isUserInteractionEnabled = true
        self.launchHereImage.addGestureRecognizer(launchDrag)
        
        waterStartDrag = UIPanGestureRecognizer(target: self, action: #selector(self.draggedWaterStartView(_:)))
        self.waterStartHereImage.isUserInteractionEnabled = true
        self.waterStartHereImage.addGestureRecognizer(waterStartDrag)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    /*func saveLocations()
     {
     let parkAnnot = MKPointAnnotation()
     parkAnnot.coordinate = parkCoordinates
     parkAnnot.title = "park here"
     mapView.addAnnotation(parkAnnot)
     
     let rigAnnot = MKPointAnnotation()
     rigAnnot.coordinate = rigCoordinates
     rigAnnot.title = "rig here"
     mapView.addAnnotation(rigAnnot)
     
     let launchAnnot = MKPointAnnotation()
     launchAnnot.coordinate = launchCoordinates
     launchAnnot.title = "launch here"
     mapView.addAnnotation(launchAnnot)
     
     let waterStartAnnot = MKPointAnnotation()
     waterStartAnnot.coordinate = waterStartCoordinates
     waterStartAnnot.title = "water start here"
     mapView.addAnnotation(waterStartAnnot)
     
     parkHereImage.alpha = 0
     rigHereImage.alpha = 0
     launchHereImage.alpha = 0
     waterStartHereImage.alpha = 0
     }*/
}
