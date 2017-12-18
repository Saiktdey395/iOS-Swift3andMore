//
//  Constants.swift
//  SwiftTutorialComplete
//
//  Created by Saikat Dey on 09/05/17.
//  Copyright © 2017 DeysApp. All rights reserved.
//

import Foundation
import UIKit


struct APPURL {
    
    //declare domain urls
    private struct Domains {        
        static let DEV = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2014-01-01&endtime=2014-01-02"
    }
    
    private struct Routes {
        static let Api = "/api/mobile"
    }
    
    public static let Domain = Domains.DEV
    
}

//ColorConstants.swift
struct AppColor {
    
    public static let separatorColor =  UIColor.green
    public static let activityIndicatorColor =  UIColor.green
    
}

//FontsConstants.swift- for fonts file
struct FontNames {
    
    static let LatoName = "Lato"
    struct Lato {
        static let LatoBold = "Lato-Bold"
        static let LatoMedium = "Lato-Medium"
        static let LatoRegular = "Lato-Regular"
        static let LatoExtraBold = "Lato-ExtraBold"
    }
}

//KeyConstants.swift
struct Constants {
    
   static let detailScreenName = "Details"
}
