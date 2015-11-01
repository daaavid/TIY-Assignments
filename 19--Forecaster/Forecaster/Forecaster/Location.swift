//
//  Weather.swift
//  Forecaster
//
//  Created by david on 10/29/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation

class Location
{
    let city: String
    let lat: String
    let lng: String
    let state: String
    
    var weather: Weather?
    
    var imgHasBeenAnimated = false
    var weekHasBeenAnimated = false
    
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
    
    static func locationWithJSON(results: NSArray) -> Location
    {
//        var weatherArr = [Weather]()
        
        var location: Location
        var city = ""
        var stateZip = ""
        var state = ""
        var latStr = ""
        var lngStr = ""
        
        if results.count > 0
        {
            for result in results
            {
                let formattedAdress = result["formatted_address"] as? String
                if formattedAdress != nil
                {
                    var addressComponentsForCity = formattedAdress!.componentsSeparatedByString(",")
                    city = String(addressComponentsForCity[0])
                    stateZip = String(addressComponentsForCity[1])
                    print(stateZip)
                    state = stateZip.componentsSeparatedByString(" ")[1]
                    print(state)
                }
                
                let geometry = result["geometry"] as? NSDictionary
                if geometry != nil
                {
                    let latLong = geometry?["location"] as? NSDictionary
                    if latLong != nil
                    {
                        let lat = latLong?.valueForKey("lat") as! Double
                        let lng = latLong?.valueForKey("lng") as! Double
                        
                        latStr = String(lat)
                        lngStr = String(lng)
                    }
                }
            
//                weatherArr.append(Weather(city: city, lat: latStr, lng: lngStr))
            }
        }
        location = Location(city: city, state: state, lat: latStr, lng: lngStr, weather: nil)

//        return weatherArr
        return location
    }
    
    static func weatherWithJSON()
    {
        
    }
}
