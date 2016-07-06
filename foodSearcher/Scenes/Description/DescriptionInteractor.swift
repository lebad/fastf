//
//  DescriptionControllerInteractor.swift
//  foodSearcher
//
//  Created by andrey on 02/07/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import Foundation

protocol DescriptionInteractorOutput: class {
  func showDescriptionModels(response: Description.Response)
}

protocol DescriptionInteractorInput {
  
}

class DescriptionInteractor: DescriptionInteractorInput {
  weak var output: DescriptionInteractorOutput!
  var pin: Pin?
  
  var descriptionModels: [DescriptionModel]?
  
  func fetchDescriptionObject() {
    
  }
}
