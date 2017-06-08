//
//  AlamofireManager.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-06-07.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import Alamofire

class AlamofireManager
{
    static let sharedInstance = AlamofireManager()
    let apiURLString = Constants.Network.baseURL
    private let alamofireManager = Alamofire.SessionManager.default
    
    private init()
    {
        alamofireManager.startRequestsImmediately = false
    }
    
    func request(_ url: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil) -> DataRequest
    {
        return alamofireManager.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
    
    func cancelAllRequests()
    {
        alamofireManager.session.getTasksWithCompletionHandler
            {
                dataTasks, uploadTasks, downloadTasks in
                for task in dataTasks
                {
                    task.cancel()
                }
        }
    }
    
    func cancelAllRequestsWithUrlPart(_ urlPartString: String)
    {
        alamofireManager.session.getTasksWithCompletionHandler
            {
                dataTasks, uploadTasks, downloadTasks in
                for task in dataTasks
                {
                    if task.originalRequest!.url!.absoluteString.contains(urlPartString) { task.cancel() }
                }
        }
    }
}
