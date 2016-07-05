//
//  DescriptionCellFactory.swift
//  foodSearcher
//
//  Created by Andrey Lebedev on 05/07/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

class DescriptionCellFactory {
  
  class var allCellNames: [String] {
    get {
      return [String(MainImageDescriptionCell), String(LogoImageDescriptionCell), String(TextDescriptionCell)]
    }
  }
  
}
