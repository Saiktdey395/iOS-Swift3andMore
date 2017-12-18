//
//  DataModel.swift
//  SwiftTutorialComplete
//
//  Created by Saikat Dey on 16/05/17.
//  Copyright © 2017 DeysApp. All rights reserved.
//

import Foundation


class DataModel{
    
    var networkObject = NetworkUtil()
    
    typealias JSONDictionary = [String:Any]
    
  /*Parse Json data and assign to Modal Objects*/
  func getResponseData(completionHandler: @escaping (AnyObject) ->()) {
    
        let url: String = APPURL.Domain
         networkObject.GetRequestFromServer(urlString: url) { (response) in
            
            var responseArray = [Any]()
            
            if let responseData = response as? JSONDictionary,
                
                let featuresArray = responseData["features"] as? [JSONDictionary]{
                
                for object in featuresArray {
      
                   // print(object)
                    
                    let modalObject = ObjectModal()
                    
                    if let geometry = object["geometry"] as? JSONDictionary{
                        
                        let coordinates = geometry["coordinates"] as Any
                        
                        modalObject.coordinates = coordinates
                    }
  
                    if let properties = object["properties"] as? JSONDictionary {
                       
                        let magnitude = properties["mag"] as! Float
                        
                        modalObject.magnitudeOfEarthquake = String(format:"%f", magnitude)
                    
                        let place = properties["place"] as! String
                        
                        modalObject.placeOfEarthquake = place
                        
                        let time = properties["time"] as! double_t
                        
                        modalObject.timeOfEarthquake = self.dateFromMilliseconds(ms: time)
                        
                        let updatedTime = properties["updated"] as! double_t
                        
                        modalObject.lastUpdatedTime = self.dateFromMilliseconds(ms: updatedTime)
                        
                        let types = properties["types"] as! String
                        
                        modalObject.typesInfo = types
                        
                        let title = properties["title"] as! String
                        
                        modalObject.title = title
                        
                    }
                    
                    responseArray.append(modalObject)
                }
            }
            
            completionHandler (responseArray as AnyObject)
        }
    }
    
    /*Datetime Formatter*/
    func dateFromMilliseconds(ms: double_t) -> String {
        let dateObj: NSDate = NSDate(timeIntervalSince1970:(ms) / 1000.0)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy hh:mm:ss"
        let dateString = dateFormatter.string(from:dateObj as Date)
        
        return dateString
    }
    
}
