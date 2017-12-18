//
//  ViewController.swift
//  EarthquakeTracker
//
//  Created by Saikat Dey on 06/07/17.
//  Copyright © 2017 DeysApp. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var recordsTableView: UITableView!
    
    typealias JSONDictionary = [String:Any]
    
    var networkObject = NetworkUtil()
    let dataModel = DataModel()
    var recordsDataArray = [ObjectModal]() //Records data Array
    var searchResults = [ObjectModal]()    //Search results Array

    var searchActive : Bool = false
    var placeNameArray :[String] = []
    var rowToSelect: IndexPath = []
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up activity indicator
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        activityIndicator.color = AppColor.activityIndicatorColor
        self.view.addSubview(activityIndicator)
        
        self.recordsTableView.delegate = self
        self.recordsTableView.dataSource = self
        self.searchBar.delegate = self
        
        self.recordsTableView.separatorColor = AppColor.separatorColor
        
        getEarthquakeData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*Fetch earthquake data from service*/
    func getEarthquakeData() {
        
        activityIndicator.startAnimating()

        dataModel.getResponseData{ (objectArray) in
            
            self.recordsDataArray = objectArray as! [ObjectModal]
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                
                self.recordsTableView.reloadData()
            }
        }
    }

    // MARK: - UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchActive) {
            return searchResults.count
        }
        if (self.recordsDataArray.count == 0) {
            return 0
        }else{
            return self.recordsDataArray.count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: RecordsTableViewCustomCell = self.recordsTableView.dequeueReusableCell(withIdentifier: "RecordsCustomCell") as! RecordsTableViewCustomCell
        cell.selectionStyle = UITableViewCellSelectionStyle.gray
        
        let object: ObjectModal
        if(searchActive && ((searchBar.text?.characters.count)! > 0)){
 
             object = self.searchResults[indexPath.row]      /*load searched data*/
        } else{
             object = self.recordsDataArray[indexPath.row]   /*load current data*/
        }
        cell.placeNameLbl.text = object.placeOfEarthquake
        cell.magnitudeLbl.text = object.magnitudeOfEarthquake
        cell.timeOfOccuranceLbl.text = object.timeOfEarthquake
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        //your code...
        rowToSelect = indexPath

        performSegue(withIdentifier: "detailViewSegue", sender: self)
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailViewSegue" {
            let nextScene = segue.destination as! DetailViewController
            let object: ObjectModal

            if let indexPath = self.recordsTableView.indexPathForSelectedRow {
                
                 object = self.recordsDataArray[indexPath.row]
            }
            else {
                 object = self.searchResults[rowToSelect.row]
            }
            
            nextScene.placeName = object.title
            nextScene.magnitude = object.magnitudeOfEarthquake
            nextScene.timeOfOccurance = object.timeOfEarthquake
            nextScene.lastUpdatedTime = object.lastUpdatedTime
            nextScene.coordinates = object.coordinates as! [Double]?
            nextScene.typeInfo = object.typesInfo
        }
    }
    
    
    /*----UIsearch Bar Delegate Methods----*/
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
        self.recordsTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchResults = self.recordsDataArray.filter({( object : ObjectModal) -> Bool in
            
            return (object.placeOfEarthquake?.lowercased().contains(searchText.lowercased()))!
        })
        
        if(self.searchResults.count == 0){
            searchActive = false;
            if((searchBar.text?.characters.count)! > 0){
                searchActive = true;
            }
        } else {
            searchActive = true;
        }
        self.recordsTableView.reloadData()

    }
    
}





