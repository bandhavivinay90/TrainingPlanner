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

    private var selectedCallback:((Training)->())?
    
    
    init(inTableView: UITableView,inDataSource:[Training]) {
        super.init()
        inTableView.dataSource = self
        inTableView.delegate = self
        trainingDataSource = inDataSource
        inTableView.reloadData()
    }
    
    func selectedItemAtIndex(callback:@escaping (Training) -> ()) {
        selectedCallback = callback
    }
    
    func configureCell(inTrainingViewCell:TrainingTableViewCell,inTrainingObj:Training){
        
        inTrainingViewCell.trainingTitleLabel.text = inTrainingObj.trainingTitle
        if(inTrainingObj.isSuggested){
            inTrainingViewCell.trainingAuthorLabel.text = "By : "+inTrainingObj.authorTitle!
        }
        else{
            inTrainingViewCell.trainingAuthorLabel.text = "By : To Be Decided"
        }
        
        let upvotesNeeded = inTrainingObj.minSignUpCount - inTrainingObj.signedUpCount
        
        inTrainingViewCell.trainingUpvotesNeedCountLabel.text = "\(upvotesNeeded) more to go"
        
        let multiplier:Float = (Float)(inTrainingObj.signedUpCount)/(Float)(inTrainingObj.minSignUpCount)
        
        inTrainingViewCell.circularProgressView.value = CGFloat(multiplier*100)
        inTrainingViewCell.circularProgressView.valueIndicator = "%"
        inTrainingViewCell.courseImageView.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "compSc3.jpg")!)
        
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
                
        if let callback = selectedCallback {
            callback(trainingDataSource[indexPath.row])
        }
        
    }
    
}
