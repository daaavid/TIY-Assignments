//
//  Pins.swift
//  DudeWheresMyCar
//
//  Created by david on 11/3/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation
import CoreLocation

let kLatKey = "lat"
let kLngKey = "lng"
let knameKey = "name"

class Pin: NSObject, NSCoding
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
    
    required convenience init?(coder aDecoder: NSCoder)
    {
        guard
            let lat = aDecoder.decodeObjectForKey(kLatKey) as? Double,
            let lng = aDecoder.decodeObjectForKey(kLngKey) as? Double,
            let name = aDecoder.decodeObjectForKey(knameKey) as? String
        else { return nil }
        
        self.init(lat: lat, lng: lng, name: name)
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(self.lat, forKey: kLatKey)
        aCoder.encodeObject(self.lng, forKey:  kLngKey)
        aCoder.encodeObject(self.name, forKey:  knameKey)
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