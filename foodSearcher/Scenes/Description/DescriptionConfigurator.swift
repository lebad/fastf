//
//  DescriptionConfigurator.swift
//  foodSearcher
//
//  Created by andrey on 02/07/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import Foundation

extension DescriptionViewController: DescriptionInteractorOutput {
  
}

extension DescriptionInteractor: DescriptionControllerOutput {
  
}

class DescriptionConfigurator {
  class func configure(viewController: DescriptionViewController) {
    let router = DescriptionRouter()
    router.viewController = viewController
    viewController.router = router
    
    let interactor = DescriptionInteractor()
    interactor.output = viewController
    viewController.output = interactor
  }
}
