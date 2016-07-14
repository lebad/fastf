//
//  FromMapToDescriptionAnimator.swift
//  foodSearcher
//
//  Created by andrey on 29/06/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

public enum ARNTransitionAnimatorDirection: Int {
  case Top
  case Bottom
  case Left
  case Right
}

public enum ARNTransitionAnimatorOperation: Int {
  case None
  case Push
  case Pop
  case Present
  case Dismiss
}

protocol FromViewController: class {
  var view: UIView! { get }
  func getTargetView() -> UIView
  func pushViewController(viewController: UIViewController)
  func presentViewController(viewController: UIViewController)
  
  func beginAppearanceTransition()
  var containerView : UIView! { get }
  var tabBar : UITabBar! { get }
  func endAppearanceTransitionFromVC()
}

protocol ToViewController: class {
  var view: UIView! { get }
  func setInitialSettingsWith(delegate: UIViewControllerTransitioningDelegate)
  func popViewController()
  func dismissViewController()
}

class FromMapToDescriptionAnimator: UIPercentDrivenInteractiveTransition {
  
  // Handlers
  
  var presentationBeforeHandler : ((containerView: UIView, transitionContext: UIViewControllerContextTransitioning) ->())?
  var presentationAnimationHandler : ((containerView: UIView, percentComplete: CGFloat) ->())?
  var presentationCancelAnimationHandler : ((containerView: UIView) ->())?
  var presentationCompletionHandler : ((containerView: UIView, completeTransition: Bool) ->())?
  
  var dismissalBeforeHandler : ((containerView: UIView, transitionContext: UIViewControllerContextTransitioning) ->())?
  var dismissalAnimationHandler : ((containerView: UIView, percentComplete: CGFloat) ->())?
  var dismissalCancelAnimationHandler : ((containerView: UIView) ->())?
  var dismissalCompletionHandler : ((containerView: UIView, completeTransition: Bool) ->())?
  
  // Animation Settings
  
  var usingSpringWithDamping : CGFloat = 0.8
  var transitionDuration : NSTimeInterval = 0.5
  var initialSpringVelocity : CGFloat = 0.1
  var useKeyframeAnimation : Bool = false
  
  // Interactive Transition Gesture
  
  weak var gestureTargetView : UIView? {
    willSet {
      self.unregisterPanGesture()
    }
    didSet {
      self.registerPanGesture()
    }
  }
  var panCompletionThreshold : CGFloat = 100.0
  var direction : ARNTransitionAnimatorDirection = .Bottom
  var contentScrollView : UIScrollView?
  var interactiveType : ARNTransitionAnimatorOperation = .None {
    didSet {
      if self.interactiveType == .None {
        self.unregisterPanGesture()
      } else {
        self.registerPanGesture()
      }
    }
  }
  
  private(set) var operationType : ARNTransitionAnimatorOperation
  private(set) var isPresenting : Bool = true
  private(set) var isTransitioning : Bool = false
  
  private var gesture : UIPanGestureRecognizer?
  private var transitionContext : UIViewControllerContextTransitioning?
  private var panLocationStart : CGFloat = 0.0
  
  
  //mine
  
  weak var fromVC: FromViewController!
  weak var toVC: ToViewController! {
    didSet {
      self.toVC.setInitialSettingsWith(self)
    }
  }
  
  init(fromVC: FromViewController, toVC: ToViewController) {
    self.operationType = .Present
    self.fromVC = fromVC
    self.toVC = toVC
    
    self.isPresenting = true
    
    super.init()
  }
  
