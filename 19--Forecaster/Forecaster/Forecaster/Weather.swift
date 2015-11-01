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
    let temp: Int
    let apparentTemp: Int
    
    let summary: String
    var icon: String
    
    let precipProbability: Double
//    let precipType: String
    let precipIntensity: Double
    
    let windSpeed: Double
    
    let humidity: Double
    let visibility: Double
    let cloudCover: Double
    
    init(summary: String, icon: String, precipIntensity: Double, precipProbability: Double, temperature: Int, apparentTemp: Int, humidity: Double, windSpeed: Double, visibility: Double, cloudCover: Double)
    {
        self.summary = summary
        self.icon = icon
        self.precipIntensity = precipIntensity
        self.precipProbability = precipProbability
        self.temp = temperature
        self.apparentTemp = apparentTemp
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.visibility = visibility
        self.cloudCover = cloudCover
    }
    
    static func weatherWithJSON(results: NSDictionary) -> Weather
    {
        var weather = Weather?()
        
        if let currently = results["currently"] as? NSDictionary
        {
//            var weather = Weather?()
            var visibility = 0.0
            
            let summary = currently["summary"] as! String
            let icon = currently["icon"] as! String
            let precipIntensity = currently["precipIntensity"] as!Double
            let precipProbability = currently["precipProbability"] as! Double
            //        let humidity = currently["humidity"] as! Double
            let humidity = currently["dewPoint"] as! Double
            let windSpeed = currently["windSpeed"] as! Double
            if let _ = currently["visibility"]
            {
                visibility = currently["visibility"] as! Double
                //some locations don't have visibility in the darksky api
            }
            let cloudCover = currently["cloudCover"] as! Double
            
            let apparentTemp = currently["apparentTemperature"] as! Double
            var a = String(apparentTemp).componentsSeparatedByString(".")
            var b = Double(a[0])
            if Double(a[1]) > 50
            {
                b! += 1
            }
            let apparentTemperature = Int(b!)
            
            let temp = currently["temperature"] as! Double
            var x = String(temp).componentsSeparatedByString(".")
            var y = Double(x[0])
            if Double(x[1]) > 50
            {
                y! += 1
            }
            let temperature = Int(y!)
            
            weather = Weather(summary: summary, icon: icon, precipIntensity: precipIntensity, precipProbability: precipProbability, temperature: temperature, apparentTemp: apparentTemperature, humidity: humidity, windSpeed: windSpeed, visibility: visibility, cloudCover: cloudCover)
        }
        
        if let daily = results["daily"] as? NSDictionary
        {
            
        }


        

        return weather!

    }
}

