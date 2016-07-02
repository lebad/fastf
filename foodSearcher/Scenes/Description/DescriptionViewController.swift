//
//  DescriptionViewController.swift
//  foodSearcher
//
//  Created by andrey on 29/06/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

protocol DescriptionControllerOutput {
  
}

protocol DescriptionControllerInput {
  
}

class DescriptionViewController: UIViewController, DescriptionControllerInput {
  var output: DescriptionControllerOutput!
  var router: DescriptionRouter!
  
  @IBOutlet weak var dismissButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    DescriptionConfigurator.configure(self)
  }
  
  @IBAction func dismissButtonAction(sender: UIButton) {
    router.navigateToMap()
  }
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
