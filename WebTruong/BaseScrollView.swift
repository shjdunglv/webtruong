//
//  BaseScrollView.swift
//  RaoViet
//
//  Created by ReasonAmu on 12/18/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class BaseScrollView: BaseViewController,MKMapViewDelegate {
    
    
    //-- Khai báo biến
    var fromLocation: CLLocation?
    var locationManager : CLLocationManager = CLLocationManager()
    var post_GPS: String = ""
    
    
    
    
     @IBOutlet weak var mapview: MKMapView!
    let cellImage = "CellDetailImage"
    var annotation:CustomAnnotation?
     var numberImage : [String] = []
    var overlay : MKOverlay?
    var locationGPS: CLLocationCoordinate2D!
    

    
    //-- Get Location User
    func getLocationUser() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    
    
    
    //-- func get USer

    
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
    }
    
    //MARK: HANDLE
    
    //-- Check tọa độ của máy
    func getCurrentLocation(){
        
        self.locationManager.startUpdatingLocation()
    }
    
    
    func handleLocation(){
        
        getCurrentLocation()
        print("Location ")
    }
    
    func handleZoomIn(){
        print("Zoom In ")
        mapview.zoomInPinAnnotationLocation(targetMapViewName: mapview, delta: 2.0)
        
    }
    
    
    func handleZoomOut(){
        mapview.zoomOutPinAnnotationLocation(targetMapViewName: mapview, delta: 2.0)
        print("Zoom Out")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error" + error.localizedDescription)
    }
    
    
    // update
    func updateRegion(scale: Float) {
        let size: CGSize = self.mapview.bounds.size
        let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(fromLocation!.coordinate, Double(Float(size.height) * scale), Double(Float(size.width) * scale))
        self.mapview.setRegion(region, animated: true)
    }
    
    
    // add Annotion
    func addAnnotaion(coordinate: CLLocationCoordinate2D, title: String, subtitle: String?,  imageName: String?){
        
        annotation = CustomAnnotation(title: title, subtitle: subtitle, coordinate: coordinate ,image : UIImage(named: imageName!))
        
        self.mapview.addAnnotation(annotation!)
        
    }
    
    
    // draw Line 2 Location
    
    func drawLineTwoLocation(sourceLocation : CLLocationCoordinate2D , destinationLocation : CLLocationCoordinate2D){
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let directRequest = MKDirectionsRequest()
        directRequest.source = sourceMapItem
        directRequest.destination = destinationMapItem
        
        //-- chon huong dan chi duong bang phuong tien
        directRequest.transportType = .automobile //-- default mobile
        
        let directions = MKDirections(request: directRequest)
        directions.calculate { (response, error) in
            if error == nil {
                if let route = response?.routes.first{
                    self.mapview.add(route.polyline, level: .aboveRoads)
                    
                    for step in route.steps {
                        print(step)
                    }
                    
                    let rect = route.polyline.boundingMapRect
                    self.mapview.setVisibleMapRect(rect, edgePadding: UIEdgeInsetsMake(40, 40, 20, 20), animated: true)
                }
                
            }else {
                
                print(error?.localizedDescription as Any)
            }
        }
        
    }
    
    
    //-- show len response -- tra ve chi tiet cac duong di de ve
    func showRoute(response : MKDirectionsResponse){
        //-- tra ve 1 mang
        for route in response.routes{
            self.overlay = route.polyline
            self.mapview.add(overlay!, level: .aboveRoads)
            for step in route.steps{
                
                print(step.instructions)
            }
        }
        
        
    }
    
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            print("click Right")
            
            if let currentLocation = locationManager.location?.coordinate {
                
                self.drawLineTwoLocation(sourceLocation: currentLocation, destinationLocation: locationGPS)
                
                
            }
            mapView.deselectAnnotation(view.annotation, animated: true)
        }
    }
    
    
    
    
    // func hien thi mau line ve
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 2.0
        
        return renderer
        
    }
    
    
    
    // Annotion MapView
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier: String = "Pin"
        
        if let myAnnotion = annotation as? CustomAnnotation {
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if pinView == nil {
                pinView = MKAnnotationView(annotation: myAnnotion, reuseIdentifier: identifier)
                pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                pinView?.canShowCallout = true
                pinView?.calloutOffset  = CGPoint(x: 0, y: 4) //-- vi tri hien thi
                pinView?.contentMode  = .scaleAspectFit
            }else{
                pinView?.annotation = annotation
            }
            
            
            //-- add image
            
            pinView?.image = myAnnotion.image
            
            return pinView
        }
        
        
        return nil
    }
    
    
    
    
}

extension BaseScrollView  : CLLocationManagerDelegate {
    
    //-- Update location now
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        self.fromLocation = location
        self.locationManager.stopUpdatingHeading()
        if let gps = location?.coordinate {
            post_GPS = "\(gps.latitude) \(gps.longitude)"
        }else{
            post_GPS = ""
        }
        
        
        
    }
    
    
    
    
}



//
//extension DetailEnterpriseVC: MKMapViewDelegate {
//    
//   
//    
//}


