//
//  DetailViewController.swift
//  Venue-Menu
//
//  Created by david on 11/26/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class DetailViewController: UIViewController
{
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var venue: NSManagedObject?
    var location: Location!
    var delegate: FavoriteWasChosenProtocol?
    
    let heartImg = UIImage(named: "heart.png")
    let filledHeartImg = UIImage(named: "filledheart.png")
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        print(delegate)
        
        if let _ = venue
        {
            print(venue)
            
            nameLabel.text = venue!.valueForKey("name") as? String
            typeLabel.text = venue!.valueForKey("type") as? String
            addressLabel.text = venue!.valueForKey("address") as? String
            phoneLabel.text = venue!.valueForKey("phone") as? String
            
            if (venue!.valueForKey("favorite") as! Bool) == true
            {
                favoriteButton.setImage(heartImg, forState: .Normal)
            }
            
            showPins()
        }
    }
    
    func showPins()
    {
        let venuePin = MKPointAnnotation()
        if let venueLat = venue!.valueForKey("lat") as? Double
        {
            if let venueLng = venue!.valueForKey("lng") as? Double
            {
                venuePin.coordinate = CLLocationCoordinate2DMake(venueLat, venueLng)
                mapView.addAnnotation(venuePin)
            }
        }
        
        let selfPin = MKPointAnnotation()
        selfPin.coordinate = CLLocationCoordinate2DMake(location.lat, location.lng)
        
        mapView.addAnnotation(selfPin)
        mapView.showAnnotations([venuePin, selfPin], animated: true)
    }
    
    @IBAction func favoriteButtonPressed(sender: UIButton)
    {
        favoriteButton.spin()
        
        if (venue!.valueForKey("favorite") as! Bool) == true
        {
            venue?.setValue(false, forKey: "favorite")
            favoriteButton.setImage(heartImg, forState: .Normal)
        }
        else
        {
            venue?.setValue(true, forKey: "favorite")
            favoriteButton.setImage(filledHeartImg, forState: .Normal)
            delegate?.favoriteVenueWasChosen(venue!)
        }
    }
}
