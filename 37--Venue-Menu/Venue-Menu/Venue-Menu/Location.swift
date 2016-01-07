//
//  Location.swift
//  Venue-Menu
//
//  Created by david on 11/27/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation

struct Location
{
    let city: String
    let zip: String
    let lat: Double
    let lng: Double
    
    init(city: String, zip: String, lat: Double, lng: Double)
    {
        self.city = city
        self.zip = zip
        self.lat = lat
        self.lng = lng
    }
}