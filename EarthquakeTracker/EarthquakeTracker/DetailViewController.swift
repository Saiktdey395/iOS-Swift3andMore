//
//  DetailViewController.swift
//  EarthquakeTracker
//
//  Created by Saikat Dey on 08/07/17.
//  Copyright © 2017 DeysApp. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var placeOfOccuranceLbl: UILabel!
    
    @IBOutlet weak var magnitudeOfEarthquakeLbl: UILabel!
    
    @IBOutlet weak var TimeOfOccuranceLbl: UILabel!
    
    @IBOutlet weak var lastUpdatedTimeLbl: UILabel!
    
    @IBOutlet weak var typesInfoLbl: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var placeName: String?
    var magnitude: String?
    var timeOfOccurance: String?
    var lastUpdatedTime: String?
    var typeInfo: String?
    var coordinates: [Double]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = Constants.detailScreenName
        
        let longitude = coordinates?[0]
        let latitude = coordinates?[1]
        
        displayDataOnUI()
        displayLocationInMap(long: longitude!, lat: latitude!)
    }
    
    /*Function to display details on screen*/
    func displayDataOnUI() {
        
        placeOfOccuranceLbl.text = placeName
        magnitudeOfEarthquakeLbl.text = magnitude
        TimeOfOccuranceLbl.text = timeOfOccurance
        lastUpdatedTimeLbl.text = lastUpdatedTime
        typesInfoLbl.text = typeInfo
    }
    
    /*Display earthquake Location on Map*/
    func displayLocationInMap(long: Double, lat: Double)  {

        let location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long
        )
        let span = MKCoordinateSpanMake(8.0, 8.0)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = placeName
        mapView.addAnnotation(annotation)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
