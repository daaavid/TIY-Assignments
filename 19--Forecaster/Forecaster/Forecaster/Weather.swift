//
//  Weather.swift
//  Forecaster
//
//  Created by david on 10/29/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation

class Weather
{
    let city: String
    let lat: String
    let lng: String
    
    init(city: String, lat: String, lng: String)
    {
        self.city = city
        self.lat = lat
        self.lng = lng
    }
    
    static func locationWithJSON(results: NSArray) -> [Weather]
    {
        var weatherArr = [Weather]()
        var city = ""
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
            
                weatherArr.append(Weather(city: city, lat: latStr, lng: lngStr))
            }
        }
        
        return weatherArr
    }
    
    static func weatherWithJSON()
    {
        
    }
}
