//
//  Sites.swift
//  The-Grail-Diary
//
//  Created by david on 10/19/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation

class SolSystem
{
    var name: String
    var distance: String
    var orbit: String
    var mass: String
    var picture: String
    
    init(dictionary: NSDictionary)
    {
        name = dictionary["name"] as! String
        distance = dictionary["distance"] as! String
        orbit = dictionary["orbit"] as! String
        mass = dictionary["mass"] as! String
        picture = dictionary["picture"] as! String
    }
}