  func animate() {
    
    self.usingSpringWithDamping = 0.8
    self.gestureTargetView = self.fromVC.getTargetView()
    self.interactiveType = .Present
    
    // Present
    
    self.presentationBeforeHandler = { [unowned self] containerView, transitionContext in
      print("start presentation")
      self.fromVC.beginAppearanceTransition()
      
      self.direction = .Top
      
      let toVCOriginY1 = self.fromVC.getTargetView().frame.origin.y + self.fromVC.getTargetView().frame.size.height
      self.toVC.view.frame.origin.y = toVCOriginY1
      self.fromVC.view.insertSubview(self.toVC.view, belowSubview: self.fromVC.tabBar)
      
      self.fromVC.view.layoutIfNeeded()
      self.toVC.view.layoutIfNeeded()
      
      // miniPlayerView
      let startOriginY = self.fromVC.getTargetView().frame.origin.y
      let endOriginY = -self.fromVC.getTargetView().frame.size.height
      let diff = -endOriginY + startOriginY
      // tabBar
      let tabStartOriginY = self.fromVC.tabBar.frame.origin.y
      let tabEndOriginY = self.fromVC.containerView.frame.size.height
      let tabDiff = tabEndOriginY - tabStartOriginY
      
      self.presentationCancelAnimationHandler = { containerView in
        self.fromVC.getTargetView().frame.origin.y = startOriginY
        let toVCOriginY2 = self.fromVC.getTargetView().frame.origin.y + self.fromVC.getTargetView().frame.size.height
        self.toVC.view.frame.origin.y = toVCOriginY2
        self.fromVC.tabBar.frame.origin.y = tabStartOriginY
        self.fromVC.containerView.alpha = 1.0
        self.fromVC.tabBar.alpha = 1.0
        self.fromVC.getTargetView().alpha = 1.0
        for subview in self.fromVC.getTargetView().subviews {
          subview.alpha = 1.0
        }
      }
      
      self.presentationAnimationHandler = { [unowned self] containerView, percentComplete in
        let _percentComplete = percentComplete >= 0 ? percentComplete : 0
        let originY = startOriginY - (diff * _percentComplete)
        self.fromVC.getTargetView().frame.origin.y = originY
        if self.fromVC.getTargetView().frame.origin.y < endOriginY {
          self.fromVC.getTargetView().frame.origin.y = endOriginY
        }
        let toVCOriginY3 = self.fromVC.getTargetView().frame.origin.y + self.fromVC.getTargetView().frame.size.height
        self.toVC.view.frame.origin.y = toVCOriginY3
        self.fromVC.tabBar.frame.origin.y = tabStartOriginY + (tabDiff * _percentComplete)
        if self.fromVC.tabBar.frame.origin.y > tabEndOriginY {
          self.fromVC.tabBar.frame.origin.y = tabEndOriginY
        }
        
        let alpha = 1.0 - (1.0 * _percentComplete)
        self.fromVC.containerView.alpha = alpha + 0.5
        self.fromVC.tabBar.alpha = alpha
        for subview in self.fromVC.getTargetView().subviews {
          subview.alpha = alpha
        }
      }
      
      self.presentationCompletionHandler = { containerView, completeTransition in
        self.fromVC.endAppearanceTransitionFromVC()
        
        if completeTransition {
          self.fromVC.getTargetView().alpha = 0.0
          self.toVC.view.removeFromSuperview()
          containerView.addSubview(self.toVC.view)
          self.interactiveType = .Dismiss
          self.gestureTargetView = self.toVC.view
          self.direction = .Bottom
        } else {
          self.fromVC.beginAppearanceTransition()
          self.fromVC.endAppearanceTransitionFromVC()
        }
      }
    }
    
    // Dismiss
    
    self.dismissalBeforeHandler = { [unowned self] containerView, transitionContext in
      print("start dismissal")
      self.fromVC.beginAppearanceTransition()
      
      self.fromVC.view.addSubview(self.toVC.view)
      self.fromVC.view.insertSubview(self.toVC.view, belowSubview: self.fromVC.tabBar)
      
      self.fromVC.view.layoutIfNeeded()
      self.toVC.view.layoutIfNeeded()
      
      // miniPlayerView
      let startOriginY = 0 - self.fromVC.getTargetView().bounds.size.height
      let endOriginY = self.fromVC.containerView.bounds.size.height - self.fromVC.tabBar.bounds.size.height - self.fromVC.getTargetView().frame.size.height
      let diff = -startOriginY + endOriginY
      // tabBar
      let tabStartOriginY = containerView.bounds.size.height
      let tabEndOriginY = containerView.bounds.size.height - self.fromVC.tabBar.bounds.size.height
      let tabDiff = tabStartOriginY - tabEndOriginY
      
      self.fromVC.tabBar.frame.origin.y = containerView.bounds.size.height
      self.fromVC.containerView.alpha = 0.5
      
      self.dismissalCancelAnimationHandler = { containerView in
        self.fromVC.getTargetView().frame.origin.y = startOriginY
        self.toVC.view.frame.origin.y = self.fromVC.getTargetView().frame.origin.y + self.fromVC.getTargetView().frame.size.height
        self.fromVC.tabBar.frame.origin.y = tabStartOriginY
        self.fromVC.containerView.alpha = 0.5
        self.fromVC.tabBar.alpha = 0.0
        self.fromVC.getTargetView().alpha = 0.0
        for subview in self.fromVC.getTargetView().subviews {
          subview.alpha = 0.0
        }
      }
      
      self.dismissalAnimationHandler = { containerView, percentComplete in
        let _percentComplete = percentComplete >= -0.5 ? percentComplete : -0.5
        self.fromVC.getTargetView().frame.origin.y = startOriginY + (diff * _percentComplete)
        self.toVC.view.frame.origin.y = self.fromVC.getTargetView().frame.origin.y + self.fromVC.getTargetView().frame.size.height
        self.fromVC.tabBar.frame.origin.y = tabStartOriginY - (tabDiff *  _percentComplete)
        
        let alpha = 1.0 * _percentComplete
        self.fromVC.getTargetView().alpha = alpha + 0.5
        self.fromVC.tabBar.alpha = alpha
        self.fromVC.getTargetView().alpha = 1.0
        for subview in self.fromVC.getTargetView().subviews {
          subview.alpha = alpha
        }
      }
      
      self.dismissalCompletionHandler = { containerView, completeTransition in
        self.fromVC.endAppearanceTransitionFromVC()
        
        if completeTransition {
          self.toVC.view.removeFromSuperview()
          self.gestureTargetView = self.fromVC.getTargetView()
          self.interactiveType = .Present
        } else {
          self.toVC.view.removeFromSuperview()
          self.fromVC.containerView.addSubview(self.toVC.view)
          self.fromVC.beginAppearanceTransition()
          self.fromVC.endAppearanceTransitionFromVC()
        }
      }
    }
    
//    self.toVC.transitioningDelegate = self.animator
  }
  
