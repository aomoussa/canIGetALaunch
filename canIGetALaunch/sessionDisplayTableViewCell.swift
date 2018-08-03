//
//  sessionDisplayTableViewCell.swift
//  canIGetALaunch
//
//  Created by Ahmed Moussa on 6/20/18.
//  Copyright © 2018 Ahmed Moussa. All rights reserved.
//

import UIKit
import MapKit

class sessionDisplayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var kiterName: UILabel!
    @IBOutlet weak var spotTitle: UILabel!
    @IBOutlet weak var sessionMap: MKMapView!
    @IBOutlet weak var gear: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var locations = [CLLocation]()
    var seshNum = 0
    var allPoints = [CLLocationCoordinate2D]()
    var line = MKPolyline()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sessionMap.delegate = self
        //makeLine()
    }
    /*
    func makeLineWithPoints()
    {
        
         for loc in locations
         {
         let annot = MKPointAnnotation()
         annot.coordinate = loc.coordinate
         annot.title = "\(loc.speed)"
         
         
         sessionMap.addAnnotation(annot)
         }
         sessionMap.showAnnotations(sessionMap.annotations, animated: true)
    }*/
    func makeLine()
    {
        let seshNum = MKPointAnnotation()
        seshNum.title = "\(self.seshNum)"
        
        seshNum.coordinate = locations[0].coordinate
        self.sessionMap.addAnnotation(seshNum)
        
        var coordinateArray = [CLLocationCoordinate2D]()
        for loc in locations
        {
            coordinateArray.append(loc.coordinate)
            allPoints.append(loc.coordinate)
        }
        line = MKPolyline(coordinates: coordinateArray, count: coordinateArray.count)
        self.sessionMap.add(line)
        /*
        if(self.locations.count > 1)
        {
            for i in 0...(self.locations.count-1)
            {
                if let co1 = self.locations[i] as? CLLocation
                {
                    if let co2 = self.locations[i+1] as? CLLocation
                    {
                        allPoints.append(co1.coordinate)
                        let coordinateArray = [co1.coordinate, co2.coordinate]
                        //coordinateArray.append(locations[i].coordinate)
                        //coordinateArray.append(locations[i+1].coordinate)
                        lines.append(MKPolyline(coordinates: coordinateArray, count: 2))
                        self.sessionMap.add(lines[i])
                    }
                }
                
            }
        }*/
        
        if(allPoints.count > 0){
            
            //let polygon = MKPolygon.init(coordinates: allPoints, count: allPoints.count)  //points: line.points(), count: line.pointCount)
            self.sessionMap.setRegion(MKCoordinateRegion(center: allPoints[0], span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension sessionDisplayTableViewCell: MKMapViewDelegate
{
    /*
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
            if((annotation.title!) != nil){
                //anView?.image = UIImage(named: "first.jpg")
                anView?.frame = CGRect(origin: (anView?.frame.origin)!, size: CGSize(width: self.frame.width/40, height: self.frame.width/40))
                anView?.backgroundColor = UIColor(colorLiteralRed: 250-10*Float((annotation.title!)!)!, green: 5*Float((annotation.title!)!)!, blue: 100, alpha: 1)
            }
            anView?.canShowCallout = true
        }
        else {
            if let title = annotation.title!
            {
                //anView?.image = UIImage(named: "first.jpg")
                anView?.frame = CGRect(origin: (anView?.frame.origin)!, size: CGSize(width: self.frame.width/40, height: self.frame.width/40)) //self.view.frame.width/20
             anView?.backgroundColor = UIColor(colorLiteralRed: 250-10*Float(title)!, green: 5*Float(title)!, blue: 100, alpha: 1)
            }
            else{
                print("problem")
            }
        }
        return anView
    }*/

    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: polyline)
            
            /*
            var i = 0
            for p in allPoints
            {
                if(polyline.coordinate.latitude == p.latitude)
                {
                    if let color = locations[i].speed as? Double
                    {
                        polylineRenderer.strokeColor = UIColor(colorLiteralRed: Float(color), green: 0, blue: 0, alpha: 1)
                    }
                    //UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
                    
                }
                i+=1
            }*/
            polylineRenderer.strokeColor = .blue
            polylineRenderer.lineWidth = 2
            return polylineRenderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}
