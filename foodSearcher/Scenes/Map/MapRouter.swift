//
//  MapRouter.swift
//  foodSearcher
//
//  Created by andrey on 19/06/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

protocol FromMapToDescriptionAnimatable {
  func setDefaultType()
}

class MapRouter {
  weak var viewController: MapViewController!
  
  private var animator: FromMapToDescriptionAnimator?
  private var descriptionVC: DescriptionViewController = {
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let descriptionVC = storyBoard.instantiateViewControllerWithIdentifier("DescriptionViewController") as! DescriptionViewController
    return descriptionVC
  }()
  
  func instantiateAnimator() {
    self.animator = FromMapToDescriptionAnimator(fromVC: self.viewController, toVC: self.descriptionVC)
    self.descriptionVC.setInitialSettingsWith(self.animator!)
    self.descriptionVC.router.animator = self.animator
    self.animator?.animate()
  }
  
  func navigateToDescriptionWithInteraction() {
    navigate()
  }
  
  func navigateToDescription() {
    self.animator?.interactiveType = .None
    navigate()
  }
  
  private func navigate() {
    passDataToDescriptionVC()
    viewController.presentViewController(descriptionVC, animated: true, completion: nil)
  }
  
  private func passDataToDescriptionVC() {
    guard let selectedIndex = self.viewController.selectedIndex else { return }
    let currentPin = self.viewController.output.pins?[selectedIndex]
    self.descriptionVC.output.pin = currentPin
  }
}
