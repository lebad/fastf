//
//  MainImageDescriptionCell.swift
//  foodSearcher
//
//  Created by andrey on 03/07/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

class MainImageDescriptionCell: BaseDescriptionCell {
  
  @IBOutlet weak var imageView: UIImageView! {
    didSet {
      imageView.contentMode = .ScaleAspectFit
      let image = UIImage(named: "descriptionImagePlaceholder")
      imageView.image = image
    }
  }
  @IBOutlet weak var heightImageViewConstraint: NSLayoutConstraint!

  override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
  }

}
