//
//  iTunesModel.swift
//  SwiftTutorialComplete
//
//  Created by Saikat Dey on 10/05/17.
//  Copyright © 2017 DeysApp. All rights reserved.
//

import Foundation
import UIKit

class ObjectModal {
    
    var magnitudeOfEarthquake: String?
    var placeOfEarthquake: String?
    var title: String?
    var timeOfEarthquake: String?
    var lastUpdatedTime: String?
    var code: String?
    var typesInfo: String?
    var coordinates: Any?
    
    
    func JSON(magnitudeOfEarthquake: String?, placeOfEarthquake: String, title: String?, timeOfEarthquake: String?,lastUpdatedTime: String?, code: String, typesInfo: String?, coordinates: Any?) {
        
        self.magnitudeOfEarthquake = magnitudeOfEarthquake
        self.placeOfEarthquake = placeOfEarthquake
        self.title = title
        self.timeOfEarthquake = timeOfEarthquake
        self.lastUpdatedTime = lastUpdatedTime
        self.code = code
        self.typesInfo = typesInfo
        self.coordinates = coordinates
    }
    
}
