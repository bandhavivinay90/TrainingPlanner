//
//  TrainingCollectionViewCell.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-05-23.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import UIKit
import UICircularProgressRing

class TrainingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var trainingTitleLabel:UILabel!
    @IBOutlet weak var holderView:UIView!
    @IBOutlet weak var courseImageView:UIImageView!
    @IBOutlet weak var circularProgressView:UICircularProgressRingView!
  //  @IBOutlet weak var trainingCollectionView:UICollectionView!
    override func layoutSubviews() {
        trainingTitleLabel.text = "Swift Basics"
        holderView.layer.borderColor = UIColor.gray.cgColor
        holderView.layer.borderWidth = 0.5
        holderView.layer.cornerRadius = 3.0
        circularProgressView.valueIndicator = ""
        courseImageView.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "compSc3.jpg")!)
    }
    
}
