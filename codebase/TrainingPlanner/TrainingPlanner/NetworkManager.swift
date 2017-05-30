//
//  NetworkManager.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-05-29.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias ServerResponse = (_ data:Data?,_ response:URLResponse?,_ error:NSError?) -> Void
var sessionObject:URLSession!

enum JSONError: String, Error {
    case NoData = "ERROR: no data"
    case ConversionFailed = "ERROR: conversion from JSON failed"
}

class NetworkManager{
    static let sharedNetworkManager = NetworkManager()
    var reachability: Reachability?
    
//    func hasConnectivity() -> Bool {
//        do {
//            reachability = try Reachability.reachabilityForInternetConnection()
//        } catch {
//            print("Unable to create Reachability")
//        }
//        let networkStatus: Int = (reachability?.currentReachabilityStatus.hashValue)!
//        return networkStatus != 0
//    }
    
    func  makeGetRequest(_ path:String){
        
//        if self.hasConnectivity(){
        
            let urlString:NSString! = "https://us-central1-trainingplanner-691cc.cloudfunctions.net/getTrainings"
            if((sessionObject == nil)){
                let sessionConfig:URLSessionConfiguration = URLSessionConfiguration.default
                sessionConfig.timeoutIntervalForRequest = 40
                sessionObject = URLSession(configuration: sessionConfig)
            }
            let url : URL = URL(string: urlString as String)!
            let request = NSMutableURLRequest(url: url as URL)
        
            request.addValue("Bearer \(path)", forHTTPHeaderField: "Authorization")

        
        let task = sessionObject.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print(data)
            }
        }
        task.resume()
        
        
        
        
//            let task = sessionObject.dataTask(with: request, completionHandler: {(inData,inResponse,inError)  in
//                responseCallBack(inData,inResponse,inError)
////                Utilities.hideLoadingIndicator()
//            });
//            task.resume()
//        }
//        else{
//            print("Please check your Internet Connection")
//            Utilities.hideLoadingIndicator()
//        }
    }
    
    func  makePostRequest(_ path:String){
        
        //        if self.hasConnectivity(){
        let dict = ["email": "bandhavi.vinay@sogeti.se", "password":"123456"] as [String: Any]
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {

        let urlString:NSString! = "https://us-central1-trainingplanner-691cc.cloudfunctions.net/signIn"
            let url:NSURL = NSURL(string: urlString as String)!
            
            let request = NSMutableURLRequest(url: url as URL)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
        if((sessionObject == nil)){
            let sessionConfig:URLSessionConfiguration = URLSessionConfiguration.default
            sessionConfig.timeoutIntervalForRequest = 40
            sessionObject = URLSession(configuration: sessionConfig)
        }
        
        let task = sessionObject.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    guard let data = data else {
                        throw JSONError.NoData
                    }
                    guard let json:NSDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                        throw JSONError.ConversionFailed
                    }
                  //  let firebaseUser:
                    let dictFromJSON = json as? [String:Any]
                    let dictionary:NSDictionary? = dictFromJSON!["stsTokenManager"] as? NSDictionary
                    
                    let accessToken:String = dictionary?["accessToken"] as! String
                    
                    //call getTrainings ...
                    self.makeGetRequest(accessToken)
                    
                } catch let error as JSONError {
                    print(error.rawValue)
                } catch let error as NSError {
                    print(error.debugDescription)
                }
            }
        }
        task.resume()
    }
    }
    
}
