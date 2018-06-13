//
//  FirstViewController.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 5/27/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit
import MapKit

class spotsViewController: UIViewController, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    var annots = [MKPointAnnotation()]
    
    func populateSpots()
    {
        allSpots.append(spot(title: "crissy", parkHere: CLLocationCoordinate2D(latitude: 37.8056381,longitude: -122.4519855), rigHere: CLLocationCoordinate2D(latitude: 12,longitude: 11), launchHere: CLLocationCoordinate2D(latitude: 23,longitude: 56), waterStartHere: CLLocationCoordinate2D(latitude: 33,longitude: 33)))
        allSpots.append(spot(title: "3rd", parkHere: CLLocationCoordinate2D(latitude: 37.5728303,longitude: -122.2794598), rigHere: CLLocationCoordinate2D(latitude: 12,longitude: 11), launchHere: CLLocationCoordinate2D(latitude: 23,longitude: 56), waterStartHere: CLLocationCoordinate2D(latitude: 33,longitude: 33)))
        allSpots.append(spot(title: "alameda", parkHere: CLLocationCoordinate2D(latitude: 37.7632836,longitude: -122.2720435), rigHere: CLLocationCoordinate2D(latitude: 12,longitude: 11), launchHere: CLLocationCoordinate2D(latitude: 23,longitude: 56), waterStartHere: CLLocationCoordinate2D(latitude: 33,longitude: 33)))
        
        for spot in allSpots {
            let annot = MKPointAnnotation()
            annot.coordinate = spot.parkHere
            annot.title = spot.title
            
            mapView.addAnnotation(annot)
            //annot.setValue(annots.count, forKeyPath: "index")  //(value: annots.count, forUndefinedKey: "index")
            annots.append(annot)
        }
        
        
    }
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        mapView.delegate = self
        
        populateSpots()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annot = view.annotation
        let i = annots.index(of: annot as! MKPointAnnotation)  //(where: {$0.equals(annot)})
        print(i)
        self.displaySpot(spot: allSpots[i!])
    }
    func displaySpot(spot: spot)
    {
        self.mapView.removeAnnotations(self.mapView.annotations)
        let parkHere = MKPointAnnotation()
        parkHere.coordinate = spot.parkHere
        parkHere.title = "park here"
        
        let rigHere = MKPointAnnotation()
        rigHere.coordinate = spot.rigHere
        rigHere.title = "rig here"
        
        let launchHere = MKPointAnnotation()
        launchHere.coordinate = spot.launchHere
        launchHere.title = "launch here"
        
        let waterStartHere = MKPointAnnotation()
        waterStartHere.coordinate = spot.waterStartHere
        waterStartHere.title = "water start"
        
        
        self.mapView.addAnnotation(parkHere)
        self.mapView.addAnnotation(rigHere)
        self.mapView.addAnnotation(launchHere)
        self.mapView.addAnnotation(waterStartHere)
        
        self.mapView.reloadInputViews()
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            switch((annotation.title!)!)
            {
            case "rig here":
                anView?.image = UIImage(named:"airpump.png")
                break
            case "launch here":
                anView?.image = UIImage(named:"launch.png")
                break
            case "water start":
                anView?.image = UIImage(named:"waterStart.png")
                break
            default:
                anView?.image = UIImage(named:"launch.png")
            }
            anView?.canShowCallout = true
        }
        else {
            switch((annotation.title!)!)
            {
            case "rig here":
                anView?.image = UIImage(named:"airpump.png")
                break
            case "launch here":
                anView?.image = UIImage(named:"launch.png")
                break
            case "water start":
                anView?.image = UIImage(named:"waterStart.png")
                break
            default:
                anView?.image = UIImage(named:"launch.png")
            }
            anView?.annotation = annotation
        }
        
        return anView
    }
    
}

extension spotsViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("location: \(location)")
            let annot = MKPointAnnotation()
            annot.coordinate = location.coordinate
            annot.title = "your location"
            
            self.mapView.addAnnotation(annot)
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
        let alert = UIAlertController(title: "Error!", message: "problem: \(error)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "kk", style: UIAlertActionStyle.default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                //self.displaySpot(annot: view)
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
}

