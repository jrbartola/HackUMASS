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
    
    func getConcepts(url: String, modelName: String, conceptCompletion: @escaping (([String]?) -> Void)) {
        let image = ClarifaiImage.init(url: url)
        app.getModelByName("general-v1.3", completion: { (model: ClarifaiModel?, error: Error?) in
            
            model?.predict(on: [image!], completion: { (output, error) in
                if let concepts = output?[0].concepts {
                    var arr: [String] = []
                    // Iterate through concepts and add them to an array as Strings
                    for concept in concepts {
                        arr.append(concept.conceptName!)
                    }
                    conceptCompletion(arr)
                } else {
                    conceptCompletion(nil)
                }
                
            })
            
        })
    }
    
    // Default modelName is 'general-v1.3'
    func getConcepts(url: String, conceptCompletion: @escaping (([String]?) -> Void)) {
        return getConcepts(url: url, modelName: "general-v1.3", conceptCompletion: { (concepts) in
            if let cps = concepts {
                conceptCompletion(cps)
            } else {
                conceptCompletion(nil)
            }
        })
        //ClarifaiConcept.init(conceptName: <#T##String!#>)
    }
    
    
    /*
    func createModel() {
        
        app.add(<#T##inputs: [ClarifaiInput]!##[ClarifaiInput]!#>, completion: <#T##ClarifaiInputsCompletion!##ClarifaiInputsCompletion!##([ClarifaiInput]?, Error?) -> Void#>)
    }*/
    
    
    
    
}
