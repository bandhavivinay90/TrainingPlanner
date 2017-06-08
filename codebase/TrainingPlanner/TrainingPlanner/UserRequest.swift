//
//  UserLoginRequest.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-06-07.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import Alamofire
import UIKit

class UserRequest: NSObject {
    
    var request: DataRequest
    var apiUrl: String = AlamofireManager.sharedInstance.apiURLString
    
    init(urlString:String,parameters:[String:String]) {
        apiUrl += urlString
        request = AlamofireManager.sharedInstance.request(apiUrl,method: .post,parameters: parameters,encoding: URLEncoding.httpBody)
    }
    
    
    func signIn(_ success: @escaping (User) -> Void, failure: @escaping (Error?) -> Void) {
        
        print("SignInRequest: \(request.request!.url!.absoluteString)")
        request.response
            {
                response in
                
                if response.error == nil
                {
                    let statusCode = response.response?.statusCode
                    
                    if(statusCode == 200){
                        let responseString = String(data: response.data!, encoding: String.Encoding.utf8)
                        print("SignInResponse: \(responseString!)")
                        let JSON = try? JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments)
                        let userDictionary = JSON as! [String : AnyObject]
                        print(userDictionary)
                        let user:User = User(dict: userDictionary)
                        success(user)
                    }
                    else{
                        print(response)
//                        let responseString = String(data: response.data!, encoding: String.Encoding.utf8)
//                        print(responseString)
                    }
                    

//                    let appArray = root["apps"] as! [[String : AnyObject]]
//                    var apps = [User]()
//                    for item in appArray
//                    {
//                        apps.append(User(dict: item))
//                    }
                    
                }
                else
                {
                    print(response.error!)
                    failure(response.error!)
                }
        }
        request.resume()
    }
    
    
    func registerUser(_ success: @escaping (User) -> Void, failure: @escaping (Error?) -> Void) {
        
        print("SignInRequest: \(request.request!.url!.absoluteString)")
        request.response
            {
                response in
                
                if response.error == nil
                {
                    let statusCode = response.response?.statusCode
                    
                    if(statusCode == 200){
                        let responseString = String(data: response.data!, encoding: String.Encoding.utf8)
                        print("SignInResponse: \(responseString!)")
                        let JSON = try? JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments)
                        let userDictionary = JSON as! [String : AnyObject]
                        print(userDictionary)
                        let user:User = User(dict: userDictionary)
                        success(user)
                    }
                    else{
                        print(response)
                        //                        let responseString = String(data: response.data!, encoding: String.Encoding.utf8)
                        //                        print(responseString)
                    }
                    
                    
                    //                    let appArray = root["apps"] as! [[String : AnyObject]]
                    //                    var apps = [User]()
                    //                    for item in appArray
                    //                    {
                    //                        apps.append(User(dict: item))
                    //                    }
                    
                }
                else
                {
                    print(response.error!)
                    failure(response.error!)
                }
        }
        request.resume()
    }


}
