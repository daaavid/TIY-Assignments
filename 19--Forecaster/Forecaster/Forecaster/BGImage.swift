//
//  bgImage.swift
//  Forecaster
//
//  Created by david on 10/30/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation

class BGImage
{
    func bgImage(condtion: String) -> String
    {
        let time = Time()
        var hour: Int = time.hour()
        
        hour += 5
        switch condtion
        {
        case "no":
            "no"
        default:
            "no"
        }
        
        return " "
    }
}
