//
//  MapRouter.swift
//  foodSearcher
//
//  Created by andrey on 19/06/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

class MapRouter {
  weak var viewController: MapViewController!
  
  private var animator: FromMapToDescriptionAnimator?
  
  func navigateToDescription() {
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let descriptionVC = storyBoard.instantiateViewControllerWithIdentifier("DescriptionViewController") as! DescriptionViewController
    self.animator = FromMapToDescriptionAnimator(fromVC: self.viewController, toVC: descriptionVC)
    viewController.presentViewController(descriptionVC, animated: true, completion: nil)
  }
}
