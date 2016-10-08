//
//  ViewController.swift
//  Medicus
//
//  Created by Jesse Bartola on 10/8/16.
//  Copyright © 2016 VJRE. All rights reserved.
//

import UIKit
import Clarifai

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        trything()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func trything() {
        let client = ClarifaiClient(apiKey: "vrwKMC-M9uaJvSYxRHxGw3LhUNGETvB_fPDJh6gN", secretKey: "9khTBYzmsVjKbiiyBD5umBy6A8JAAkharwNahIJx")

        client.getConcepts(url: "http://anima.lemerg.com/data/uploads/12/542824.jpg", conceptCompletion: { (concepts: [String]?) in
            if let values = concepts {
                print(concepts)
            }
        })
        
        let sample = ClarifaiImage(url: "http://cbsnews1.cbsistatic.com/hub/i/2012/10/03/ff9e464c-a644-11e2-a3f0-029118418759/SCF-IntermediateMelanoma-0333.jpg")
        
        let cancerModel = CustomModel(applicaiton: client, disease: .cancer)
        cancerModel.trainModel()
        cancerModel.predict(images: [sample!], completion: { (predictions) in
            print("Some predictions for this image are: \(predictions)")
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

