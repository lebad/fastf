//
//  MapModels.swift
//  foodSearcher
//
//  Created by andrey on 19/06/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

struct Map {
  struct Request {
    
  }
  
  struct Response {
    var pins: [Pin]
    
    struct UserLocation {
      var latitude: Double
      var longitude: Double
    }
  }
}


