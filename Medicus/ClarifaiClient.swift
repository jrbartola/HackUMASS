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
    
    var apiKey: String
    var secretKey: String
    
    init(apiKey key: String, secretKey secret: String) {
        apiKey = key
        secretKey = secret
    }
    
}
