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
    let precipIntensity: Double
    
    let windSpeed: Double
    
    let humidity: Double
    let visibility: Double
    let cloudCover: Double
    
    let weeksummary: String
    
    let day0summary: String
    let day1summary: String
    let day2summary: String
    let day3summary: String
    let day4summary: String
    let day5summary: String
    let day6summary: String
    
    let day0icon: String
    let day1icon: String
    let day2icon: String
    let day3icon: String
    let day4icon: String
    let day5icon: String
    let day6icon: String
    
    let day0tempMin: Int
    let day1tempMin: Int
    let day2tempMin: Int
    let day3tempMin: Int
    let day4tempMin: Int
    let day5tempMin: Int
    let day6tempMin: Int
    
    let day0tempMax: Int
    let day1tempMax: Int
    let day2tempMax: Int
    let day3tempMax: Int
    let day4tempMax: Int
    let day5tempMax: Int
    let day6tempMax: Int
    
    init(
        summary: String,
        icon: String,
        precipIntensity: Double,
        precipProbability: Double,
        temperature: Int,
        apparentTemp: Int,
        humidity: Double,
        windSpeed: Double,
        visibility: Double,
        cloudCover: Double,
        
        weeksummary: String,
            
        day0summary: String,
        day1summary: String,
        day2summary: String,
        day3summary: String,
        day4summary: String,
        day5summary: String,
        day6summary: String,
            
        day0icon: String,
        day1icon: String,
        day2icon: String,
        day3icon: String,
        day4icon: String,
        day5icon: String,
        day6icon: String,
            
        day0tempMin: Int,
        day1tempMin: Int,
        day2tempMin: Int,
        day3tempMin: Int,
        day4tempMin: Int,
        day5tempMin: Int,
        day6tempMin: Int,
            
        day0tempMax: Int,
        day1tempMax: Int,
        day2tempMax: Int,
        day3tempMax: Int,
        day4tempMax: Int,
        day5tempMax: Int,
        day6tempMax: Int
        )
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
        
        self.weeksummary = weeksummary
        
        self.day0summary = day0summary
        self.day0icon = day0icon
        self.day0tempMin = day0tempMin
        self.day0tempMax = day0tempMax
        
        self.day1summary = day1summary
        self.day1icon = day1icon
        self.day1tempMin = day1tempMin
        self.day1tempMax = day1tempMax
        
        self.day2summary = day2summary
        self.day2icon = day2icon
        self.day2tempMin = day2tempMin
        self.day2tempMax = day2tempMax
        
        self.day3summary = day3summary
        self.day3icon = day3icon
        self.day3tempMin = day3tempMin
        self.day3tempMax = day3tempMax
        
        self.day4summary = day4summary
        self.day4icon = day4icon
        self.day4tempMin = day4tempMin
        self.day4tempMax = day4tempMax
        
        self.day5summary = day5summary
        self.day5icon = day5icon
        self.day5tempMin = day5tempMin
        self.day5tempMax = day5tempMax
        
        self.day6summary = day6summary
        self.day6icon = day6icon
        self.day6tempMin = day6tempMin
        self.day6tempMax = day6tempMax
    }
    
    static func weatherWithJSON(results: NSDictionary) -> Weather
    {
        var weather = Weather?()
        var summary = ""
        var icon = ""
        var precipIntensity = 0.0
        var precipProbability = 0.0
        var humid = 0.0
        var windSpeed = 0.0
        var visibility = 0.0
        var cloudCover = 0.0
        var apparentTemperature = 0
        var temperature = 0
        
        var weeksummary = ""
        
        var day0summary = ""
        var day1summary = ""
        var day2summary = ""
        var day3summary = ""
        var day4summary = ""
        var day5summary = ""
        var day6summary = ""
        
        var day0icon = ""
        var day1icon = ""
        var day2icon = ""
        var day3icon = ""
        var day4icon = ""
        var day5icon = ""
        var day6icon = ""
        
        var day0tempMin = 0
        var day1tempMin = 0
        var day2tempMin = 0
        var day3tempMin = 0
        var day4tempMin = 0
        var day5tempMin = 0
        var day6tempMin = 0
        
        var day0tempMax = 0
        var day1tempMax = 0
        var day2tempMax = 0
        var day3tempMax = 0
        var day4tempMax = 0
        var day5tempMax = 0
        var day6tempMax = 0
        
        if let currently = results["currently"] as? NSDictionary
        {
//            var weather = Weather?()
            
            summary = currently["summary"] as! String
            icon = currently["icon"] as! String
            precipIntensity = currently["precipIntensity"] as!Double
//            precipProbability = currently["precipProbability"] as! Double
            //        let humidity = currently["humidity"] as! Double
            humid = currently["dewPoint"] as! Double
            windSpeed = currently["windSpeed"] as! Double
            if let _ = currently["visibility"]
            {
                visibility = currently["visibility"] as! Double
                //some locations don't have visibility in the darksky api
            }
            cloudCover = currently["cloudCover"] as! Double
            
            let apparentTemp = currently["apparentTemperature"] as! Double
            apparentTemperature = tempAsInt(apparentTemp)
            
            let temp = currently["temperature"] as! Double
            temperature = tempAsInt(temp)
        }
        
        if let daily = results["daily"] as? NSDictionary
        {
            weeksummary = daily["summary"] as! String
            
            if let data = daily["data"] as? NSArray
            {
                if let day0 = data[0] as? NSDictionary
                {
                    day0icon = day0["icon"] as! String
                    day0summary = day0["summary"] as! String
                    let tempMin = day0["temperatureMin"] as! Double
                    let tempMax = day0["temperatureMax"] as! Double
                    
                    precipProbability = day0["precipProbability"] as! Double
                    
                    day0tempMin = tempAsInt(tempMin)
                    day0tempMax = tempAsInt(tempMax)
                }
                if let day1 = data[1] as? NSDictionary
                {
                    day1icon = day1["icon"] as! String
                    day1summary = day1["summary"] as! String
                    let tempMin = day1["temperatureMin"] as! Double
                    let tempMax = day1["temperatureMax"] as! Double
                    
                    day1tempMin = tempAsInt(tempMin)
                    day1tempMax = tempAsInt(tempMax)
                }
                if let day2 = data[2] as? NSDictionary
                {
                    day2icon = day2["icon"] as! String
                    day2summary = day2["summary"] as! String
                    let tempMin = day2["temperatureMin"] as! Double
                    let tempMax = day2["temperatureMax"] as! Double
                    
                    day2tempMin = tempAsInt(tempMin)
                    day2tempMax = tempAsInt(tempMax)
                }
                if let day3 = data[3] as? NSDictionary
                {
                    day3icon = day3["icon"] as! String
                    day3summary = day3["summary"] as! String
                    let tempMin = day3["temperatureMin"] as! Double
                    let tempMax = day3["temperatureMax"] as! Double
                    
                    day3tempMin = tempAsInt(tempMin)
                    day3tempMax = tempAsInt(tempMax)
                }
                if let day4 = data[4] as? NSDictionary
                {
                    day4icon = day4["icon"] as! String
                    day4summary = day4["summary"] as! String
                    let tempMin = day4["temperatureMin"] as! Double
                    let tempMax = day4["temperatureMax"] as! Double
                    
                    day4tempMin = tempAsInt(tempMin)
                    day4tempMax = tempAsInt(tempMax)
                }
                if let day5 = data[5] as? NSDictionary
                {
                    day5icon = day5["icon"] as! String
                    day5summary = day5["summary"] as! String
                    let tempMin = day5["temperatureMin"] as! Double
                    let tempMax = day5["temperatureMax"] as! Double
                    
                    day5tempMin = tempAsInt(tempMin)
                    day5tempMax = tempAsInt(tempMax)
                }
                if let day6 = data[6] as? NSDictionary
                {
                    day6icon = day6["icon"] as! String
                    day6summary = day6["summary"] as! String
                    let tempMin = day6["temperatureMin"] as! Double
                    let tempMax = day6["temperatureMax"] as! Double
                    
                    day6tempMin = tempAsInt(tempMin)
                    day6tempMax = tempAsInt(tempMax)
                }
            }
        }

//        weather = Weather(
//            summary: summary,
//            icon: icon,
//            precipIntensity: precipIntensity,
//            precipProbability: precipProbability,
//            temperature: temperature,
//            apparentTemp: apparentTemperature,
//            humidity: humid,
//            windSpeed: windSpeed,
//            visibility: visibility,
//            cloudCover: cloudCover
//            
//            
//            
//        )
        
        weather = Weather(summary: summary, icon: icon, precipIntensity: precipIntensity, precipProbability: precipProbability, temperature: temperature, apparentTemp: apparentTemperature, humidity: humid, windSpeed: windSpeed, visibility: visibility, cloudCover: cloudCover, weeksummary: weeksummary, day0summary: day0summary, day1summary: day1summary, day2summary: day2summary, day3summary: day3summary, day4summary: day4summary, day5summary: day5summary, day6summary: day6summary, day0icon: day0icon, day1icon: day1icon, day2icon: day2icon, day3icon: day3icon, day4icon: day4icon, day5icon: day5icon, day6icon: day6icon, day0tempMin: day0tempMin, day1tempMin: day1tempMin, day2tempMin: day2tempMin, day3tempMin: day3tempMin, day4tempMin: day4tempMin, day5tempMin: day5tempMin, day6tempMin: day6tempMin, day0tempMax: day0tempMax, day1tempMax: day1tempMax, day2tempMax: day2tempMax, day3tempMax: day3tempMax, day4tempMax: day4tempMax, day5tempMax: day5tempMax, day6tempMax: day6tempMax)
        
        return weather!

    }

    static func tempAsInt(temp: Double) -> Int
    {
        var fullTemp = String(temp).componentsSeparatedByString(".")
        var firstNum = Double(fullTemp[0])
        if Double(fullTemp[1]) > 50
        {
            firstNum! += 1
        }
        
        return Int(firstNum!)
    }
}

