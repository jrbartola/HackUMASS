//
//  CustomModels.swift
//  Medicus
//
//  Created by Jesse Bartola on 10/8/16.
//  Copyright © 2016 VJRE. All rights reserved.
//

import Foundation
import Clarifai

/*
struct CustomModels {
    
    var images
}*/

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
    
    let hivesImages: [UIImage] = []
    let app: ClarifaiApp
    
    func add(images: [UIImage]) {
        var clarifiedImages: [ClarifaiImage] = []
        // For every image in the array initialize an instance of ClarifaiImage
        for image in images {
            clarifiedImages.append(ClarifaiImage(image:image))
        }
        
        // Add images to the app
        app.add(clarifiedImages, completion: { (input, error) in
            
        })
        
    }
    
    init(applicaiton app: ClarifaiApp, disease: Diseases) {
        // Initialize each model depending on which disease is specified
        self.app = app
        switch disease {
        case .cancer:
            add(images: scImages)
        case .hives:
            add(images: hivesImages)
        case .ringworm:
            add(images: ringwormImages)
        }
        
    }
        
    
    
    
}
