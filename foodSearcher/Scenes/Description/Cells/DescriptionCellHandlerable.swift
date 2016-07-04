//
//  DescriptionCellHandlerable.swift
//  foodSearcher
//
//  Created by andrey on 04/07/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

protocol DescriptionCellHandlerable {
  func setCell(cell: UICollectionViewCell)
  func setCellWidth(width: CGFloat)
  func updateCell()
}
