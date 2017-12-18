//
//  NetworkUtil.swift
//  SwiftTutorialComplete
//
//  Created by Saikat Dey on 09/05/17.
//  Copyright © 2017 DeysApp. All rights reserved.
//

import Foundation

class NetworkUtil{
    
    public func GetRequestFromServer(urlString: String, completionHandler: @escaping (AnyObject) ->())  {
        // Show MBProgressHUD Here
        var config                              :URLSessionConfiguration!
        var urlSession                          :URLSession!
        
        config = URLSessionConfiguration.default
        urlSession = URLSession(configuration: config)
        
        // MARK:- HeaderField
        let HTTPHeaderField_ContentType         = "Content-Type"
        
        // MARK:- ContentType
        let ContentType_ApplicationJson         = "application/json"
        
        //MARK: HTTPMethod
        let HTTPMethod_Get                      = "GET"
        
        let callURL =  URL.init(string: urlString)    //set URL here
        
        var request = URLRequest.init(url: callURL!)
        
        request.timeoutInterval = 10.0 // TimeoutInterval in Second
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.addValue(ContentType_ApplicationJson, forHTTPHeaderField: HTTPHeaderField_ContentType)
        request.httpMethod = HTTPMethod_Get
        
        let dataTask = urlSession.dataTask(with: request) { (data,response,error) in
            if error != nil{
                return
            }
            do {
                let resultJson = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]
                
                completionHandler (resultJson as AnyObject)
                
            } catch {
               
                completionHandler (error as AnyObject)

            }
        }
        
        dataTask.resume()
        
    }
    
    
}
