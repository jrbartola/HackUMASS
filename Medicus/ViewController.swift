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
        let app = ClarifaiApp(appID: "vrwKMC-M9uaJvSYxRHxGw3LhUNGETvB_fPDJh6gN", appSecret: "9khTBYzmsVjKbiiyBD5umBy6A8JAAkharwNahIJx")
        //ClarifaiModel
        
        let image = ClarifaiImage.init(url: "http://anima.lemerg.com/data/uploads/12/542824.jpg")
        app?.getModelByName("general-v1.3", completion: { (model: ClarifaiModel?, error: Error?) in
            
            model?.predict(on: [image!], completion: { (output, error) in
                for concept in output![0].concepts! {
                    print(concept.conceptName!)
                }
            })
            
        })
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

