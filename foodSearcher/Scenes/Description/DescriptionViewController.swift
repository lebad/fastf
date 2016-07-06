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
}

protocol DescriptionControllerInput {
  
}

class DescriptionViewController: UIViewController, DescriptionControllerInput {
  var output: DescriptionControllerOutput!
  var router: DescriptionRouter!
  
  @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
      let flowLayout = UICollectionViewFlowLayout()
      flowLayout.minimumLineSpacing = 0.0
      collectionView.collectionViewLayout = flowLayout
      collectionView.delegate = self
      collectionView.dataSource = self
      collectionView.registerCellNames(DescriptionCellFactory.allCellNames)
    }
  }
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

extension DescriptionViewController: UICollectionViewDelegate {
  
  
}


extension DescriptionViewController: UICollectionViewDataSource {
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
  }

  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
  }
}

extension DescriptionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
  }
}
