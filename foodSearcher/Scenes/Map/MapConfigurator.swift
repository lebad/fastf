//
//  MapConfigurator.swift
//  foodSearcher
//
//  Created by andrey on 19/06/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

extension MapViewController: MapInteractorOutput {
  
}

extension MapInteractor: MapViewControllerOutput {
  
}

class MapConfigurator {
  class func configure(viewController: MapViewController) {
    let router = MapRouter()
    router.viewController = viewController
    viewController.router = router
    
    let interactor = MapInteractor()
    interactor.output = viewController
    viewController.output = interactor
  }
}
