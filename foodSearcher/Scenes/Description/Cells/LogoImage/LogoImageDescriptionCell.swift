//
//  LogoImageDescriptionCell.swift
//  foodSearcher
//
//  Created by andrey on 04/07/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

class LogoImageDescriptionCell: BaseDescriptionCell {

  @IBOutlet weak var imageView: UIImageView! {
    didSet {
      imageView.contentMode = .ScaleAspectFit
      let image = UIImage(named: "stardogs")
      imageView.image = image
    }
  }
  @IBOutlet weak var heightImageViewConstraint: NSLayoutConstraint!
}
