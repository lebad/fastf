//
//  BaseDescriptionCell.swift
//  foodSearcher
//
//  Created by andrey on 03/07/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

class BaseDescriptionCell: UICollectionViewCell {
  
  weak var handler: DescriptionCellHandlerable?
  
//  var width: CGFloat?
  
  private var customConstraints: [NSLayoutConstraint] = {
    return [NSLayoutConstraint]()
  }()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.contentView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override class func requiresConstraintBasedLayout() -> Bool {
    return true
  }
  
  override func updateConstraints() {
    if self.customConstraints.count > 0 {
      self.contentView.removeConstraints(self.customConstraints)
      self.customConstraints.removeAll()
    }
    
    let view = self.contentView
    
    if let width = self.handler?.cellWidth {
      let constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[contentView(==width)]",
                                                                       options: NSLayoutFormatOptions(rawValue: 0),
                                                                       metrics: ["width": width],
                                                                       views: ["contentView": view])
      self.customConstraints += constraints
      self.contentView.addConstraints(constraints)
    }
    
    super.updateConstraints()
  }
  
  func calculateSize() -> CGSize {
    setNeedsLayout()
    layoutIfNeeded()
    
    let cellSize = self.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
    return cellSize
  }
}
