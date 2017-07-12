//
//  TrainingListViewController.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-05-22.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class TrainingListViewController: UIViewController {
    
    @IBOutlet weak var trainingTableView:UITableView!
    //    var trainingDataSource:[Training] = [Training](){
    //        didSet{
    //            self.reloadTableData()
    //        }
    //    }
    var trainingViewModel:TrainingViewModel?
    private var trainingTableViewDataSource:TrainingTableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        trainingTableView.isEditing = true
        // Do any additional setup after loading the view.
        setInitialState()
       // getTrainingsData()
        trainingTableView.allowsSelection = true
        
    }
    
    func setInitialState(){
        self.navigationItem.leftBarButtonItem = addLogoutButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTrainingsData(){
        
        trainingViewModel = TrainingViewModel(
            responseCallback: {
                (trainings : [Training]) in
                self.trainingTableViewDataSource = TrainingTableViewDataSource(inTableView: self.trainingTableView, inDataSource: trainings)
                
                //Define the callback here ...
                
                self.trainingTableViewDataSource?.selectedItemAtIndex(callback: {
                    inTrainingObject in
                    self.hidesBottomBarWhenPushed = true
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let trainingDetailsViewController = storyboard.instantiateViewController(withIdentifier:"TrainingDetail") as! TrainingDetailViewController
                    trainingDetailsViewController.trainingObj = inTrainingObject
                    self.navigationController?.pushViewController(trainingDetailsViewController, animated: true)
                })
        })
        
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
