//
//  FirstViewController.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 5/27/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit
import MapKit
import AWSDynamoDB

class spotsViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var spotTitle: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBAction func backButtonTapped(_ sender: UIButton) {
        switchSpotState(to: "allSpots")
    }
    
    
    let locationManager = CLLocationManager()
    var annots = [MKPointAnnotation()]
    
    var selectedSpot = spot()
    var state = "allSpots"//"oneSpot"
    
    
    
    
    func switchSpotState(to: String)
    {
        for annot in mapView.annotations{
            self.mapView.deselectAnnotation(annot, animated: false)
        }
        self.mapView.removeAnnotations(self.mapView.annotations)
        state = to
        switch(state)
        {
        case "oneSpot":
            spotTitle.text = "selected spot: \(selectedSpot.title)"
            backButton.alpha = 1
            self.displaySpot(spot: selectedSpot)
        default:
            spotTitle.text = "spots"
            backButton.alpha = 0
            if(allSpots.count == 0)
            {
                populateSpots()
            }
            else if(annots.count == 0)
            {
                for spot in allSpots
                {
                    let annot = MKPointAnnotation()
                    annot.coordinate = spot.parkHere
                    annot.title = spot.title
                    
                    
                    self.mapView.addAnnotation(annot)
                    self.annots.append(annot)
                }
                
            }
            mapView.showAnnotations(self.mapView.annotations, animated: true)
            //
        }
        //self.mapView.showAnnotations(self.mapView.annotations, animated: false)
        
        
    }
    func populateSpots()
    {
        /*
         allSpots.append(spot(title: "crissy", parkHere: CLLocationCoordinate2D(latitude: 37.8056381,longitude: -122.4519855), rigHere: CLLocationCoordinate2D(latitude: 37.8057057,longitude: -122.4518460), launchHere: CLLocationCoordinate2D(latitude: 37.8064037,longitude: -122.4530168), waterStartHere: CLLocationCoordinate2D(latitude: 37.8067393,longitude: -122.4530960)))
         allSpots.append(spot(title: "3rd", parkHere: CLLocationCoordinate2D(latitude: 37.5728303,longitude: -122.2794598), rigHere: CLLocationCoordinate2D(latitude: 37.8057057,longitude: -122.4518460), launchHere: CLLocationCoordinate2D(latitude: 37.8064037,longitude: -122.4530168), waterStartHere: CLLocationCoordinate2D(latitude: 37.8067393,longitude: -122.4530960)))
         allSpots.append(spot(title: "alameda", parkHere: CLLocationCoordinate2D(latitude: 37.7632836,longitude: -122.2720435), rigHere: CLLocationCoordinate2D(latitude: 37.8057057,longitude: -122.4518460), launchHere: CLLocationCoordinate2D(latitude: 37.8064037,longitude: -122.4530168), waterStartHere: CLLocationCoordinate2D(latitude: 37.8067393,longitude: -122.4530960)))
         */
        self.annots.removeAll()
        let completionHandler = {(output: AWSDynamoDBPaginatedOutput?, error: Error?) in
            if error != nil {
                print("The request failed. Error: \(String(describing: error))")
            }
            if output != nil {
                for dspot in output!.items {
                    let spotItem = dspot as? Spot
                    print("\(spotItem!._title!)")
                    let normalSpot = spot(fromSpot: spotItem!)
                    allSpots.append(normalSpot)
                    let annot = MKPointAnnotation()
                    annot.coordinate = normalSpot.parkHere
                    annot.title = normalSpot.title
                    self.mapView.addAnnotation(annot)
                    //annot.setValue(annots.count, forKeyPath: "index")  //(value: annots.count, forUndefinedKey: "index")
                    self.annots.append(annot)
                    
                }
                
                
                self.mapView.showAnnotations(self.mapView.annotations, animated: true)
            }
        }
        DBDownload.querySpots(completionHandler: completionHandler)
    }
    /*
    func populateSessions()
    {
        let completionHandler = {(output: AWSDynamoDBPaginatedOutput?, error: Error?) in
            if error != nil {
                print("The request failed. Error: \(String(describing: error))")
            }
            if output != nil {
                for dsesh in output!.items {
                    let sessionItem = dsesh as? Session
                    print("\(sessionItem!._spotTitle!)")
                    let normalSesh = session(fromSession: sessionItem!)
                    allSpots.append(normalSpot)
                    let annot = MKPointAnnotation()
                    annot.coordinate = normalSpot.parkHere
                    annot.title = normalSpot.title
                    self.mapView.addAnnotation(annot)
                    //annot.setValue(annots.count, forKeyPath: "index")  //(value: annots.count, forUndefinedKey: "index")
                    self.annots.append(annot)
                    
                }
                
                
                self.mapView.showAnnotations(self.mapView.annotations, animated: true)
            }
        }
        DBDownload.querySessions(completionHandler: completionHandler)

    }*/
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        mapView.delegate = self
        mapView.showsUserLocation = true
        if(allSpots.count == 0)
        {
            populateSpots()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        switchSpotState(to: "allSpots")
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
            if let annot  = view.annotation 

            {
            let i = annots.index(of: annot as! MKPointAnnotation)  //(where: {$0.equals(annot)})
            print(i ?? 0)
            selectedSpot = allSpots[i! - 1]
                switchSpotState(to: "oneSpot")
            }
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
            
            if((annotation.title!) != nil){
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
                    anView?.image = thisKiter.imageFromBitmoji()
                    break
                default:
                    anView?.image = thisKiter.imageFromBitmoji()
                }
                
                
                for sesh in allSessions{
                    
                    if(sesh.seshSpot.title == (annotation.title!)!)
                    {
                        anView?.image = thisKiter.imageFromBitmoji()//UIImage(named: "second.jpg")
                    }
                    
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
                    anView?.image = thisKiter.imageFromBitmoji()
                    break
                default:
                    anView?.image = thisKiter.imageFromBitmoji()
                }
                anView?.annotation = annotation
            }
            else{
                print("problem")
            }
            for sesh in allSessions{
                
                if(sesh.seshSpot.title == title)
                {
                    anView?.image = thisKiter.imageFromBitmoji()
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

