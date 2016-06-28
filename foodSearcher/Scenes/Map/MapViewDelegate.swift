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
    router.navigateToDescription()
    return false
  }
}
