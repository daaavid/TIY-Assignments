//
//  SearchTableViewController.swift
//  Venue-Menu
//
//  Created by david on 11/26/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import QuartzCore
import CoreData

protocol APIControllerProtocol
{
    func venuesWereFound(venues: [NSDictionary])
}

class SearchTableViewController: UITableViewController, APIControllerProtocol, UISearchBarDelegate
{
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var searchResults = [NSManagedObject]()
    var location: Location!
    
    let locationManager = LocationManager()
    var apiController: APIController!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        segmentedControl.hidden = true
        
        searchBar.delegate = self
        location = USER_LOCATION
        
//        locationManager.delegate = self
//        locationManager.configureLocationManager()
        apiController = APIController(delegate: self)
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return searchResults.count
    }
    
    func locationWasFound(location: Location)
    {
        self.location = location
    }
    
    @IBAction func segmentedControlValueChanged(sender: UISegmentedControl)
    {
        search()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        search()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
    }
    
    func search()
    {
        if let _ = location
        {
            print("searching")
            print(location)
            
            if let term = searchBar.text
            {
                switch segmentedControl.selectedSegmentIndex
                {
                case 0: apiController.search(term, location: location, searchOption: "explore")
                case 1: apiController.search(term, location: location, searchOption: "search")
                default: print("segmentedControl unknown segmentIndex")
                }
            }
            
            searchBar.resignFirstResponder()
        }
    }
    
    func venuesWereFound(venues: [NSDictionary])
    {
        print(venues.count)
        dispatch_async(dispatch_get_main_queue(), {
            
            for eachVenueDict in venues
            {
                if let venue = Venue.venueWithJSON(eachVenueDict)
                {
                    self.searchResults.append(venue)
                }
            }
            self.apiController.cancelSearch()
            self.tableView.reloadData()
        })
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath) as! VenueCell

        let venue = searchResults[indexPath.row]
        cell.venueLabel.text = venue.valueForKey("name") as? String
        cell.typeLabel.text = venue.valueForKey("type") as? String
        cell.addressLabel.text = venue.valueForKey("address") as? String
        
        if let imageURL = venue.valueForKey("icon") as? String
        {
            let imageView = makeCellImage(imageURL)
            cell.addSubview(imageView)
        }
        
        return cell
    }
    
    func makeCellImage(iconURL: String) -> UIImageView
    {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 8, y: 8, width: 64, height: 64)
        imageView.downloadedFrom(iconURL, contentMode: .ScaleToFill)
        imageView.round()
        imageView.backgroundColor = UIColor(hue:0.625, saturation:0.8, brightness:0.886, alpha:1)
        
        return imageView
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let mainVC = navigationController?.viewControllers[0] as! MainViewController
        let detailVC = storyboard?.instantiateViewControllerWithIdentifier("detailVC") as! DetailViewController
        let chosenVenue = searchResults[indexPath.row]
        detailVC.venue = chosenVenue
        detailVC.location = USER_LOCATION
        detailVC.delegate = mainVC
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
//    override func viewDidDisappear(animated: Bool)
//    {
//        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
//        for venue in searchResults
//        {
//            managedObjectContext.deleteObject(venue)
//        }
//    }
}
