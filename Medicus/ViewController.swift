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
        testAPI()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func testAPI() {
        let client = ClarifaiClient(apiKey: "vikmP0140G5t-f9_3pCztAoiAY7V0-30eil5I0Rc",
                                    secretKey: "YuOjJnxaSYVSzjxhdWy1x7MABUzCjLIsJW9R3sl2")
        
        client.getConcepts(url: "http://cbsnews1.cbsistatic.com/hub/i/2012/10/03/ff9e464c-a644-11e2-a3f0-029118418759/SCF-IntermediateMelanoma-0333.jpg",
                           modelName: "Medicus-3", conceptCompletion: { (concepts: [(String, Float)]?) in
            if let values = concepts {
                print(values)
            }
        })
        
        
        /*let c = [ClarifaiConcept.init(conceptName: "Ringworm")!, ClarifaiConcept.init(conceptName: "Hives")!,
                 ClarifaiConcept.init(conceptName: "Skin Cancer")!]*/
        
        /*client.app.delete(c, fromModelWithID: "e18b3b74dfe94b97bd32169ed3230430", completion: { (model, error) in
            print("Concepts deleted from \(model)")
        })*/
        
        /*let sample = ClarifaiImage(url: "http://cbsnews1.cbsistatic.com/hub/i/2012/10/03/ff9e464c-a644-11e2-a3f0-029118418759/SCF-IntermediateMelanoma-0333.jpg")
        let sample2 = ClarifaiImage(url: "http://ichef-1.bbci.co.uk/news/660/media/images/77303000/jpg/_77303278_skin_cancer-spl-1.jpg")
        let sample3 = ClarifaiImage(url: "http://www.bicycling.com/sites/bicycling.com/files/styles/slideshow-desktop/public/black-mole.jpg")
        */
        
        
        //var customs = CustomModel(applicaiton: client, disease: .ringworm)
        //customs.trainModel() { (newmodel) in
            
        //}
        /*
        customs.initialize() { (model1) in
            model1.trainModel() { (model2) in
               
            }
        }
        
        customs = CustomModel(applicaiton: client, disease: .hives)
        
        customs.initialize() { (model1) in
            model1.trainModel() { (model2) in
                
            }
        }
        
        customs = CustomModel(applicaiton: client, disease: .cancer)
        
        customs.initialize() { (model1) in
            model1.trainModel() { (model2) in
                
            }
        }*/
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

