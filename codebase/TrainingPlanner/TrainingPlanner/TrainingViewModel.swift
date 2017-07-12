//
//  TrainingViewModel.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-06-12.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import UIKit

class TrainingViewModel: NSObject {

    init(responseCallback:@escaping ([Training])->()){
        
        //Adding the flag in View Model to tell the request object class builder about if authorization is needed or not, because the rules might change from the backend system and trainings list API can be made available without any authorization ...
        
        GetTrainingsRequest().getTrainings(
            { (trainings : [Training]) in
                
                //New user created ...
                print("In View Model \(trainings)")
                responseCallback(trainings)
        },
            failure:
            {
                (error : Error?) in
        })
        
    }

}
