//
//  User.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-06-07.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var userId: String?
    var fullName: String?
    var emailAddress: String?
    var imageUrl: String?
    var userDescription: String?
    
    init(dict: [String : AnyObject])
    {
        self.userId = dict["uid"] as? String
        self.fullName = dict["fullName"] as? String
        self.emailAddress = dict["emailID"] as? String
       // self.imageUrl = (dict["photoURL"] as? String?)!
        self.userDescription = dict["description"] as? String
    }
    
    override init(){
        //super.init()
    }
    
}
