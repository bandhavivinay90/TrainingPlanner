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
    var suggestedById: String?
    
    var trainingTitle: String!
    var trainingDescription: String?
    
    var suggestedByTitle: String?
    var suggestedByIdDescription: String?
    
    var authorTitle: String?
    var authorDescription: String?
    
    var trainingCategory: String!
    var signedUpCount: Int!
    var trainingMinutes: Int?
    var isSuggested:Bool!
    var minSignUpCount:Int!
    
    override init(){
        
    }
    
    init(dict: [String : AnyObject])
    {
        self.authorId = dict["authorId"] as? String
        self.trainingId = dict["trainingId"] as? String
        self.trainingTitle = dict["trainingTitle"] as? String
        self.authorTitle = dict["author"] as? String
        self.trainingCategory = dict["trainingCategory"] as? String
        self.signedUpCount = dict["signedUpCount"] as? Int
        self.minSignUpCount = dict["minSignUpCount"] as? Int
        self.suggestedByTitle = dict["suggestedBy"] as? String
        self.isSuggested = dict["isSuggested"] as? Bool
    }
    
    func update(dict:[String : AnyObject]){
        self.trainingDescription = dict["description"] as? String
        self.authorDescription = dict["authorDesc"] as? String
        self.trainingMinutes = dict["trainingMinutes"] as? Int
        
        self.suggestedByTitle = dict["suggestedByTitle"] as? String
        self.suggestedByIdDescription = dict["suggestedByDescription"] as? String
        
    }
    
    
    func toDictionary() -> [String:String]{
        
        var trainingDict = [String : String]()

        trainingDict["trainingTitle"] = self.trainingTitle
        trainingDict["trainingCategory"] = self.trainingCategory
        trainingDict["minSignUpCount"] = String(self.minSignUpCount)
        trainingDict["description"] = self.trainingDescription
        
        return trainingDict
        
    }
    
}