  // MARK: - Gesture
  
  private func registerPanGesture() {
    self.unregisterPanGesture()
    
    self.gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
    self.gesture!.delegate = self
    self.gesture!.maximumNumberOfTouches = 1
    
    if let _gestureTargetView = self.gestureTargetView {
      _gestureTargetView.addGestureRecognizer(self.gesture!)
    } else {
      switch (self.interactiveType) {
      case .Push, .Present:
        self.fromVC.view.addGestureRecognizer(self.gesture!)
      case .Pop, .Dismiss:
        self.toVC.view.addGestureRecognizer(self.gesture!)
      case .None:
        break
      }
    }
  }
  
  private func unregisterPanGesture() {
    if let _gesture = self.gesture {
      if let _view = _gesture.view {
        _view.removeGestureRecognizer(_gesture)
      }
      _gesture.delegate = nil
    }
    self.gesture = nil
  }
  
  // MARK: - Fire
  
  private func fireBeforeHandler(containerView: UIView, transitionContext: UIViewControllerContextTransitioning) {
    if self.isPresenting {
      self.presentationBeforeHandler?(containerView: containerView, transitionContext: transitionContext)
    } else {
      self.dismissalBeforeHandler?(containerView: containerView, transitionContext: transitionContext)
    }
  }
  
  private func fireAnimationHandler(containerView: UIView, percentComplete: CGFloat) {
    if self.isPresenting {
      self.presentationAnimationHandler?(containerView: containerView, percentComplete: percentComplete)
    } else {
      self.dismissalAnimationHandler?(containerView: containerView, percentComplete: percentComplete)
    }
  }
  
  private func fireCancelAnimationHandler(containerView: UIView) {
    if self.isPresenting {
      self.presentationCancelAnimationHandler?(containerView: containerView)
    } else {
      self.dismissalCancelAnimationHandler?(containerView: containerView)
    }
  }
  
  private func fireCompletionHandler(containerView: UIView, completeTransition: Bool) {
    if self.isPresenting {
      self.presentationCompletionHandler?(containerView: containerView, completeTransition: completeTransition)
    } else {
      self.dismissalCompletionHandler?(containerView: containerView, completeTransition: completeTransition)
    }
  }
  
  // MARK: - AnimationDuration
  
