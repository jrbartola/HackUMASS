//
//  ClarifaiClient.swift
//  Medicus
//
//  Created by Jesse Bartola on 10/8/16.
//  Copyright © 2016 VJRE. All rights reserved.
//

import Foundation
import Clarifai

class ClarifaiClient {
    
    let app: ClarifaiApp
    var picture: ClarifaiImage?
    
    init(apiKey key: String, secretKey secret: String) {
        app = ClarifaiApp(appID: key, appSecret: secret)
    }
    
    func getConcepts(url: String, modelName: String, conceptCompletion: @escaping (([(String, Float)]?) -> Void)) {
        let image = ClarifaiImage.init(url: url)
        app.getModelByName(modelName, completion: { (model: ClarifaiModel?, error: Error?) in
            
            model?.predict(on: [image!], completion: { (output, error) in
                //print(output)
                if let outputs = output {
                    
                    var arr: [(String, Float)] = []
                    // Iterate through concepts and add them to an array as Strings
                    if (outputs.count == 0) {
                        conceptCompletion(nil)
                    } else {
                        for concept in outputs[0].concepts {
                            arr.append((concept.conceptName!, concept.score))
                        }
                    }
                    
                    conceptCompletion(arr)
                } else {
                    conceptCompletion(nil)
                }
                
            })
            
        })
    }
    
    // Default modelName is 'general-v1.3'
    func getConcepts(url: String, conceptCompletion: @escaping (([(String, Float)]?) -> Void)) {
        return getConcepts(url: url, modelName: "general-v1.3", conceptCompletion: { (concepts) in
            if let cps = concepts {
                conceptCompletion(cps)
            } else {
                conceptCompletion(nil)
            }
        })
        
    }
    
    func getConcepts(image: UIImage, modelName: String, conceptCompletion: @escaping (([(String, Float)]?) -> Void)) {
        let image = ClarifaiImage(image: image)
        app.getModelByName(modelName, completion: { (model: ClarifaiModel?, error: Error?) in
            
            model?.predict(on: [image!], completion: { (output, error) in
                //print(output)
                if let outputs = output {
                    
                    var arr: [(String, Float)] = []
                    // Iterate through concepts and add them to an array as Strings
                    if (outputs.count == 0) {
                        conceptCompletion(nil)
                    } else {
                        for concept in outputs[0].concepts {
                            arr.append((concept.conceptName!, concept.score))
                        }
                    }
                    
                    conceptCompletion(arr)
                } else {
                    conceptCompletion(nil)
                }
                
            })
            
        })
    }
    
    
    
    
    
    func addImage(url: String, concepts: [String]?) {
        let image = ClarifaiImage.init(url: url, andConcepts: concepts)
        //self.images.append(image!)
        
    }
    
    
    
    
    
}
