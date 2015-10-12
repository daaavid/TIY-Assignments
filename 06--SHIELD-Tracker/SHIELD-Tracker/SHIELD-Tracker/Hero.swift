//
//  Hero.swift
//  SHIELD-Tracker
//
//  Created by david on 10/12/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation

class Hero
{
    var name: String
    var homeworld: String
    var powers: String
    
    init(dictionary: NSDictionary)
    {
        name = dictionary["name"] as! String
        homeworld = dictionary["homeworld"] as! String
        powers = dictionary["powers"] as! String
    }
}