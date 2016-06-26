//
//  PinsMemStore.swift
//  foodSearcher
//
//  Created by andrey on 20/06/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit
import MapKit

class PinsMemStore: PinsStoreProtocol {
  
  let pins = []
  var locationObj: LocationProtocol
  
  init(locationObj: LocationProtocol) {
    self.locationObj = locationObj
  }
  
  func fetchPins(completionHandler: PinsStoreCompletionHandler) {
    let currentLocation = locationObj.getCurrentLocation()
    print(currentLocation)
    
    let location1 = plusLocationFrom(500, currentLocation: currentLocation!)
    let location2 = minusLocationFrom(400, currentLocation: currentLocation!)
    
    let pin1 = Pin(latitude: location1.latitude, longitude: location1.longitude)
    let pin2 = Pin(latitude: location2.latitude, longitude: location2.longitude)
    
    completionHandler(result: PinsStoreResult.Success(result: [pin1, pin2]))
  }
  
  private
  
  func plusLocationFrom(meters: Int, currentLocation: Map.Response.UserLocation) -> Map.Response.UserLocation {
    let latitude: CLLocationDegrees = currentLocation.latitude
    let newLatitude = latitude + CLLocationDistance(meters).fromMetersToLatitude()
    
    return Map.Response.UserLocation(latitude: newLatitude, longitude: currentLocation.longitude)
  }
  
  func minusLocationFrom(meters: Int, currentLocation: Map.Response.UserLocation) -> Map.Response.UserLocation {
    let latitude: CLLocationDegrees = currentLocation.latitude
    let newLatitude = latitude - CLLocationDistance(meters).fromMetersToLatitude()
    
    return Map.Response.UserLocation(latitude: newLatitude, longitude: currentLocation.longitude)
  }
}

extension CLLocationDistance {
  
  func fromMetersToLatitude() -> CLLocationDegrees {
    return self / 111111
  }
}

protocol LocationProtocol {
  func getCurrentLocation() -> Map.Response.UserLocation?
}
