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
  private var cellWidth: CGFloat?
  private var descriptionModel: DescriptionModelMainImage
  
  required init(descriptionModel: DescriptionModel) {
    self.descriptionModel = descriptionModel as! DescriptionModelMainImage
  }
  
}

extension MainImageDescriptionCellHandler: DescriptionCellHandlerable {
  
  func setCell(cell: UICollectionViewCell) {
    guard let curCell = cell as? MainImageDescriptionCell else { return }
    self.cell = curCell
  }
  
  func setCellWidth(width: CGFloat) {
    self.cellWidth = width
  }
  
  func updateCell() {
    
  }
}
