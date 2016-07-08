//
//  MainImageDescriptionCellHandler.swift
//  foodSearcher
//
//  Created by andrey on 03/07/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

class MainImageDescriptionCellHandler {
  
  private weak var cell: MainImageDescriptionCell?
  var cellWidth: CGFloat?
  private var descriptionModel: DescriptionModelMainImage
  
  required init(descriptionModel: DescriptionModel) {
    self.descriptionModel = descriptionModel as! DescriptionModelMainImage
  }
  
}

extension MainImageDescriptionCellHandler: DescriptionCellHandlerable {
  
  func setCell(cell: UICollectionViewCell) {
    guard let curCell = cell as? MainImageDescriptionCell else { return }
    self.cell = curCell
    self.cell?.handler = self
  }
  
  func updateCell() {
    guard let image = self.cell?.imageView?.image else { return }
    addAspectRatioConstraintForImage(image)
  }
  
  private func addAspectRatioConstraintForImage(image: UIImage) {
    guard let cell = self.cell else { return }
    let aspectRatio = image.size.width / image.size.height
    let width = CGRectGetWidth(cell.bounds)
    let height = width / aspectRatio
    
    cell.heightImageViewConstraint.constant = height
  }
}
