//
//  DetailViewController.swift
//  Venue-Menu
//
//  Created by david on 11/26/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{
    var venue: Venue?
    var delegate: FavoriteWasChosenProtocol?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let _ = venue
        {
            print(venue)
        }
    }
    
    @IBAction func favoriteButtonTapped(sender: UIButton)
    {
        if let _ = venue
        {
            delegate?.favoriteVenueWasChosen(self.venue!)
        }
    }
}
