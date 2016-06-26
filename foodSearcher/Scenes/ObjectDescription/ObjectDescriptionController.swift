//
//  ObjectDescriptionController.swift
//  foodSearcher
//
//  Created by andrey on 26/06/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

protocol ObjectDescriptionControllerOutput {
  
}

protocol ObjectDescriptionControllerInput {
  
}

class ObjectDescriptionController: UIViewController {
  
  var output: ObjectDescriptionControllerOutput!
  var router: ObjectDescriptionRouter!
}
