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
  func showPins(response: Map.Response)
}

protocol MapInteractorInput {
  func requestAuthorization()
  func startUpdatingLocation()
  func stopUpdatingLocation()
  
  func fetchPins()
}

class MapInteractor: MapInteractorInput {
  weak var output: MapInteractorOutput!
  
  lazy var locationWorker: LocationWorker = {
    return LocationWorker(output: self.output)
  }()
  lazy var pinsWorker: PinsWorker = {
    return PinsWorker(pinsStore: PinsMemStore(locationObj: self.locationWorker))
  }()
  
  
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
     pinsWorker.fetchPins { (pins) in
      self.output.showPins(Map.Response(pins: pins))
    }
  }
}
