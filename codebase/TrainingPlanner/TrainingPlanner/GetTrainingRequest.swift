//
//  GetTrainingRequest.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-06-14.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import Alamofire
import UIKit


class GetTrainingRequest: RequestBuilder {
    
    var request: DataRequest!

    var apiUrl: String = AlamofireManager.sharedInstance.apiURLString
    
    init(inTrainingId:String) {
        super.init()
        apiUrl += Constants.Network.getTrainingURL
        let parameters = ["trainingId":inTrainingId]
        
        request = sessionManager.request(apiUrl, parameters: parameters)
        
//        super.init(authorizationFlag: authorizationFlag,inURL: apiUrl,inParameters:parameters,requestType:.get)
    }
    
    func getTrainingDetail(_ success: @escaping ([String:AnyObject]) -> Void, failure: @escaping (Error?) -> Void) {
        
        print("GetTrainingsRequest: \(request.request!.url!.absoluteString)")
        
            let cachedResponse = URLCache.shared.cachedResponse(for: request.request!)
            let data = cachedResponse?.data
            if((data) != nil){

                let JSON = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                
                let trainingDetailDictionary = JSON as! [String : AnyObject]
                
                success(trainingDetailDictionary)

            }
            else{
                //Request for data from the backend ...
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
                                
                                let trainingDetailDictionary = JSON as! [String : AnyObject]
                                
                                success(trainingDetailDictionary)
                                
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

            }
        
        request.resume()
    }
    
    
}

