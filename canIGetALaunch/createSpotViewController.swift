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

    @IBOutlet weak var rigHereImage: UIImageView!
    @IBOutlet weak var launchHereImage: UIImageView!
    @IBOutlet weak var waterStartHereImage: UIImageView!
    @IBOutlet weak var parkHereImage: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    
    var parkDrag = UIPanGestureRecognizer()
    var rigDrag = UIPanGestureRecognizer()
    var launchDrag = UIPanGestureRecognizer()
    var waterStartDrag = UIPanGestureRecognizer()
    
    var parkCoordinates = CLLocationCoordinate2D()
    var rigCoordinates = CLLocationCoordinate2D()
    var launchCoordinates = CLLocationCoordinate2D()
    var waterStartCoordinates = CLLocationCoordinate2D()
    
    @IBAction func saveTapped(_ sender: UIButton) {
        saveLocations()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        parkDrag = UIPanGestureRecognizer(target: self, action: #selector(self.draggedParkView(_:)))
        parkHereImage.isUserInteractionEnabled = true
        parkHereImage.addGestureRecognizer(parkDrag)
        
        rigDrag = UIPanGestureRecognizer(target: self, action: #selector(self.draggedRigView(_:)))
        rigHereImage.isUserInteractionEnabled = true
        rigHereImage.addGestureRecognizer(rigDrag)
        
        launchDrag = UIPanGestureRecognizer(target: self, action: #selector(self.draggedLaunchView(_:)))
        launchHereImage.isUserInteractionEnabled = true
        launchHereImage.addGestureRecognizer(launchDrag)
        
        waterStartDrag = UIPanGestureRecognizer(target: self, action: #selector(self.draggedWaterStartView(_:)))
        waterStartHereImage.isUserInteractionEnabled = true
        waterStartHereImage.addGestureRecognizer(waterStartDrag)
        // Do any additional setup after loading the view.
    }
    func draggedParkView(_ sender:UIPanGestureRecognizer)
    {
        self.view.bringSubview(toFront: parkHereImage)
        let translation = sender.translation(in: self.view)
        parkHereImage.center = CGPoint(x: parkHereImage.center.x + translation.x, y: parkHereImage.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        let point = sender.location(in: self.mapView)
        parkCoordinates = mapView.convert(point, toCoordinateFrom: self.mapView)
        
    }
    func draggedRigView(_ sender:UIPanGestureRecognizer)
    {
        self.view.bringSubview(toFront: rigHereImage)
        let translation = sender.translation(in: self.view)
        rigHereImage.center = CGPoint(x: rigHereImage.center.x + translation.x, y: rigHereImage.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        let point = sender.location(in: self.mapView)
        rigCoordinates = mapView.convert(point, toCoordinateFrom: self.mapView)
    }
    func draggedLaunchView(_ sender:UIPanGestureRecognizer)
    {
        self.view.bringSubview(toFront: launchHereImage)
        let translation = sender.translation(in: self.view)
        launchHereImage.center = CGPoint(x: launchHereImage.center.x + translation.x, y: launchHereImage.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        let point = sender.location(in: self.mapView)
        launchCoordinates = mapView.convert(point, toCoordinateFrom: self.mapView)
    }
    func draggedWaterStartView(_ sender:UIPanGestureRecognizer)
    {
        self.view.bringSubview(toFront: waterStartHereImage)
        let translation = sender.translation(in: self.view)
        waterStartHereImage.center = CGPoint(x: waterStartHereImage.center.x + translation.x, y: waterStartHereImage.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        let point = sender.location(in: self.mapView)
        waterStartCoordinates = mapView.convert(point, toCoordinateFrom: self.mapView)
    }
    
    func saveLocations()
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
