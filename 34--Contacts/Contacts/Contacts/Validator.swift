//
//  Validator.swift
//  Contacts
//
//  Created by david on 11/21/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation

class Validator
{
    func validate(string: String, cc: String) -> Bool
    {
        var regEx = ""
        
        switch cc
        {
        case "phone": regEx = "^\\(\\d{3}\\) \\d{3}-\\d{4}$"
        case "email": regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        case "name":  regEx = "^[A-Za-z]{1,10}$"
        default: print("nope")
        }
        
        let test = NSPredicate(format: "SELF MATCHES %@", regEx)
        let result =  test.evaluateWithObject(string)
        return result
    }
}
