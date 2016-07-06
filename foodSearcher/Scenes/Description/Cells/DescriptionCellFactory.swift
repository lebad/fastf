//
//  DescriptionCellFactory.swift
//  foodSearcher
//
//  Created by Andrey Lebedev on 05/07/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit

class DescriptionCellFactory {
  
  func getIdentifierForModel(model: DescriptionModel) -> String {
    let classString = String(model.dynamicType)
    let identifier = self.cellMatches[classString]
    return identifier!
  }
  
  var allCellNames: [String] {
    get {
      return Array(self.cellMatches.values)
    }
  }
  
  func setScreenWidth(width: CGFloat) {
    self.cellWidth = width
  }
  
  func getCellHandlerForDescrptionModel(descriptionModel: DescriptionModel, indexPath: NSIndexPath) -> DescriptionCellHandlerable {
    let handler = getHanler(descriptionModel, indexPath: indexPath)
    return handler
  }
  
  func getAndUpdateFakeCellForModel(model: DescriptionModel, indexPath: NSIndexPath) -> BaseDescriptionCell {
    let handler = getFakeHanler(model, indexPath: indexPath)
    let fakeCell = getFakeCell(model, indexPath: indexPath)
    handler.setCell(fakeCell)
    handler.updateCell()
    return fakeCell
  }
  
  private func getHanler(descriptionModel: DescriptionModel, indexPath: NSIndexPath) -> DescriptionCellHandlerable {
    if let cellHandler = self.cellHandlersDict[indexPath] {
      return cellHandler
    } else {
      let classString = String(descriptionModel.dynamicType)
      let handlerClass = handlerMatches[classString]
      let handler = handlerClass!.init(descriptionModel: descriptionModel)
      if let width = self.cellWidth {
        handler.setCellWidth(width)
      }
      self.cellHandlersDict[indexPath] = handler
      return handler
    }
  }
  
  private func getFakeHanler(descriptionModel: DescriptionModel, indexPath: NSIndexPath) -> DescriptionCellHandlerable {
    if let cellHandler = self.fakeCellHandlerDict[indexPath] {
      return cellHandler
    } else {
      let classString = String(descriptionModel.dynamicType)
      let handlerClass = handlerMatches[classString]
      let handler = handlerClass!.init(descriptionModel: descriptionModel)
      if let width = self.cellWidth {
        handler.setCellWidth(width)
      }
      self.fakeCellHandlerDict[indexPath] = handler
      return handler
    }
  }
  
  private func getFakeCell(descriotionModel: DescriptionModel, indexPath: NSIndexPath) -> BaseDescriptionCell {
    if let cell = self.fakeCellDict[indexPath] {
      return cell
    } else {
      let cellName = getIdentifierForModel(descriotionModel)
      let fakeCell = NSBundle.mainBundle().loadNibNamed(cellName, owner: nil, options: nil).first as! BaseDescriptionCell
      self.fakeCellDict[indexPath] = fakeCell
      return fakeCell
    }
  }
  

  private var cellWidth: CGFloat?
  private var cellHandlersDict = [NSIndexPath: DescriptionCellHandlerable]()
  private var fakeCellHandlerDict = [NSIndexPath: DescriptionCellHandlerable]()
  private var fakeCellDict = [NSIndexPath: BaseDescriptionCell]()
  
  private let cellMatches = [String(DescriptionModelMainImage): String(MainImageDescriptionCell),
                             String(DescriptionModelLogoImage): String(LogoImageDescriptionCell),
                             String(DescriptionModelText): String(TextDescriptionCell)]
  private let handlerMatches: [String: DescriptionCellHandlerable.Type] = [String(DescriptionModelMainImage): MainImageDescriptionCellHandler.self,
                                                                           String(DescriptionModelLogoImage): LogoImageDescriptionCellHandler.self,
                                                                           String(DescriptionModelText): TextDescriptionCellHandler.self]
}
