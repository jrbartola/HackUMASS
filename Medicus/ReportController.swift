//
//  ReportController.swift
//  Medicus
//
//  Created by Jesse Bartola on 10/8/16.
//  Copyright © 2016 VJRE. All rights reserved.
//

import UIKit

class ReportController: UIViewController {

    let cancerDesc = "Skin cancers are cancers that arise from the skin. They are due to the development of abnormal cells that have the ability to invade or spread to other parts of the body. Melanoma is one of the most widely-recognized forms of cancer worldwide. It is stated to be one of the most deadly types as well. Symptoms include large red legions on the skin, " +
        "malignant tumors, and skin discoloration. One may also expreience vomiting and malaise."
    
    let hivesDesc = "Hives also known as urticaria, is a kind of skin rash with red, raised, itchy bumps. " +
        "They may also burn or sting. Often the patches of rash move around. Typically they last a few days and " +
        "do not leave any long lasting skin changes. Fewer than 5% of cases last for more than six weeks.\n\nHives frequently occur following an infection or as a result of an allergic reaction such as to medication, insect bites, or food. Psychological stress, cold temperature, or vibration may also be a trigger."
    
    let ringwormDesc = "Ringworm is a fungal infection of the skin. Typically it results in a red, itchy, scaly, circular rash. Hair loss may occur in the area affected. Symptoms begin four to fourteen days after exposure. Multiple areas can be affected at a given time.\n\nRisk factors include using public showers, contact sports such as wrestling, excessive sweating, contact with animals, obesity, and poor immune function."
    
    var diagnosis: String = ""
    var confidence: Float = 0.0
    
    @IBOutlet weak var diseaseImageView: UIImageView!
    @IBOutlet weak var conditionDescriptionLabel: UILabel!
    @IBOutlet weak var conditionNameLabel: UILabel!
    @IBOutlet weak var confidenceLabel: UILabel!
    @IBOutlet weak var treatmentLabel: UILabel!
    @IBOutlet weak var sendReportButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conditionNameLabel.text = diagnosis
        //let confidence = arc4random_uniform(3)
        
        if confidence > 0.70 {
            confidenceLabel.text = "HIGH"
            confidenceLabel.textColor = UIColor.red
        } else if > 0.50 {
            confidenceLabel.text = "MEDIUM"
            confidenceLabel.textColor = UIColor.orange
        } else {
            confidenceLabel.text = "LOW"
            confidenceLabel.textColor = UIColor.green
        }
        
        if (diagnosis == "Skin Cancer") {
            conditionDescriptionLabel.text = cancerDesc
            diseaseImageView.image = UIImage(named: "skincancer6")
        } else if (diagnosis == "Hives") {
            conditionDescriptionLabel.text = hivesDesc
            diseaseImageView.image = UIImage(named: "hives3")
        } else {
            conditionDescriptionLabel.text = ringwormDesc
            diseaseImageView.image = UIImage(named: "ringworm8")
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendReport(_ sender: AnyObject) {
        let alert = UIAlertView()
        alert.title = "Good to go!"
        alert.message = "Your health report has been sent to your primary care physician for analysis."
        alert.addButton(withTitle: "Okay")
        alert.show()
        self.performSegue(withIdentifier: "backButton", sender: AnyObject?.self)
        
        
    }
    


}
