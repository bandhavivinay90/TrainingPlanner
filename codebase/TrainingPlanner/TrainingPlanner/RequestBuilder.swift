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

class RequestBuilder: NSObject {
    
    var request: DataRequest!
    
    private class func makeAuthorizationHeader() -> [String:String]{
        //Make Header Dictionary :
        let accessTokenString:String = KeychainWrapper.standard.string(forKey: "accessToken")!
        
        let headers = [
            "Authorization": "Bearer \(accessTokenString)",
            "Content-Type": "application/json"
//            "Cache-Control": "public, max-age=300, s-maxage=600"
        ]
        return headers
    }
    
    init(authorizationFlag:Bool,inURL:String){
        
        if (authorizationFlag){
            
            request = AlamofireManager.sharedInstance.request(inURL,headers:RequestBuilder.makeAuthorizationHeader())
        }
        else{
            request = AlamofireManager.sharedInstance.request(inURL)
        }
        
    }
    
    init(authorizationFlag:Bool,inURL:String,inParameters:[String:Any]){
        
        if (authorizationFlag){
            request = AlamofireManager.sharedInstance.request(inURL,parameters:inParameters,headers:RequestBuilder.makeAuthorizationHeader())
        }
        else{
            request = AlamofireManager.sharedInstance.request(inURL,parameters:inParameters)
        }
        
    }
    
}
