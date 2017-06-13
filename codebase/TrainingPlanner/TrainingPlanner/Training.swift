//
//  Training.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-06-09.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import UIKit

class Training: NSObject {
    
    var authorId: String?
    var trainingId: String!
    
    var trainingTitle: String!
    var trainingDescription: String?
    
    var authorTitle: String?
    var authorDescription: String?
    
    var category: String!
    var signedUpCount: Int!
    var trainingMinutes: Int?
    var isSuggested:Bool!
    var minSignUpCount:Int!
    
    init(dict: [String : AnyObject])
    {
        self.authorId = dict["authorId"] as? String
        self.trainingId = dict["trainingId"] as? String
        self.trainingTitle = dict["trainingTitle"] as? String
//        self.trainingDescription = dict["trainingDescription"] as? String
//        self.authorDescription = dict["description"] as? String
        self.authorTitle = dict["author"] as? String
        self.category = dict["category"] as? String
        self.signedUpCount = dict["signedUpCount"] as? Int
//        self.trainingMinutes = dict["trainingMinutes"] as? Int
        self.minSignUpCount = dict["minSignUpCount"] as? Int
        self.isSuggested = dict["isSuggested"] as? Bool
    }
    
    
}
