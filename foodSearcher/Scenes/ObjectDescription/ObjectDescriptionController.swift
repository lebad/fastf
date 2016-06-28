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

class ObjectDescriptionController: NSObject {
  
  var output: ObjectDescriptionControllerOutput!
  var router: ObjectDescriptionRouter!
  
  lazy var collectionView: UICollectionView =  {
    [unowned self] in
    let flowayout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: flowayout)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = UIColor.whiteColor()
    return collectionView
  }()
  
  init(mainView: UIView) {
    self.mainView = mainView
    super.init()
  }
  
  func presentController() {
    addDescritionView(descriptionView)
    addContainerView(containerView)
    addCollectionView(collectionView)
  }
  
  private
  
  let defaultViewHeight: CGFloat = 300.0
  var mainView: UIView
  
  let descriptionView = UIView(frame: CGRectZero)
  let containerView = UIView(frame: CGRectZero)
  var bottomContainerConstraint = NSLayoutConstraint()
  
  
  func addDescritionView(view: UIView) {
    mainView.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false;
    mainView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|",
      options: NSLayoutFormatOptions(rawValue: 0),
      metrics: nil,
      views: ["view": view]))
    mainView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]",
      options: NSLayoutFormatOptions(rawValue: 0),
      metrics: nil,
      views: ["view": view]))
    bottomContainerConstraint =  NSLayoutConstraint(item: view,
                                                    attribute: .Height,
                                                    relatedBy: .Equal,
                                                    toItem: nil,
                                                    attribute: .NotAnAttribute,
                                                    multiplier: 1.0,
                                                    constant: defaultViewHeight)
    view.addConstraint(bottomContainerConstraint)
    view.backgroundColor = UIColor.redColor()
    view.clipsToBounds = true
  }
  
  func addContainerView(view: UIView) {
    descriptionView.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
    descriptionView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[view]-|",
      options: NSLayoutFormatOptions(rawValue: 0),
      metrics: nil,
      views: ["view": view]))
    descriptionView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view(==height)]",
      options: NSLayoutFormatOptions(rawValue:0),
      metrics: ["height": CGRectGetHeight(mainView.frame)],
      views: ["view": view]))
    view.backgroundColor = UIColor.blueColor()
  }
  
  func addCollectionView(collectionView: UICollectionView) {
    containerView.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[view]-|",
      options: NSLayoutFormatOptions(rawValue: 0),
      metrics: nil,
      views: ["view": collectionView]))
    containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[view]-|",
      options: NSLayoutFormatOptions(rawValue: 0),
      metrics: nil,
      views: ["view": collectionView]))
  }
}

extension ObjectDescriptionController: UICollectionViewDataSource {
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }

  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }
}

extension ObjectDescriptionController: UICollectionViewDelegate {
  
}

extension ObjectDescriptionController: UICollectionViewDelegateFlowLayout {
  
}
