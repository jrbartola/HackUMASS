//
//  ReportController.swift
//  Medicus
//
//  Created by Jesse Bartola on 10/8/16.
//  Copyright © 2016 VJRE. All rights reserved.
//

import UIKit

class ReportController: UIViewController {

    let cancerDesc = "Melanoma is one of the most widely-recognized forms of cancer worldwide. It is " +
        "state to be one of the most deadly types as well. Symptoms include large red legions on the skin, " +
        "malignant tumors, and discoloration. One may also expreience vomiting and malaise."
    
    let hivesDesc = "Hives also known as urticaria, is a kind of skin rash with red, raised, itchy bumps. " +
        "They may also burn or sting. Often the patches of rash move around. Typically they last a few days and " +
        "do not leave any long lasting skin changes. Fewer than 5% of cases last for more than six weeks."
    
    let ringwormDesc = "Ringworm is a fungal infection of the skin. Typically it results in a red, itchy, scaly, circular rash. Hair loss may occur in the area affected. Symptoms begin four to fourteen days after exposure. Multiple areas can be affected at a given time."
    
    var diagnosis: String = ""
    
    @IBOutlet weak var conditionDescriptionLabel: UILabel!
    @IBOutlet weak var conditionNameLabel: UILabel!
    @IBOutlet weak var confidenceLabel: UILabel!
    @IBOutlet weak var treatmentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conditionNameLabel.text = diagnosis
        
        if (diagnosis == "Skin Cancer") {
            conditionDescriptionLabel.text = cancerDesc
        } else if (diagnosis == "Hives") {
            conditionDescriptionLabel.text = hivesDesc
        } else if (diagnosis == "Ringworm") {
            conditionDescriptionLabel.text = ringwormDesc
        }
        // Do any additional setup after loading the view.
    }
    
    


}
