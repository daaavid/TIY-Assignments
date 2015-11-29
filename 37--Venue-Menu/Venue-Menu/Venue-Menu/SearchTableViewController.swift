//
//  SearchTableViewController.swift
//  Venue-Menu
//
//  Created by david on 11/26/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import QuartzCore

protocol LocationManagerDelegate
{
    func locationWasFound(location: Location)
}

protocol APIControllerProtocol
{
    func venuesWereFound(venues: [NSDictionary])
}

class SearchTableViewController: UITableViewController, LocationManagerDelegate, APIControllerProtocol, UISearchBarDelegate
{
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var searchResults = [Venue]()
    var location: Location!
    
    let locationManager = LocationManager()
    var apiController: APIController!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        locationManager.delegate = self
        locationManager.configureLocationManager()
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
    
    func venuesWereFound(venues: [NSDictionary])
    {
        print(venues.count)
        dispatch_async(dispatch_get_main_queue(), {
            
            for eachVenueDict in venues
            {
                if let venue = Venue.venueDictWithJSON(eachVenueDict)
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

        let venue: Venue = searchResults[indexPath.row]
        cell.venueLabel.text = venue.name
        cell.typeLabel.text = venue.type
        cell.addressLabel.text = venue.address
        
        let imageView = makeCellImage(venue.icon)
        cell.addSubview(imageView)
        
        return cell
    }
    
    func makeCellImage(iconURL: String) -> UIImageView
    {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 8, y: 8, width: 64, height: 64)
        imageView.downloadedFrom(link: iconURL, contentMode: .ScaleToFill)
        imageView.round()
        imageView.backgroundColor = UIColor(hue:0.625, saturation:0.8, brightness:0.886, alpha:1)
        
        return imageView
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let detailVC = storyboard?.instantiateViewControllerWithIdentifier("detailVC") as! DetailViewController
        let chosenVenue = searchResults[indexPath.row]
        detailVC.venue = chosenVenue
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