  private func animateWithDuration(duration: NSTimeInterval, containerView: UIView, completeTransition: Bool, completion: (() -> Void)?) {
    if !self.useKeyframeAnimation {
      UIView.animateWithDuration(
        duration,
        delay: 0.0,
        usingSpringWithDamping: self.usingSpringWithDamping,
        initialSpringVelocity: self.initialSpringVelocity,
        options: .CurveEaseOut,
        animations: {
          if completeTransition {
            self.fireAnimationHandler(containerView, percentComplete: 1.0)
          } else {
            self.fireCancelAnimationHandler(containerView)
          }
        }, completion: { finished in
          self.fireCompletionHandler(containerView, completeTransition: completeTransition)
          completion?()
      })
    } else {
      UIView.animateKeyframesWithDuration(
        duration,
        delay: 0.0,
        options: .BeginFromCurrentState,
        animations: {
          if completeTransition {
            self.fireAnimationHandler(containerView, percentComplete: 1.0)
          } else {
            self.fireCancelAnimationHandler(containerView)
          }
        }, completion: { finished in
          self.fireCompletionHandler(containerView, completeTransition: completeTransition)
          completion?()
      })
    }
  }
}

// MARK: - UIViewControllerTransitioningDelegate
extension FromMapToDescriptionAnimator: UIViewControllerTransitioningDelegate {
  
  func animationControllerForPresentedController(presented: UIViewController,
                                                 presentingController presenting: UIViewController,
                                                 sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    self.isPresenting = true
    return self
  }
  
  func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    self.isPresenting = false
    return self
  }
  
  func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    if self.gesture != nil && (self.interactiveType == .Push || self.interactiveType == .Present) {
      self.isPresenting = true
      return self
    }
    return nil
  }
  
  func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    if self.gesture != nil && (self.interactiveType == .Pop || self.interactiveType == .Dismiss) {
      self.isPresenting = false
      return self
    }
    return nil
  }
}

// MARK: - UIViewControllerAnimatedTransitioning
extension FromMapToDescriptionAnimator: UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return self.transitionDuration
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView()
    
    self.transitionContext = transitionContext
    self.fireBeforeHandler(containerView!, transitionContext: transitionContext)
    
    self.animateWithDuration(
      self.transitionDuration(transitionContext),
      containerView: containerView!,
      completeTransition: true) {
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }
  }
  
  func animationEnded(transitionCompleted: Bool) {
    self.transitionContext = nil
  }
}

// MARK: - UIViewControllerInteractiveTransitioning
extension FromMapToDescriptionAnimator {
  
  override func startInteractiveTransition(transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView()
    
    // FIXME : UINavigationController not called animator UIViewControllerTransitioningDelegate
    switch (self.interactiveType) {
    case .Push, .Present:
      self.isPresenting = true
    case .Pop, .Dismiss:
      self.isPresenting = false
    case .None:
      break
    }
    
    self.transitionContext = transitionContext
    self.fireBeforeHandler(containerView!, transitionContext: transitionContext)
  }
}

// MARK: - UIPercentDrivenInteractiveTransition

extension FromMapToDescriptionAnimator {
  
  override func updateInteractiveTransition(percentComplete: CGFloat) {
    super.updateInteractiveTransition(percentComplete)
    if let transitionContext = self.transitionContext {
      let containerView = transitionContext.containerView()
      self.fireAnimationHandler(containerView!, percentComplete: percentComplete)
    }
  }
  
  func finishInteractiveTransitionAnimated(animated: Bool) {
    super.finishInteractiveTransition()
    if let transitionContext = self.transitionContext {
      let containerView = transitionContext.containerView()
      self.animateWithDuration(
        animated ? self.transitionDuration(transitionContext) : 0,
        containerView: containerView!,
        completeTransition: true) {
          transitionContext.completeTransition(true)
      }
    }
  }
  
  func cancelInteractiveTransitionAnimated(animated: Bool) {
    super.cancelInteractiveTransition()
    if let transitionContext = self.transitionContext {
      let containerView = transitionContext.containerView()
      self.animateWithDuration(
        animated ? self.transitionDuration(transitionContext) : 0,
        containerView: containerView!,
        completeTransition: false) {
          transitionContext.completeTransition(false)
      }
    }
  }
}

// MARK: - Interactive Transition Gesture

extension FromMapToDescriptionAnimator {
  
