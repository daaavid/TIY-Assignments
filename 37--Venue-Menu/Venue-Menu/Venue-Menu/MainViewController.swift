//
//  ViewController.swift
//  Venue-Menu
//
//  Created by david on 11/24/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

protocol FavoriteWasChosenProtocol
{
    func favoriteVenueWasChosen(favoriteVenue: Venue)
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FavoriteWasChosenProtocol
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButtonView: UIView!
    
    var favoriteVenues = [Venue]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        tableView.reloadData()
    }
    
    func favoriteVenueWasChosen(favoriteVenue: Venue)
    {
        favoriteVenues.append(favoriteVenue)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return favoriteVenues.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath) as! VenueCell
        
        let venue: Venue = favoriteVenues[indexPath.row]
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let detailVC = storyboard?.instantiateViewControllerWithIdentifier("detailVC") as! DetailViewController
        let chosenVenue = favoriteVenues[indexPath.row]
        detailVC.venue = chosenVenue
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

