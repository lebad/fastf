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
  
}

class MapInteractor {
  weak var output: MapInteractorOutput!
  lazy var locationWorker: LocationWorker = {
    return LocationWorker(output: self.output)
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
  
  func fetchPins(request: Map.Request) {
    
  }
}
