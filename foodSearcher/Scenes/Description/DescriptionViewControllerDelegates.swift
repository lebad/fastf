//
//  DescriptionViewControllerDelegates.swift
//  foodSearcher
//
//  Created by Andrey Lebedev on 06/07/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

extension DescriptionViewController: UICollectionViewDelegate {
  
  
}

extension DescriptionViewController: UICollectionViewDataSource {
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let count = self.output.descriptionModels?.count else { return 0 }
    return count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    guard let descriptionModel = self.output.descriptionModels?[indexPath.row] else { return UICollectionViewCell() }
    let cellHandler = self.descriptionCellFactory.getCellHandlerForDescrptionModel(descriptionModel, indexPath: indexPath)
    let identifier = self.descriptionCellFactory.getIdentifierForModel(descriptionModel)
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath)
    cellHandler.setCell(cell)
    cellHandler.updateCell()
    return cell
  }
}

extension DescriptionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    guard let descriptionModel = self.output.descriptionModels?[indexPath.row] else { return CGSizeZero }
    let cell = self.descriptionCellFactory.getAndUpdateFakeCellForModel(descriptionModel, indexPath: indexPath)
    return cell.calculateSize()
  }
}