//
//  DescriptionMemStore.swift
//  foodSearcher
//
//  Created by andrey on 05/07/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import Foundation

class DescriptionMemStore: DescriptionStoreProtocol {
  
  func fetchDescriptionModelsForID(id: String, completionHandler: DescriptopnStoreCompletionHandler) {
    
    let mainImage = DescriptionModelMainImage(mainImageURLString: "")
    let logoImage = DescriptionModelLogoImage(logoImageURLString: "")
    var textModel = DescriptionModelText()
    textModel.textString = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing"
    
    let models: [DescriptionModel] = [mainImage, logoImage, textModel]
    
    completionHandler(result: DescriptionStoreResult.Success(result: models))
  }
}
