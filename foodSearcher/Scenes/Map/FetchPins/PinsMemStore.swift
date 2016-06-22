//
//  PinsMemStore.swift
//  foodSearcher
//
//  Created by andrey on 20/06/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import Foundation

class PinsMemStore: PinsStoreProtocol {
  
  let pins = []
  var locationObj: LocationProtocol
  
  init(locationObj: LocationProtocol) {
    self.locationObj = locationObj
  }
  
  func fetchPins(completionHandler: PinsStoreCompletionHandler) {
    do {
      let currentLocation = locationObj.getCurrentLocation()
      
    } catch {
      
    }
  }
}

protocol LocationProtocol {
  func getCurrentLocation() -> Map.Response.UserLocation?
}
