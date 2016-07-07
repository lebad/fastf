//
//  DescriptionWorker.swift
//  foodSearcher
//
//  Created by andrey on 05/07/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import Foundation

class DescriptionWorker {
  private var descriptionWorker:DescriptionStoreProtocol
  
  init(descriptionWorker: DescriptionStoreProtocol) {
    self.descriptionWorker = descriptionWorker
  }
  
  func fetchDescriptionModelsForID(id: String, completionHandler: (models: [DescriptionModel]) -> Void) {
    self.descriptionWorker.fetchDescriptionModelsForID(id) { (result) in
      switch result {
      case .Success(let models):
        completionHandler(models: models)
      case .Failure(let error):
        print(error)
        completionHandler(models: [])
      }
    }
  }
}

protocol DescriptionStoreProtocol {
  func fetchDescriptionModelsForID(id: String, completionHandler: DescriptopnStoreCompletionHandler)
}

typealias DescriptopnStoreCompletionHandler = (result: DescriptionStoreResult<[DescriptionModel]>) -> Void

enum DescriptionStoreResult<U> {
  case Success(result: U)
  case Failure(error: DescriptionStoreError)
}

enum DescriptionStoreError: ErrorType {
  case CannotFetch(String)
}