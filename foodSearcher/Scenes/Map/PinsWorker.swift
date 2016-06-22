//
//  PinsWorker.swift
//  foodSearcher
//
//  Created by andrey on 20/06/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import Foundation

class PinsWorker {
  var pinsStore: PinsStoreProtocol
  
  init(pinsStore: PinsStoreProtocol) {
    self.pinsStore = pinsStore
  }
  
  func fetchPins(completionHandler: (pins: [Pin]) -> Void) {
    pinsStore.fetchPins { (result) in
      switch result {
      case .Success(let pins):
        completionHandler(pins: pins)
      case .Failure(let error):
        print(error)
        completionHandler(pins: [])
      }
    }
  }
}

// MARK: - Pins store API
protocol PinsStoreProtocol {
  func fetchPins(completionHandler: PinsStoreCompletionHandler)
}

typealias PinsStoreCompletionHandler = (result: PinsStoreResult<[Pin]>) -> Void

enum PinsStoreResult<U> {
  case Success(result: U)
  case Failure(error: PinsStoreError)
}

enum PinsStoreError: ErrorType {
  case CannotFetch(String)
}