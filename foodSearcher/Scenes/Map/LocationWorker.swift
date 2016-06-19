//
//  LocationWorker.swift
//  foodSearcher
//
//  Created by andrey on 19/06/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit
import CoreLocation

class LocationWorker: NSObject, CLLocationManagerDelegate {
  
  var locationManager = CLLocationManager()
  var output: MapInteractorOutput
  
  
  init(output: MapInteractorOutput) {
    self.output = output
    super.init()
  }
  
  func requestAuthorization() {
    locationManager.requestWhenInUseAuthorization()
  }
  
  func startUpdatingLocation() {
    locationManager.delegate = self
  }
  
  func stopUpdatingLocation() {
    locationManager.stopUpdatingLocation()
    locationManager.delegate = nil
  }
  
// MARK: - CLLocationManagerDelegate
  func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    if status == .AuthorizedWhenInUse {
      locationManager.startUpdatingLocation()
      output.didSuccessAuthorization()
    }
  }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      output.didUpdateLocation(Map.Response.UserLocation(latitude: location.coordinate.latitude,
                                                         longitude: location.coordinate.longitude))
    }
  }
}
