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

class CustomModel {
    
    
    
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
    let client: ClarifaiClient
    var predictions: [String] = []
    var model: ClarifaiModel?
    var disease: Diseases
    
    func add(images: [UIImage], concept: String, completion: @escaping (CustomModel) -> Void) {
        var clarifiedImages: [ClarifaiImage] = []
        // For every image in the array initialize an instance of ClarifaiImage
        for image in images {
            clarifiedImages.append(ClarifaiImage(image:image, andConcepts:[concept]))
        
        }
        
        // Add images to the app
        client.app.add(clarifiedImages, completion: { (input, error) in
            self.createModel(name: concept, concept: ClarifaiConcept(conceptName: concept), completion: {(newModel) in
                completion(newModel)
            })
        })
        
    }
    
    init(applicaiton client: ClarifaiClient, disease: Diseases) {
        // Initialize each model depending on which disease is specified
        self.client = client
        self.disease = disease
        
    }
    
    func initialize(completion: @escaping (CustomModel) -> Void) {
        var concept: String
        var images: [UIImage]
        switch disease {
            
        case .cancer:
            concept = "Skin Cancer"
            images = scImages
        case .hives:
            concept = "Hives"
            images = hivesImages
        case .ringworm:
            concept = "Ringworm"
            images = ringwormImages
        }
        
        add(images: images, concept: concept, completion: {(newModel) in
            completion(newModel)
        })
    }
    
    private func createModel(name: String, concept: ClarifaiConcept, completion: @escaping (CustomModel) -> Void) {
        
        client.app.createModel([concept], name: name, conceptsMutuallyExclusive: false, closedEnvironment: false, completion: { (endModel, error) in
            
            // Set our model
            
            
            self.model = endModel
            completion(self)
        })
        
    }
    
    
    func trainModel(completion: @escaping (CustomModel) -> Void) {
        //if let model = self.model {
            client.app.getModelByID("b76b28a8863d436bb4196f830b34e6ac", completion: { (retModel, error) in
                if let toTrain = retModel {
                    toTrain.train() { (trainedModel, error1) in
                        self.model = trainedModel
                        completion(self)
                    }
                }
            })
        //}
    }
    
    func predict(images: [ClarifaiImage], completion: @escaping ([String]) -> Void) {
        
        if let model = self.model {
            print("Our model is: \(model.name!)")
            model.predict(on: images, completion: { (conceptArr, error) in
                print("Before: \(conceptArr)")
                if let output = conceptArr {
                    print("After: \(output)")
                    for o in output {
                        if let predictions = o.concepts {
                            for predict in predictions {
                                print("First concept: \(predict.conceptName)")
                                self.predictions.append(predict.conceptName)
                            }
                            // call completion handler with the prediction data
                            completion(self.predictions)
                            
                        }
                    }
                }
            })
        }
    }
    
    func toHugeArray() -> [ClarifaiImage] {
        var allImgs: [ClarifaiImage] = []
        for cancer in scImages {
            allImgs.append(ClarifaiImage(image: cancer))
        }
        
        for worm in ringwormImages {
            allImgs.append(ClarifaiImage(image: worm))
        }
        
        for hive in hivesImages {
            allImgs.append(ClarifaiImage(image: hive))
        }
        
        return allImgs
    }
    
    
    
    
}
