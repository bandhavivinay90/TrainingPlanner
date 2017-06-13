//
//  TrainingTableViewDataSource.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-06-12.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import UIKit

class TrainingTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var trainingDataSource:[Training] = [Training]()
    let reuseIdentifier = "TrainingCell"

//    private var selectedCallback = ((NSIndexPath)->Void)?()
//    
//    func selectedItemAtIndex(callback:(NSIndexPath) -> Void) {
//        selectedCallback = callback
//    }
    
    init(inTableView: UITableView,inDataSource:[Training]) {
        super.init()
        inTableView.dataSource = self
        inTableView.delegate = self
        trainingDataSource = inDataSource
        inTableView.reloadData()
    }
    
    func configureCell(inTrainingViewCell:TrainingTableViewCell,inTrainingObj:Training){
        
        inTrainingViewCell.trainingTitleLabel.text = inTrainingObj.trainingTitle
        if(inTrainingObj.isSuggested){
            inTrainingViewCell.trainingAuthorLabel.text = "By : "+inTrainingObj.authorTitle!
        }
        else{
            inTrainingViewCell.trainingAuthorLabel.text = "By : To Be Decided"
        }
        inTrainingViewCell.trainingUpvotesNeedCountLabel.text = "\(inTrainingObj.minSignUpCount - inTrainingObj.signedUpCount) more to go"
    }
    
    //MARK: UITableView Datasource & Delegates
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainingDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TrainingTableViewCell
        let trainingObject = trainingDataSource[indexPath.row]
        self.configureCell(inTrainingViewCell: cell, inTrainingObj: trainingObject)
        return cell
    
    }
    
    //    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    //        if editingStyle == .delete {
    //
    //        }
    //    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        self.hidesBottomBarWhenPushed = true
//        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        
//        let trainingDetailsViewController = storyboard.instantiateViewController(withIdentifier:"TrainingDetail") as! TrainingDetailViewController
//        self.navigationController?.pushViewController(trainingDetailsViewController, animated: true)
        
        
    }
    
}
