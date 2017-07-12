//
//  NewTraining.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-06-15.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import Alamofire
import UIKit


class NewTrainingRequest: RequestBuilder {
    
    var request: DataRequest!

    var apiUrl: String = AlamofireManager.sharedInstance.apiURLString
    
    init(inTrainingDict:[String:String]) {
        super.init()
        apiUrl += Constants.Network.newTrainingURL
        print(inTrainingDict)
//        let parameters = ["trainingTitle":"abcdefgh"]
            request = sessionManager?.request(apiUrl, method: .post, parameters: inTrainingDict, encoding:JSONEncoding.prettyPrinted)
        }
    
    func createTraining(_ success: @escaping (String) -> Void, failure: @escaping (Error?) -> Void) {
        
        print("CreateTrainingsRequest: \(request.request!.url!.absoluteString)")

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
                            success(responseString!)
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
