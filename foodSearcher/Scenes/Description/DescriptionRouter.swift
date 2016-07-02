//
//  DescriptionRouter.swift
//  foodSearcher
//
//  Created by andrey on 02/07/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import Foundation

class DescriptionRouter {
  weak var viewController: DescriptionViewController!
  var animator: FromMapToDescriptionAnimatable?
  
  func navigateToMap() {
    animator?.setDefaultType()
    self.viewController.dismissViewControllerAnimated(true, completion: nil)
  }
}
