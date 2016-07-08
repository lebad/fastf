//
//  DescriptionCellHandlerable.swift
//  foodSearcher
//
//  Created by andrey on 04/07/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

protocol DescriptionCellHandlerable: class {
  func setCell(cell: UICollectionViewCell)
  var cellWidth: CGFloat? { get set }
  func updateCell()
  init(descriptionModel: DescriptionModel)
}
