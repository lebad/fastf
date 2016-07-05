//
//  CellRegistarable.swift
//  foodSearcher
//
//  Created by Andrey Lebedev on 05/07/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

protocol CellRegistarable {
  func registerCellNames(cellNames:[String])
}

extension UICollectionView: CellRegistarable {
  
  func registerCellNames(cellNames:[String]) {
    for cellName in cellNames {
      let nib = UINib.init(nibName: cellName, bundle: nil)
      self.registerNib(nib, forCellWithReuseIdentifier: cellName)
    }
  }
}
