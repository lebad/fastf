//
//  FromMapToDescriptionAnimator.swift
//  foodSearcher
//
//  Created by andrey on 29/06/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

protocol FromViewController: class {
  
}

protocol ToViewController: class {
  
}

class FromMapToDescriptionAnimator: UIPercentDrivenInteractiveTransition {
  
  weak var fromViewController: FromViewController?
  weak var toViewController: ToViewController?
  
  init(fromVC: FromViewController, toVC: ToViewController) {
    super.init()
    self.fromViewController = fromVC
    self.toViewController = toVC
  }

  
}

// MARK: - UIViewControllerTransitioningDelegate
extension FromMapToDescriptionAnimator: UIViewControllerTransitioningDelegate {
  
  func animationControllerForPresentedController(presented: UIViewController,
                                                 presentingController presenting: UIViewController,
                                                                      sourceController source: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
    return self
  }
  
  func animationControllerForDismissedController(dismissed: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
    return self
  }
  
  func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning)
    -> UIViewControllerInteractiveTransitioning? {
    return self
  }
  
  func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning)
    -> UIViewControllerInteractiveTransitioning? {
    return self
  }
}

// MARK: - UIViewControllerAnimatedTransitioning
extension FromMapToDescriptionAnimator: UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return 0.5
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    
  }
}

// MARK: - UIViewControllerInteractiveTransitioning
extension FromMapToDescriptionAnimator {
  
}



