//
//  mapTestViewController.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 7/16/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit
import AWSDynamoDB
import MapKit

class mapTestViewController: UIViewController {

    var dbLocs = [LocationDataPoint]()
    @IBOutlet weak var mapView: MKMapView!
    var allPoints = [CLLocationCoordinate2D]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocDPs()
        mapView.delegate = self
        // Do any additional setup after loading the view.
    }

    func getLocDPs()
    {
        let completionHandler = {(output: AWSDynamoDBPaginatedOutput?, error: Error?) in
            if error != nil {
                print("The request failed. Error: \(String(describing: error))")
            }
            if output != nil {
                var i = 0
                for dLoc in output!.items {
                    let locItem = dLoc as? LocationDataPoint
                    print(i)
                    self.dbLocs.append(locItem!)
                    i = i+1
                }
                
                self.makeLine()
                //keep going
            }
        }
        DBDownload.queryLocDPs(completionHandler: completionHandler)
    }
    func makeLine()
    {
        if(dbLocs.count > 0)
        {
            var coordinateArray = [CLLocationCoordinate2D]()
            for loc in dbLocs
            {
                let p = CLLocationCoordinate2D(latitude: Double(loc._lat!), longitude: Double(loc._lon!))
                coordinateArray.append(p)
                allPoints.append(p)
            }
            let line = MKPolyline(coordinates: coordinateArray, count: coordinateArray.count)
            self.mapView.add(line)
            
            
            if(allPoints.count > 0){
                
                let polygon = MKPolygon.init(coordinates: allPoints, count: allPoints.count)
                self.mapView.setRegion(MKCoordinateRegionForMapRect(polygon.boundingMapRect), animated: true)
            }
        }
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
extension mapTestViewController: MKMapViewDelegate
{
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: polyline)
            
            polylineRenderer.strokeColor = .blue
            polylineRenderer.lineWidth = 2
            return polylineRenderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}

