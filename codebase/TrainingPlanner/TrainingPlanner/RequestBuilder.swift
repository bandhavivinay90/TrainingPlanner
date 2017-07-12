//
//  RequestBuilder.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-06-14.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import SwiftKeychainWrapper
import Foundation
import Alamofire

class RequestBuilder: RequestAdapter {
    
    var sessionManager:SessionManager!
    
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        let accessTokenString:String = KeychainWrapper.standard.string(forKey: "accessToken")!

        urlRequest.setValue("Bearer " + accessTokenString, forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("public, max-age=300, s-maxage=600", forHTTPHeaderField: "Cache-Control")
        
        return urlRequest
    }
    
    
    init(){
        
        sessionManager = SessionManager()
        sessionManager.adapter = self
        
    }
    
  
    
//    init(authorizationFlag:Bool,inURL:String){
//        
//        if (authorizationFlag){
//            
//            request = AlamofireManager.sharedInstance.request(inURL,headers:RequestBuilder.makeAuthorizationHeader())
//        }
//        else{
//            request = AlamofireManager.sharedInstance.request(inURL)
//        }
//        
//    }
//    
//    init(authorizationFlag:Bool,inURL:String,inParameters:[String:String],requestType:HTTPMethod){
//        
//        var headers = [String:String]()
//        if(authorizationFlag){
//            headers = RequestBuilder.makeAuthorizationHeader()
//        }
//        
//        if (requestType == .get){
//            request = AlamofireManager.sharedInstance.request(inURL,parameters:inParameters,headers:headers)
//        }
//        else{
//            request = AlamofireManager.sharedInstance.request(inURL,method:.post,parameters:inParameters,encoding: URLEncoding.httpBody)
//        }
    
//    }
    
}
