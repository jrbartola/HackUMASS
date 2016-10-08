//
//  ClarifaiModel.swift
//  Medicus
//
//  Created by Jesse Bartola on 10/8/16.
//  Copyright © 2016 VJRE. All rights reserved.
//

import Foundation
import Clarifai

class ClarifaiCustomModel {
    
    let name: String
    var images: [ClarifaiImage]
    var concepts: [ClarifaiConcept]
    
    init(modelName name: String) {
        self.name = name
        images = []
        concepts = []
    }
    
    func addImage(url: String, concepts: [String]?) {
        let image = ClarifaiImage.init(url: url, andConcepts: concepts)
        self.images.append(image!)
        
    }
    
    func addConcepts(concepts: [ClarifaiConcept]) {
        self.concepts += concepts
    }
    
    
}
