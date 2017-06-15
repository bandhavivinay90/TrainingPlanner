//
//  TrainingTableViewCell.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-05-23.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import UIKit
import UICircularProgressRing


class TrainingTableViewCell: UITableViewCell {

    @IBOutlet weak var trainingTitleLabel:UILabel!
    @IBOutlet weak var trainingAuthorLabel:UILabel!
    @IBOutlet weak var trainingUpvotesNeedCountLabel:UILabel!
//    @IBOutlet weak var holderView:UIView!
    @IBOutlet weak var courseImageView:UIImageView!
    @IBOutlet weak var circularProgressView:UICircularProgressRingView!
    //  @IBOutlet weak var trainingCollectionView:UICollectionView!
   
    override func layoutSubviews() {
//        circularProgressView.valueIndicator = "\()"
//        courseImageView.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "compSc3.jpg")!)
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        trainingTitleLabel.text = "Swift Basics"
//        holderView.layer.borderColor = UIColor.gray.cgColor
//        holderView.layer.borderWidth = 0.5
//        holderView.layer.cornerRadius = 3.0
        circularProgressView.font = UIFont.systemFont(ofSize: 12.0)
//        courseImageView.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "compSc3.jpg")!)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
