//
//  CreateTrainingViewController.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-05-22.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import UIKit

class CreateTrainingViewController: UIViewController {

    @IBOutlet weak var trainingTitleTextField:UITextField!
    @IBOutlet weak var trainingCategoryTextField:UITextField!
    @IBOutlet weak var trainingMinutesTextField:UITextField!
    @IBOutlet weak var trainingAttendeesTextField:UITextField!
    @IBOutlet weak var trainingDescriptionTextView:UITextView!
    @IBOutlet weak var amITrainerSwitch:UISwitch!
    
    var amITrainerFlag:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create new training dictionary and pass it as post body parameter ....
        let tempTraining:Training = Training()
        tempTraining.trainingTitle = "abcd"
        tempTraining.trainingCategory = "Computer Programming"
        tempTraining.minSignUpCount = 25
        tempTraining.trainingMinutes = 90
        tempTraining.trainingDescription = "woei owkldskd lskd apoewpqoe s,d sladklsadiqo3ie dlsdmks dmsk end"
        
        amITrainerFlag = amITrainerSwitch.isOn
        
        if(amITrainerSwitch.isOn){
            //The signed in user becomes the trainer for this training ...
        }
        else{
            //This training comes as a suggestion by the current user ...
        }
        
        let tempDict = tempTraining.toDictionary()
        
        NewTrainingRequest(inTrainingDict: tempDict).createTraining(
            { (trainingId) in
                
                //New user created ...
                print("In View Model \(trainingId)")
                tempTraining.trainingId = trainingId
                print(tempTraining.trainingTitle)
//                responseCallback(training)
        },
            failure:
            {
                (error : Error?) in
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
