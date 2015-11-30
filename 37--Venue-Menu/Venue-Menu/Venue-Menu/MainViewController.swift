//
//  ViewController.swift
//  Venue-Menu
//
//  Created by david on 11/24/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import CoreData

var USER_LOCATION: Location!

protocol FavoriteWasChosenProtocol
{
    func favoriteVenueWasChosen(favoriteVenue: NSManagedObject)
}

protocol LocationManagerDelegate
{
    func locationWasFound(location: Location)
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FavoriteWasChosenProtocol, LocationManagerDelegate
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButtonView: UIView!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var favoriteVenues = [NSManagedObject]()
    
    let locationManager = LocationManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let editButton = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "editButtonPressed:")
        self.navigationItem.leftBarButtonItem = editButton
        
        load()
        
        locationManager.delegate = self
        locationManager.configureLocationManager()
    }
    
    func locationWasFound(location: Location)
    {
        USER_LOCATION = location
        print("locationWasFound")
    }
    
    func load()
    {
        let request = NSFetchRequest(entityName: "Venue")
        do {
            if let venues = try managedObjectContext.executeFetchRequest(request) as? [Venue]
            {
                for venue in venues
                {
                    if (venue.valueForKey("favorite") as! Bool) == true
                    {
                        favoriteVenues.append(venue)
                    }
                    else
                    {
                        managedObjectContext.deleteObject(venue)
                    }
                }

                self.tableView.reloadData()
            }
        }
        catch {
            let error = error as NSError
            print(error.localizedDescription)
            abort()
        }
    }
    
    func favoriteVenueWasChosen(favoriteVenue: NSManagedObject)
    {
        managedObjectContext.insertObject(favoriteVenue)
        favoriteVenues.append(favoriteVenue)
        tableView.reloadData()
        print("favoriteVenueWasChosen")
        print(favoriteVenue, favoriteVenues.count)
        print(favoriteVenue.valueForKey("favorite"))
        
        saveContext()
    }
    
    @IBAction func searchButtonPressed(sender: UIButton)
    {
        searchButtonView.spin()
    }
    
    func editButtonPressed(sender: UIBarButtonItem)
    {
        if sender.title == "Edit"
        {
            sender.title = "Done"
            tableView.editing = true
        }
        else
        {
            sender.title = "Edit"
            tableView.editing = false
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return favoriteVenues.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FavoriteCell", forIndexPath: indexPath) as! VenueCell
        
        let venue = favoriteVenues[indexPath.row]
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
        imageView.downloadedFrom(link: iconURL, contentMode: .ScaleToFill)
        imageView.round()
        imageView.backgroundColor = UIColor(hue:0.625, saturation:0.8, brightness:0.886, alpha:1)
        
        return imageView
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let detailVC = storyboard?.instantiateViewControllerWithIdentifier("detailVC") as! DetailViewController
        let chosenVenue = favoriteVenues[indexPath.row]
        detailVC.venue = chosenVenue
        detailVC.location = USER_LOCATION
        detailVC.delegate = self
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete
        {
            let venue = favoriteVenues[indexPath.row]
            venue.setValue(false, forKey: "favorite")
            managedObjectContext.deleteObject(venue)
            
            favoriteVenues.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            saveContext()
        }
    }
    
    func saveContext()
    {
        do
        {
            try managedObjectContext.save()
        }
        catch
        {
            let error = error as NSError
            print(error.localizedDescription)
            abort()
        }
    }
}

