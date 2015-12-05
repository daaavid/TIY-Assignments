//
//  Settings.swift
//  Philosophone
//
//  Created by david on 12/4/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation

class Settings
{
    var hour: Int
    var categories: [String]
    
    init(hour: Int, categories: [String])
    {
        self.hour = hour
        self.categories = categories
    }
}