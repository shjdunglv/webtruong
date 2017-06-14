//
//  ExtensionMapKit.swift
//  TestMap
//
//  Created by ReasonAmu on 12/7/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
    
    func zoomInPinAnnotationLocation(targetMapViewName : MKMapView?, delta: Double)
    {
        var region: MKCoordinateRegion = targetMapViewName!.region
        region.span.latitudeDelta /= delta
        region.span.longitudeDelta /= delta
        targetMapViewName!.region = region
        
    }
    func zoomOutPinAnnotationLocation(targetMapViewName : MKMapView?,delta: Double)
    {
        var region: MKCoordinateRegion = targetMapViewName!.region
        region.span.latitudeDelta *= delta
        region.span.longitudeDelta *= delta
        targetMapViewName!.region = region
    }
    
}
