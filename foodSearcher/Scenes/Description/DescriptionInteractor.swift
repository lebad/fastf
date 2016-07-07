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
  private(set) var descriptionModels: [DescriptionModel]?
  private var descriptionWorker = DescriptionWorker(descriptionWorker: DescriptionMemStore())
  
  func fetchDescriptionObjects() {
    guard let id = pin?.id else { return }
    descriptionWorker.fetchDescriptionModelsForID(id) { (models) in
      self.output.showDescriptionModels(Description.Response(descriptionObjects: models))
    }
  }
  
}
