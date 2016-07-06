//
//  DescriptionObject.swift
//  foodSearcher
//
//  Created by andrey on 05/07/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import Foundation

protocol DescriptionModel {
  
}

struct DescriptionModelMainImage: DescriptionModel {
  var mainImageURLString: String?
}

struct DescriptionModelLogoImage: DescriptionModel {
  var logoImageURLString: String?
}

struct DescriptionModelText: DescriptionModel {
  var textString: String?
}
