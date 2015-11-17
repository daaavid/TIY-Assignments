//
//  Time.swift
//  Forecaster
//
//  Created by david on 10/30/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation

class Time
{
//    func time(date: NSDate) -> Bool
//    {
//        let formatter = NSDateFormatter()
//        formatter.timeStyle = .ShortStyle
//        let time = formatter.stringFromDate(NSDate())
//        let ampm = time.componentsSeparatedByString(" ")[1]
//        var hour = Int(time.componentsSeparatedByString(":")[0])!
//        
//        if ampm == "PM"
//        {
//            hour += 12
//        }
//        
//        return isDay(hour)
//    }
    
    func isDay(hour: Int) -> Bool
    {
        var isDay: Bool
        
        switch hour
        {
        case 6...18:
            isDay = true
        default:
            isDay = false
        }
        return isDay
    }
}