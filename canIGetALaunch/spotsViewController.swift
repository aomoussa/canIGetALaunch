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
    
    @IBOutlet weak var spotTitle: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBAction func backButtonTapped(_ sender: UIButton) {
        switchSpotState()
    }
    
    
    let locationManager = CLLocationManager()
    var annots = [MKPointAnnotation()]
    
    var selectedSpot = spot()
    var state = "allSpots"//"oneSpot"
    
    
    
    
    func switchSpotState()
    {
        for annot in mapView.annotations{
            self.mapView.deselectAnnotation(annot, animated: false)
        }
        self.mapView.removeAnnotations(self.mapView.annotations)
        switch(state)
        {
        case "allSpots":
            state = "oneSpot"
            spotTitle.text = "selected spot: \(selectedSpot.title)"
            backButton.alpha = 1
            self.displaySpot(spot: selectedSpot)
        default:
            state = "allSpots"
            spotTitle.text = "spots"
            backButton.alpha = 0
            addAnnotsToMap(annots: annots)
            //
        }
        //self.mapView.showAnnotations(self.mapView.annotations, animated: false)
        
        
    }
    func populateSpots()
    {
        allSpots.append(spot(title: "crissy", parkHere: CLLocationCoordinate2D(latitude: 37.8056381,longitude: -122.4519855), rigHere: CLLocationCoordinate2D(latitude: 37.8057057,longitude: -122.4518460), launchHere: CLLocationCoordinate2D(latitude: 37.8064037,longitude: -122.4530168), waterStartHere: CLLocationCoordinate2D(latitude: 37.8067393,longitude: -122.4530960)))
        allSpots.append(spot(title: "3rd", parkHere: CLLocationCoordinate2D(latitude: 37.5728303,longitude: -122.2794598), rigHere: CLLocationCoordinate2D(latitude: 37.8057057,longitude: -122.4518460), launchHere: CLLocationCoordinate2D(latitude: 37.8064037,longitude: -122.4530168), waterStartHere: CLLocationCoordinate2D(latitude: 37.8067393,longitude: -122.4530960)))
        allSpots.append(spot(title: "alameda", parkHere: CLLocationCoordinate2D(latitude: 37.7632836,longitude: -122.2720435), rigHere: CLLocationCoordinate2D(latitude: 37.8057057,longitude: -122.4518460), launchHere: CLLocationCoordinate2D(latitude: 37.8064037,longitude: -122.4530168), waterStartHere: CLLocationCoordinate2D(latitude: 37.8067393,longitude: -122.4530960)))
        for spot in allSpots {
            let annot = MKPointAnnotation()
            annot.coordinate = spot.parkHere
            annot.title = spot.title
            
            mapView.addAnnotation(annot)
            //annot.setValue(annots.count, forKeyPath: "index")  //(value: annots.count, forUndefinedKey: "index")
            annots.append(annot)
        }
        mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
    func addAnnotsToMap(annots: [MKPointAnnotation])
    {
        for annot in annots {
            mapView.addAnnotation(annot)
        }
        mapView.setRegion(MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)), animated: true)
        //mapView.setCenter(mapView.userLocation.coordinate, animated: true)
        
        //mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        mapView.delegate = self
        mapView.showsUserLocation = true
        populateSpots()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        mapView.showAnnotations(self.mapView.annotations, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        mapView.removeAnnotations(mapView.annotations)
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        switch(state)
        {
        case "oneSpot":
            break
        default:
            let annot = view.annotation
            let i = annots.index(of: annot as! MKPointAnnotation)  //(where: {$0.equals(annot)})
            print(i)
            selectedSpot = allSpots[i! - 1]
            switchSpotState()
        }
        
    }
    func displaySpot(spot: spot)
    {
        let parkHere = MKPointAnnotation()
        parkHere.title = "park here"
        
        parkHere.coordinate.latitude = spot.parkHere.latitude
        parkHere.coordinate.longitude = spot.parkHere.longitude
        
        let rigHere = MKPointAnnotation()
        rigHere.title = "rig here"
        
        rigHere.coordinate.latitude = spot.rigHere.latitude
        rigHere.coordinate.longitude = spot.rigHere.longitude
        
        let launchHere = MKPointAnnotation()
        launchHere.title = "launch here"
        
        launchHere.coordinate.latitude = spot.launchHere.latitude
        launchHere.coordinate.longitude = spot.launchHere.longitude
        
        let waterStartHere = MKPointAnnotation()
        waterStartHere.title = "water start"
        
        waterStartHere.coordinate.latitude = spot.waterStartHere.latitude
        waterStartHere.coordinate.longitude = spot.waterStartHere.longitude
        
        
        self.mapView.addAnnotation(parkHere)
        self.mapView.addAnnotation(rigHere)
        self.mapView.addAnnotation(launchHere)
        self.mapView.addAnnotation(waterStartHere)
        
        let annotationsToShow = mapView.annotations.filter { $0 !== mapView.userLocation }
        self.mapView.showAnnotations(annotationsToShow, animated: true)
        //self.mapView.reloadInputViews()
        
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
            case "park here":
                anView?.image = UIImage(named:"park.png")
                break
            case "rig here":
                anView?.image = UIImage(named:"airpump.png")
                break
            case "launch here":
                anView?.image = UIImage(named:"launch.png")
                break
            case "water start":
                anView?.image = UIImage(named:"waterStart.png")
                break
            case "your location":
                anView?.image = UIImage(named:"first.jpg")
                break
            default:
                anView?.image = UIImage(named:"launch.png")
            }
            for sesh in allSessions{
                
                if(sesh.seshSpot.title == (annotation.title!)!)
                {
                    anView?.image = UIImage(named: "second.jpg")
                }
                
            }
            anView?.canShowCallout = true
        }
        else {
            if let title = annotation.title!
            {
                
                switch(title)
                {
                case "park here":
                    anView?.image = UIImage(named:"park.png")
                    break
                case "rig here":
                    anView?.image = UIImage(named:"airpump.png")
                    break
                case "launch here":
                    anView?.image = UIImage(named:"launch.png")
                    break
                case "water start":
                    anView?.image = UIImage(named:"waterStart.png")
                    break
                case "your location":
                    anView?.image = UIImage(named:"first.jpg")
                    break
                default:
                    anView?.image = UIImage(named:"launch.png")
                }
                anView?.annotation = annotation
            }
            else{
                print("problem")
            }
            for sesh in allSessions{
                
                if(sesh.seshSpot.title == title)
                {
                    anView?.image = UIImage(named: "second.jpg")
                }
                
            }
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

