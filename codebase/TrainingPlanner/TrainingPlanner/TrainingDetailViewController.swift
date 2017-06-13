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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        trainingDescriptionLabel.text = "afjkas dsalkdlask dlaslaldklas kdlsa d"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
