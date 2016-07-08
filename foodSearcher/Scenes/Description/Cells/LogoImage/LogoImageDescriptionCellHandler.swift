//
//  LogoImageDescriptionCellHandler.swift
//  foodSearcher
//
//  Created by Andrey Lebedev on 06/07/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

class LogoImageDescriptionCellHandler {
  
  private weak var cell: LogoImageDescriptionCell?
  var cellWidth: CGFloat?
  private var descriptionModel: DescriptionModelLogoImage
  
  required init(descriptionModel: DescriptionModel) {
    self.descriptionModel = descriptionModel as! DescriptionModelLogoImage
  }
}

extension LogoImageDescriptionCellHandler: DescriptionCellHandlerable {
  
  func setCell(cell: UICollectionViewCell) {
    guard let curCell = cell as? LogoImageDescriptionCell else { return }
    self.cell = curCell
    self.cell?.handler = self
  }
  
  func updateCell() {
    
  }
}