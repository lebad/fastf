//
//  TextDescriptionCellHandler.swift
//  foodSearcher
//
//  Created by Andrey Lebedev on 06/07/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

class TextDescriptionCellHandler {
  
  private weak var cell: TextDescriptionCell?
  var cellWidth: CGFloat?
  private var descriptionModel: DescriptionModelText
  
  required init(descriptionModel: DescriptionModel) {
    self.descriptionModel = descriptionModel as! DescriptionModelText
  }
}

extension TextDescriptionCellHandler: DescriptionCellHandlerable {
  
  func setCell(cell: UICollectionViewCell) {
    guard let curCell = cell as? TextDescriptionCell else { return }
    self.cell = curCell
    self.cell?.handler = self
    
    
    
  }
  
  func updateCell() {
    self.cell?.textView.text = descriptionModel.textString
  }
}