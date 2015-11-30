//
//  Venue.swift
//  Venue-Menu
//
//  Created by david on 11/27/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation
/*
class Venue
{
    let name: String
    let phone: String
    let formattedPhone: String
    
    let address: String
    let lat: Double
    let lng: Double
    
    let distance: Int
    let city: String
    let state: String

    let icon: String
//    let rating: Double
    let type: String
    
    init(
        name: String,
        phone: String,
        formattedPhone: String,
        
        address: String,
        lat: Double,
        lng: Double,
        
        distance: Int,
        city: String,
        state: String,
        
        icon: String,
        type: String
    )
    {
        self.name = name
        self.phone = phone
        self.formattedPhone = formattedPhone
        
        self.address = address
        self.lat = lat
        self.lng = lng
        
        self.distance = distance
        self.city = city
        self.state = state
        
        self.icon = icon
        self.type = type
    }
    
    static func venueDictWithJSON(venueDict: NSDictionary) -> Venue?
    {
        var venue: Venue
        
        var name = ""
        if let tryName = venueDict["name"] as? String
        {
            name = tryName
        }
        
        var contact = NSDictionary()
        if let tryContact = venueDict["contact"] as? NSDictionary
        {
            contact = tryContact
        }
        
        var phone = ""
        if let tryPhone = contact["phone"] as? String
        {
            phone = tryPhone
        }
        
        var formattedPhone = ""
        if let tryFormattedPhone = contact["formattedPhone"] as? String
        {
            formattedPhone = tryFormattedPhone
        }
        
        var location = NSDictionary()
        if let tryLocation = venueDict["location"] as? NSDictionary
        {
            location = tryLocation
        }
        
        var address = ""
        if let tryAddress = location["address"] as? String
        {
            address = tryAddress
        }
        
        var lat = 0.0 ; var lng = 0.0
        if let tryLat = location["lat"] as? Double
        {
            if let tryLng = location["lng"] as? Double
            {
                lat = tryLat
                lng = tryLng
            }
        }
        
        var distance = 0
        if let tryDistance = location["distance"] as? Int
        {
            distance = tryDistance
        }
        
        var city = ""
        if let tryCity = location["city"] as? String
        {
            city = tryCity
        }
        
        var state = ""
        if let tryState = location["state"] as? String
        {
            state = tryState
        }
        
        var categories = [NSDictionary]()
        if let tryCategories = venueDict["categories"] as? [NSDictionary]
        {
            categories = tryCategories
        }
        
        var type: String = ""
        var icon: String = ""
        if let category = categories.first
        {
            if let shortName = category["shortName"] as? String
            {
                type = shortName
            }
            
            if let iconDict = category["icon"] as? NSDictionary
            {
                var prefix = iconDict["prefix"] as! String
                prefix = prefix.stringByReplacingOccurrencesOfString("\\", withString: "")
                let suffix = iconDict["suffix"] as! String
                icon = prefix + "64" + suffix
            }
        }
        
        venue = Venue(
            name: name,
            phone: phone,
            formattedPhone: formattedPhone,
            address: address,
            lat: lat,
            lng: lng,
            distance: distance,
            city: city,
            state: state,
            icon: icon,
            type: type
        )
        
        return venue
    }
}
*/