//
//  DescriptionControllerInteractor.swift
//  foodSearcher
//
//  Created by andrey on 02/07/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import Foundation

protocol DescriptionInteractorOutput: class {
  
}

protocol DescriptionInteractorInput {
  
}

class DescriptionInteractor: DescriptionInteractorInput {
  weak var output: DescriptionInteractorOutput!
  
}
