//
//  sessionTrackerTableViewCell.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/18/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit
import MapKit

class sessionTrackerTableViewCell: UITableViewCell {

    let locationManager = CLLocationManager()
    @IBOutlet weak var trackerMap: MKMapView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        trackerMap.delegate = self
        trackerMap.showsUserLocation = true
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.activityType = CLActivityType.fitness
        
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var line = MKPolyline()
    func makeLine()
    {
        let locCnt = theSesh.locations.count
        if(locCnt>1)
        {
            var coordinateArray = [CLLocationCoordinate2D]()
            coordinateArray.append(theSesh.locations[locCnt - 2].coordinate)
            coordinateArray.append(theSesh.locations[locCnt - 1].coordinate)
            line = MKPolyline(coordinates: coordinateArray, count: 2)
            self.trackerMap.add(line)
        }
    }

}
extension sessionTrackerTableViewCell: MKMapViewDelegate, CLLocationManagerDelegate
{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: polyline)
            polylineRenderer.strokeColor = .blue
            polylineRenderer.lineWidth = 3
            return polylineRenderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("location: \(location)")
            theSesh.makeDPAndSave(loc: location)
            
            makeLine()
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
        if status == .authorizedAlways{
            locationManager.requestLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
        /*let alert = UIAlertController(title: "Error!", message: "problem: \(error)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "kk", style: UIAlertActionStyle.default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                //self.displaySpot(annot: view)
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))*/
        //present(alert, animated: true, completion: nil)
    }
}
