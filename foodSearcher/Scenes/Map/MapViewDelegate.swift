//
//  MapViewDelegate.swift
//  foodSearcher
//
//  Created by andrey on 26/06/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit

extension MapViewController: GMSMapViewDelegate {
  
  func mapView(mapView: GMSMapView!, didTapMarker marker: GMSMarker!) -> Bool {
    
    if let index = self.markers.indexOf(marker) {
      self.selectedIndex = index
      if let pin = self.output.pins?[index] {
        self.showBottomInformationViewForPin(pin)
      }
    }
    
    return false
  }
  
  func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
    self.hideBottomInformationView()
  }
}
