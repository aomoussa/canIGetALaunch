//
//  multipleSessionsTableViewCell.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 7/30/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit
import MapKit
import AWSDynamoDB

class multipleSessionsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var dbLocs = [LocationDataPoint]()
    var allPoints = [CLLocationCoordinate2D]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        getLocDPs()
        mapView.delegate = self
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
                
                //let polygon = MKPolygon.init(coordinates: allPoints, count: allPoints.count)
                self.mapView.setRegion(MKCoordinateRegion(center: allPoints[0], span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension multipleSessionsTableViewCell: MKMapViewDelegate
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