  internal func handlePan(recognizer: UIPanGestureRecognizer) {
    var window : UIWindow? = nil
    
    switch (self.interactiveType) {
    case .Push, .Present:
      window = self.fromVC.view.window
    case .Pop, .Dismiss:
      window = self.toVC.view.window
    case .None:
      return
    }
    
    var location = recognizer.locationInView(window)
    location = CGPointApplyAffineTransform(location, CGAffineTransformInvert(recognizer.view!.transform))
    var velocity = recognizer .velocityInView(window)
    velocity = CGPointApplyAffineTransform(velocity, CGAffineTransformInvert(recognizer.view!.transform))
    
    if recognizer.state == .Began {
      self.setPanStartPoint(location)
      
      if let _contentScrollView = self.contentScrollView {
        if _contentScrollView.contentOffset.y <= 0.0 {
          self.startGestureTransition()
        }
      } else {
        self.startGestureTransition()
      }
    } else if recognizer.state == .Changed {
      var bounds = CGRectZero
      switch (self.interactiveType) {
      case .Push, .Present:
        bounds = self.fromVC.view.bounds
      case .Pop, .Dismiss:
        bounds = self.toVC.view.bounds
      case .None:
        break
      }
      
      var animationRatio: CGFloat = 0.0
      switch self.direction {
      case .Top:
        animationRatio = (self.panLocationStart - location.y) / CGRectGetHeight(bounds)
      case .Bottom:
        animationRatio = (location.y - self.panLocationStart) / CGRectGetHeight(bounds)
      case .Left:
        animationRatio = (self.panLocationStart - location.x) / CGRectGetWidth(bounds)
      case .Right:
        animationRatio = (location.x - self.panLocationStart) / CGRectGetWidth(bounds)
      }
      
      if let _contentScrollView = self.contentScrollView {
        if self.isTransitioning == false && _contentScrollView.contentOffset.y <= 0 {
          self.setPanStartPoint(location)
          self.startGestureTransition()
        } else {
          self.updateInteractiveTransition(animationRatio)
        }
      } else {
        self.updateInteractiveTransition(animationRatio)
      }
    } else if recognizer.state == .Ended {
      var velocityForSelectedDirection: CGFloat = 0.0
      switch (self.direction) {
      case .Top, .Bottom:
        velocityForSelectedDirection = velocity.y
      case .Left, .Right:
        velocityForSelectedDirection = velocity.x
      }
      
      if velocityForSelectedDirection > self.panCompletionThreshold && (self.direction == .Right || self.direction == .Bottom) {
        self.finishInteractiveTransitionAnimated(true)
      } else if velocityForSelectedDirection < -self.panCompletionThreshold && (self.direction == .Left || self.direction == .Top) {
        self.finishInteractiveTransitionAnimated(true)
      } else {
        let animated = self.contentScrollView?.contentOffset.y <= 0
        self.cancelInteractiveTransitionAnimated(animated)
      }
      self.resetGestureTransitionSetting()
    } else {
      self.resetGestureTransitionSetting()
      if self.isTransitioning {
        self.cancelInteractiveTransitionAnimated(true)
      }
    }
  }
  
  private func startGestureTransition() {
    if self.isTransitioning == false {
      self.isTransitioning = true
      switch (self.interactiveType) {
      case .Push:
        self.fromVC.pushViewController(self.toVC as! UIViewController)
      case .Present:
        self.fromVC.presentViewController(self.toVC as! UIViewController)
      case .Pop:
        self.toVC.popViewController()
      case .Dismiss:
        self.toVC.dismissViewController()
      case .None:
        break
      }
    }
  }
  
  private func resetGestureTransitionSetting() {
    self.isTransitioning = false
  }
  
  private func setPanStartPoint(location: CGPoint) {
    switch (self.direction) {
    case .Top, .Bottom:
      self.panLocationStart = location.y
    case .Left, .Right:
      self.panLocationStart = location.x
    }
  }
}

// MARK: - UIGestureRecognizerDelegate

extension FromMapToDescriptionAnimator: UIGestureRecognizerDelegate {
  
  func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return self.contentScrollView != nil ? true : false
  }
  
  func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer
    otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return false
  }
}

// MARK: - FromMapToDescriptionAnimatable

extension FromMapToDescriptionAnimator: FromMapToDescriptionAnimatable {
  
  func setDefaultType() {
    self.interactiveType = .None
  }
}




