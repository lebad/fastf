//
//  DescriptionViewController.swift
//  foodSearcher
//
//  Created by andrey on 29/06/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

protocol DescriptionControllerOutput {
  var pin: Pin? { get set }
  var descriptionModels: [DescriptionModel]? { get }
  func fetchDescriptionObject()
}

protocol DescriptionControllerInput {
  
}

class DescriptionViewController: UIViewController, DescriptionControllerInput {
  var output: DescriptionControllerOutput!
  var router: DescriptionRouter!
  
  lazy var descriptionCellFactory: DescriptionCellFactory = {
    let descFactory = DescriptionCellFactory()
    descFactory.setScreenWidth(CGRectGetWidth(self.collectionView.bounds))
    return descFactory
  }()
  
  @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
      let flowLayout = UICollectionViewFlowLayout()
      flowLayout.minimumLineSpacing = 0.0
      collectionView.collectionViewLayout = flowLayout
      collectionView.delegate = self
      collectionView.dataSource = self
      collectionView.registerCellNames(self.descriptionCellFactory.allCellNames)
    }
  }
  @IBOutlet weak var dismissButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    DescriptionConfigurator.configure(self)
  }
  
  @IBAction func dismissButtonAction(sender: UIButton) {
    self.router.navigateToMap()
  }
  
  func showDescriptionModels(response: Description.Response) {
    self.collectionView.reloadData()
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


