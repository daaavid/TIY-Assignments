//
//  Pins.swift
//  DudeWheresMyCar
//
//  Created by david on 11/3/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation
import CoreLocation

class Pin
{
    let lat: Double
    let lng: Double
    let name: String
    
    init(lat: Double, lng: Double, name: String)
    {
        self.lat = lat
        self.lng = lng
        self.name = name
    }
    
    static func setValues(location: CLLocationCoordinate2D, name: String) -> Pin
    {
        var pin: Pin
        
        let lat = location.latitude
        let lng = location.longitude
        let name = name
        
        pin = Pin(lat: lat, lng: lng, name: name)
        return pin
    }
}