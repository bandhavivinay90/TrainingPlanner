//
//  LoginViewModel.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-06-07.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import UIKit

class LoginViewModel: NSObject {
    
    init(inEmailId:String,inPassword:String,responseCallback:@escaping (User)->()){
        UserRequest(urlString: Constants.Network.loginUserURL,parameters:["email":inEmailId,"password":inPassword]).signIn(
            { (user:User) in
                print("In View Model \(user)")
                responseCallback(user)
        },
            failure:
            {
                (error : Error?) in
        })

    }
    
    init(inNewUser:User,inPassword:String,responseCallback:@escaping (User)->()){
        
        //Prepare the bost body ...
        let postDictionary = ["email":inNewUser.emailAddress,"password":inPassword,"fullName":inNewUser.fullName,"description":inNewUser.userDescription]
        
        
        UserRequest(urlString: Constants.Network.loginUserURL,parameters:postDictionary as! [String : String]).registerUser(
            { (user:User) in
                
                //New user created ...
                print("In View Model \(user)")
                responseCallback(user)
        },
            failure:
            {
                (error : Error?) in
        })
        
    }

    
}
