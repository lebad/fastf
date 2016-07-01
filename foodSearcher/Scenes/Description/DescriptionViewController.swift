//
//  DescriptionViewController.swift
//  foodSearcher
//
//  Created by andrey on 29/06/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
  
}

extension DescriptionViewController: ToViewController {
  
  func setInitialSettingsWith(delegate: UIViewControllerTransitioningDelegate) {
    self.transitioningDelegate = delegate
    self.modalPresentationStyle = .OverFullScreen
  }
  
  func popViewController() {
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  func dismissViewController() {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}
