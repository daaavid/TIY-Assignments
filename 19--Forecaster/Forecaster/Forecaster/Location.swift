//
//  Weather.swift
//  Forecaster
//
//  Created by david on 10/29/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation
let kCityKey = "city"
let kStateKey = "state"
//let kZipCodeKey = "zipCode"
let kLatKey = "lat"
let kLngKey = "lng"

class Location: NSObject, NSCoding
{
    let city: String
    let lat: String
    let lng: String
    let state: String
    
    var weather: Weather?
    
    var imgHasBeenAnimated = false
//    var weekHasBeenAnimated = false
    
    init(city: String, state: String, lat: String, lng: String, weather: Weather?)
    {
        self.city = city
        self.state = state
        self.lat = lat
        self.lng = lng
        
        if weather != nil
        {
            self.weather = weather!
        }
        else
        {
            self.weather = nil
        }
    }
    
    // MARK: - NSCoding
    
    required convenience init?(coder aDecoder: NSCoder)
    {
        guard
            let city = aDecoder.decodeObjectForKey(kCityKey) as? String,
            let state = aDecoder.decodeObjectForKey(kStateKey) as? String,
            let lat = aDecoder.decodeObjectForKey(kLatKey) as? String,
            let lng = aDecoder.decodeObjectForKey(kLngKey) as? String
        else
        {
            return nil
        }
        
        self.init(city: city, state: state, lat: lat, lng: lng, weather: nil)
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(self.city, forKey: kCityKey)
        aCoder.encodeObject(self.state, forKey: kStateKey)
        aCoder.encodeObject(self.lng, forKey: kLngKey)
        aCoder.encodeObject(self.lat, forKey:  kLatKey)
//        aCoder.encodeObject(self.zipCode)
//        aCoder.encodeDouble(<#T##realv: Double##Double#>, forKey: <#T##String#>)
    }
    
    static func locationWithJSON(results: NSArray) -> Location
    {
        var location: Location
        var city = ""
//        var stateZip = ""
        var state = ""
        var latStr = ""
        var lngStr = ""
        
        if results.count > 0
        {
            for result in results
            {
                let formattedAddress = result["formatted_address"] as? String
                if formattedAddress != nil
                {
                    let addressComponentsForCity = formattedAddress!.componentsSeparatedByString(",")
                    city = String(addressComponentsForCity[0])
                    
                    let stateZip = String(addressComponentsForCity[1])
                    state = stateZip.componentsSeparatedByString(" ")[1]
                }
                
                let geometry = result["geometry"] as? NSDictionary
                if geometry != nil
                {
                    let latLong = geometry?["location"] as? NSDictionary
                    if latLong != nil
                    {
                        let lat = latLong?["lat"] as! Double
                        let lng = latLong?["lng"] as! Double
                        
//                        let lat = latLong?.valueForKey("lat") as! Double
//                        let lng = latLong?.valueForKey("lng") as! Double
                        
                        latStr = String(lat)
                        lngStr = String(lng)
                    }
                }
            }
        }
        
        location = Location(city: city, state: state, lat: latStr, lng: lngStr, weather: nil)

        return location
    }
}
