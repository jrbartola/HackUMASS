//
//  CustomModels.swift
//  Medicus
//
//  Created by Jesse Bartola on 10/8/16.
//  Copyright © 2016 VJRE. All rights reserved.
//

import Foundation
import Clarifai


enum Diseases {
    case cancer
    case hives
    case ringworm
}

struct CustomModels {
    
    let scImages: [UIImage] = [UIImage(named: "skincancer1")!, UIImage(named: "skincancer2")!, UIImage(named: "skincancer3")!,
                             UIImage(named: "skincancer4")!, UIImage(named: "skincancer5")!, UIImage(named: "skincancer6")!,
                             UIImage(named: "skincancer7")!, UIImage(named: "skincancer8")!, UIImage(named: "skincancer9")!,
                             UIImage(named: "skincancer10")!]
    
    let ringwormImages: [UIImage] = [UIImage(named: "ringworm1")!, UIImage(named: "ringworm2")!, UIImage(named: "ringworm3")!,
                                  UIImage(named: "ringworm4")!, UIImage(named: "ringworm5")!, UIImage(named: "ringworm6")!,
                                  UIImage(named: "ringworm7")!, UIImage(named: "ringworm8")!, UIImage(named: "ringworm9")!,
                                  UIImage(named: "ringworm10")!]
    
    let hivesImages: [UIImage] = [UIImage(named: "hives1")!, UIImage(named: "hives2")!, UIImage(named: "hives3")!,
                                  UIImage(named: "hives4")!, UIImage(named: "hives5")!, UIImage(named: "hives6")!,
                                  UIImage(named: "hives7")!, UIImage(named: "hives8")!, UIImage(named: "hives9")!,
                                  UIImage(named: "hives10")!]
    let app: ClarifaiApp
    var model: ClarifaiModel?
    
    func add(images: [UIImage], concept: String) {
        var clarifiedImages: [ClarifaiImage] = []
        // For every image in the array initialize an instance of ClarifaiImage
        for image in images {
            clarifiedImages.append(ClarifaiImage(image:image, andConcepts:[concept]))
            
        }
        
        // Add images to the app
        app.add(clarifiedImages, completion: { (input, error) in
            createModel(concept, ClarifaiConcept(conceptName: concept))
        })
        
    }
    
    init(applicaiton app: ClarifaiApp, disease: Diseases) {
        // Initialize each model depending on which disease is specified
        self.app = app
        switch disease {
        case .cancer:
            add(images: scImages, concept: "Skin Cancer")
        case .hives:
            add(images: hivesImages, concept: "Hives")
        case .ringworm:
            add(images: ringwormImages, concept: "Ringworm")
        }
        
        //ClarifaiConcept.
        
    }
    
    private func createModel(name: String, concept: ClarifaiConcept) {
        app.createModel([concept], name: name, conceptsMutuallyExclusive: false, closedEnvironment: false, completion: { (model, error) in
            
            
        })
        
    }
    
    
    
    
}
