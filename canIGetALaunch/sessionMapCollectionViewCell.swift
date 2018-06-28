//
//  sessionMapCollectionViewCell.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/28/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit
import MapKit

class sessionMapCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sessionMap: MKMapView!
    var locations = [CLLocation]()
    var allPoints = [CLLocationCoordinate2D]()
    var line = MKPolyline()
    var lineDisplayed = false
    override func awakeFromNib() {
        self.sessionMap.delegate = self
        //makeLine()
    }
    
    func makeLine()
    {
        if(locations.count > 0)
        {
            var coordinateArray = [CLLocationCoordinate2D]()
            for loc in locations
            {
                coordinateArray.append(loc.coordinate)
                allPoints.append(loc.coordinate)
            }
            line = MKPolyline(coordinates: coordinateArray, count: coordinateArray.count)
            self.sessionMap.add(line)
            
            
            if(allPoints.count > 0){
                
                let polygon = MKPolygon.init(coordinates: allPoints, count: allPoints.count)
                self.sessionMap.setRegion(MKCoordinateRegionForMapRect(polygon.boundingMapRect), animated: true)
            }
            lineDisplayed = true
        }
    }
    
}
extension sessionMapCollectionViewCell: MKMapViewDelegate
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
