//
//  GetTrainingsRequest.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-06-09.
//  Copyright © 2017 Sogeti. All rights reserved.
//


import Alamofire
import UIKit
import SwiftKeychainWrapper

class GetTrainingsRequest: RequestBuilder {
    
    var apiUrl: String = AlamofireManager.sharedInstance.apiURLString
    
    init(authorizationFlag:Bool) {
        
        apiUrl += Constants.Network.getTrainingsURL
        
        super.init(authorizationFlag: authorizationFlag,inURL: apiUrl)

    }
    
    func getTrainings(_ success: @escaping ([Training]) -> Void, failure: @escaping (Error?) -> Void) {
        
        print("GetTrainingsRequest: \(request.request!.url!.absoluteString)")
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
                        
//                        let root = JSON as! [String : AnyObject]
                        let appArray = JSON as! [[String : AnyObject]]
                        var apps = [Training]()
                        for item in appArray
                        {
                            apps.append(Training(dict: item))
                        }
                        success(apps)
                        
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
