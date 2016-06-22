//
//  MapInteractor.swift
//  foodSearcher
//
//  Created by andrey on 19/06/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

protocol MapInteractorOutput: class {
  func didSuccessAuthorization()
  func didUpdateLocation(response: Map.Response.UserLocation)
}

protocol MapInteractorInput {
  func requestAuthorization()
  func startUpdatingLocation()
  func stopUpdatingLocation()
  
  func fetchPins()
}

class MapInteractor: MapInteractorInput {
  weak var output: MapInteractorOutput! {
    didSet {
      self.locationWorker = LocationWorker(output: self.output)
      self.pinsWorker = PinsWorker(pinsStore: PinsMemStore(locationObj: self.locationWorker))
    }
  }
  var locationWorker: LocationWorker!
  var pinsWorker: PinsWorker!
  
  
  func requestAuthorization() {
    locationWorker.requestAuthorization()
  }
  
  func startUpdatingLocation() {
    locationWorker.startUpdatingLocation()
  }
  
  func stopUpdatingLocation() {
    locationWorker.stopUpdatingLocation()
  }
  
  func fetchPins() {
    
  }
}
