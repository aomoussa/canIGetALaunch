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
    var kiterBitmojiImage = UIImage(named: "launch.jpg")
    
    
    
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
            spotTitle.text = "\(selectedSpot.title)"
            backButton.alpha = 1
            self.displaySpot(spot: selectedSpot)
        default:
            spotTitle.text = "spots"
            backButton.alpha = 0
            if(allSpots.count == 0)
            {
                populateSpots()
            }
            else if(annots.count < 2)
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
            else{
                for annot in annots
                {
                    self.mapView.addAnnotation(annot)
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
                    self.getKiterWithIdForSpot(id: spotItem!._kiterId ?? thisKiter.id, theSpot: normalSpot)
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
    func getKiterWithIdForSpot(id: String, theSpot: spot)
    {
        let completionHandler = {(output: AWSDynamoDBPaginatedOutput?, error: Error?) in
            if error != nil {
                print("The request failed. Error: \(String(describing: error))")
            }
            if output != nil {
                for dkiter in output!.items {
                    let kiterItem = dkiter as? Kiter
                    print("\(kiterItem!._kiterName!)")
                    let normalKiter = kiter(fromDBKiter: kiterItem!)
                    theSpot.spotKiter = normalKiter
                }
                
                
                //keep going
            }
        }
        DBDownload.queryKiterWithID(id: id, completionHandler: completionHandler)
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
        showAlert(withMsg: "Check out these kiting spots, tap a pin to see parking/rigging/launching/waterstarting locations for that spot. Tap \"Add Spot\" to create your own spot!")
    }
    func showAlert(withMsg: String)
    {
        let alert = UIAlertController(title: "Notice", message: withMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        switch(state)
        {
        case "oneSpot":
            break
        default:
            if let annot  = view.annotation
                
            {
                if let foundSpot = allSpots.enumerated().first(where: {$0.element.parkHere.latitude == annot.coordinate.latitude})
                {
                    selectedSpot = foundSpot.element
                    switchSpotState(to: "oneSpot")
                }
                else{
                    print("couldn't find spot")
                }
                /*
                 let i = annots.index(of: annot as! MKPointAnnotation)  //(where: {$0.equals(annot)})
                 print(i ?? 0)
                 selectedSpot = allSpots[i! - 1]
                 switchSpotState(to: "oneSpot")*/
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
        
        for wd in spot.windDirections
        {
            let windAnnot = MKPointAnnotation()
            windAnnot.title = "good wind direction"
            switch(wd)
            {
            case "n": 
                windAnnot.coordinate.latitude = spot.launchHere.latitude + 0.014
                windAnnot.coordinate.longitude = spot.launchHere.longitude
                break
            case "ne": 
                windAnnot.coordinate.latitude = spot.launchHere.latitude + 0.01
                windAnnot.coordinate.longitude = spot.launchHere.longitude + 0.01
                break
            case "e": 
                windAnnot.coordinate.latitude = spot.launchHere.latitude
                windAnnot.coordinate.longitude = spot.launchHere.longitude + 0.014
                break
            case "se": 
                windAnnot.coordinate.latitude = spot.launchHere.latitude - 0.01
                windAnnot.coordinate.longitude = spot.launchHere.longitude + 0.01
                break
            case "s": 
                windAnnot.coordinate.latitude = spot.launchHere.latitude - 0.014
                windAnnot.coordinate.longitude = spot.launchHere.longitude
                break
            case "sw": 
                windAnnot.coordinate.latitude = spot.launchHere.latitude - 0.01
                windAnnot.coordinate.longitude = spot.launchHere.longitude - 0.01
                break
            case "w": 
                windAnnot.coordinate.latitude = spot.launchHere.latitude
                windAnnot.coordinate.longitude = spot.launchHere.longitude  - 0.014
                break
            case "nw": 
                windAnnot.coordinate.latitude = spot.launchHere.latitude + 0.01
                windAnnot.coordinate.longitude = spot.launchHere.longitude - 0.01
                break
            default:
                break
            }
            self.mapView.addAnnotation(windAnnot)
        }
        let annotationsToShow = mapView.annotations.filter { $0 !== mapView.userLocation }
        self.mapView.showAnnotations(annotationsToShow, animated: true)
        //self.mapView.reloadInputViews()
        
    }
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    func makeImageViewAndCircle(image: UIImage) -> UIImageView
    {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        imageView.image = image
        circleImageView(image: imageView)
        return imageView
    }
    func circleImageView(image: UIImageView)
    {
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.width/1.9
        image.clipsToBounds = true
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            var image = UIImage(named: "launch.png")
            if((annotation.title!) != nil){
                switch((annotation.title!)!)
                {
                case "park here":
                    image = UIImage(named:"park.png")
                    break
                case "rig here":
                    image = UIImage(named:"airpump.png")
                    break
                case "launch here":
                    image = UIImage(named:"launch.png")
                    break
                case "water start":
                    image = UIImage(named:"waterStart.png")
                    break
                case "good wind direction":
                    image = UIImage(named: "wind.png")
                    break
                case "your location":
                    image = resizeImage(image: thisKiter.image, newWidth: 50)
                    break
                default:
                    image = resizeImage(image: UIImage(named: "AppIcon.png")!, newWidth: 80)
                }
                
                
                for sesh in allSessions{
                    
                    if(sesh.seshSpot.title == (annotation.title!)!)
                    {
                        image = thisKiter.imageFromBitmoji()//UIImage(named: "second.jpg")
                    }
                }
                
                let imageView = makeImageViewAndCircle(image: image!)
                anView?.addSubview(imageView)
                anView?.frame = imageView.frame
            }
            anView?.canShowCallout = true
        }
            
        else {
            var image = UIImage(named: "launch.png")
            if let title = annotation.title!
            {
                
                switch(title)
                {
                case "park here":
                    image = UIImage(named:"park.png")
                    break
                case "rig here":
                    image = UIImage(named:"airpump.png")
                    break
                case "launch here":
                    image = UIImage(named:"launch.png")
                    break
                case "water start":
                    image = UIImage(named:"waterStart.png")
                    break
                case "good wind direction":
                    image = UIImage(named: "wind.png")
                    break
                case "your location":
                    image = resizeImage(image: thisKiter.image, newWidth: 50)
                    break
                default:
                    image = resizeImage(image: UIImage(named: "AppIcon.png")!, newWidth: 80)
                }
                anView?.annotation = annotation
            }
            else{
                print("problem")
            }
            for sesh in allSessions{
                
                if(sesh.seshSpot.title == title)
                {
                    image = resizeImage(image: thisKiter.image, newWidth: 50)
                }
                
            }
            for view in (anView?.subviews)!
            {
                view.removeFromSuperview()
            }
            
            let imageView = makeImageViewAndCircle(image: image!)
            anView?.addSubview(imageView)
            anView?.frame = imageView.frame
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

