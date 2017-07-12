//
//  TrainingDetailViewController.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-06-01.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import UIKit

class TrainingDetailViewController: UIViewController {

    @IBOutlet weak var trainingDescriptionLabel:UILabel!
    @IBOutlet weak var authorDescriptionLabel:UILabel!
    @IBOutlet weak var trainingDurationLabel:UILabel!
    @IBOutlet weak var authorNameLabel:UILabel!
    @IBOutlet weak var trainingAuthorLabel:UILabel!
    
    var trainingObj:Training!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialState()
        // Do any additional setup after loading the view.
    }
    
    func setInitialState(){
        
        guard let trainingId = trainingObj.trainingId else{
            return
        }
        
        GetTrainingRequest(inTrainingId: trainingId).getTrainingDetail(
            { (trainingDictionary : [String:AnyObject]) in
                
                print("Get Training Response : \(trainingDictionary)")
                self.trainingObj.update(dict: trainingDictionary)
                self.updateView()
                
        },
            failure:
            {
                (error : Error?) in
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func updateView(){
        
        trainingDescriptionLabel.text = trainingObj.trainingDescription
        
        authorNameLabel.text = trainingObj.authorTitle
        authorDescriptionLabel.text = trainingObj.authorDescription
        trainingDurationLabel.text = "\(trainingObj.trainingMinutes!) min"
        
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
