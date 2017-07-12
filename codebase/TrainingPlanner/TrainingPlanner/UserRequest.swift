//
//  UserLoginRequest.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-06-07.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import Alamofire
import UIKit
import SwiftKeychainWrapper

class UserRequest: NSObject {
    
    var request: DataRequest
    var apiUrl: String = AlamofireManager.sharedInstance.apiURLString
    
    init(parameters:[String:String]) {
        apiUrl += Constants.Network.loginUserURL
        print(parameters)
        request = AlamofireManager.sharedInstance.request(apiUrl,method: .post,parameters: parameters,encoding: URLEncoding.httpBody)
    }
    
    override init(){
        apiUrl += Constants.Network.logoutUserURL
        request = AlamofireManager.sharedInstance.request(apiUrl)
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
                        let user:User = User(dict: userDictionary["user"] as! [String : AnyObject])
                        let accessTokenString:String = userDictionary["accessToken"] as! String
                        let refreshTokenString:String = userDictionary["refreshToken"] as! String
                        //Save the access token and refresh token ...
                        KeychainWrapper.standard.set(accessTokenString, forKey: "accessToken")
                        KeychainWrapper.standard.set(refreshTokenString, forKey: "refreshToken")
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
    
    func signOut(_ success: @escaping () -> Void, failure: @escaping (Error?) -> Void){
        
        request.response{
            response in
            
            if response.error == nil
            {
                let statusCode = response.response?.statusCode
                
                if(statusCode == 200){
                    success()
                }
                else{
                    print(response)
                    //                        let responseString = String(data: response.data!, encoding: String.Encoding.utf8)
                    //                        print(responseString)
                }
                
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
