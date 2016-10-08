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
        let client = ClarifaiClient(apiKey: "vrwKMC-M9uaJvSYxRHxGw3LhUNGETvB_fPDJh6gN", secretKey: "9khTBYzmsVjKbiiyBD5umBy6A8JAAkharwNahIJx")

        client.getConcepts(url: "http://www.allergyasthmamichigan.com/web%20site%20contents/hives.jpg", modelName: "Medicus", conceptCompletion: { (concepts: [(String, Float)]?) in
            if let values = concepts {
                print(values)
            }
        })
        
        let sample = ClarifaiImage(url: "http://cbsnews1.cbsistatic.com/hub/i/2012/10/03/ff9e464c-a644-11e2-a3f0-029118418759/SCF-IntermediateMelanoma-0333.jpg")
        let sample2 = ClarifaiImage(url: "http://ichef-1.bbci.co.uk/news/660/media/images/77303000/jpg/_77303278_skin_cancer-spl-1.jpg")
        let sample3 = ClarifaiImage(url: "http://www.bicycling.com/sites/bicycling.com/files/styles/slideshow-desktop/public/black-mole.jpg")
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

