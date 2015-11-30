//
//  Venue.swift
//  
//
//  Created by david on 11/29/15.
//
//

import Foundation
import CoreData
import UIKit

class Venue: NSManagedObject
{
    static func venueWithJSON(venueDict: NSDictionary) -> NSManagedObject?
    {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let entity = NSEntityDescription.entityForName("Venue", inManagedObjectContext: context)!
        let venue = NSManagedObject(entity: entity, insertIntoManagedObjectContext: context)
        
        if let tryName = venueDict["name"] as? String
        {
            venue.setValue(tryName, forKey: "name")
        }
        else
        {
            venue.setValue("", forKey: "name")
        }
        
        var contact = NSDictionary()
        if let tryContact = venueDict["contact"] as? NSDictionary
        {
            contact = tryContact
            
            if let tryPhone = contact["phone"] as? String
            {
                venue.setValue(tryPhone, forKey: "phone")
                /*
                if let tryFormattedPhone = contact["formattedPhone"] as? String
                {
                    venue.setValue(tryPhone, forKey: "phone")
                    venue.setValue(tryFormattedPhone, forKey: "formattedPhone")
                }
                */
            }
        }
        else
        {
            venue.setValue("", forKey: "phone")
//            venue.setValue("", forKey: "formattedPhone")
        }
        
        var location = NSDictionary()
        if let tryLocation = venueDict["location"] as? NSDictionary
        {
            location = tryLocation
            if let tryAddress = location["address"] as? String
            {
                venue.setValue(tryAddress, forKey: "address")
            }
            else
            {
                venue.setValue("", forKey: "address")
            }
            
            if let tryLat = location["lat"] as? Double
            {
                if let tryLng = location["lng"] as? Double
                {
                    venue.setValue(tryLat, forKey: "lat")
                    venue.setValue(tryLng, forKey: "lng")
                }
            }
            else
            {
                venue.setValue(0.0, forKey: "lat")
                venue.setValue(0.0, forKey: "lng")
            }
            
            if let tryDistance = location["distance"] as? Int
            {
                venue.setValue(tryDistance, forKey: "distance")
            }
            else
            {
                venue.setValue(0, forKey: "distance")
            }
/*
            if let tryCity = location["city"] as? String
            {
                venue.setValue(tryCity, forKey: "city")
            }
            else
            {
                venue.setValue("", forKey: "city")
            }

            if let tryState = location["state"] as? String
            {
                venue.setValue(tryState, forKey: "state")
            }
            else
            {
                venue.setValue("", forKey: "state")
            }
*/
        }

        var categories = [NSDictionary]()
        if let tryCategories = venueDict["categories"] as? [NSDictionary]
        {
            categories = tryCategories
        }
        
        if let category = categories.first
        {
            if let shortName = category["shortName"] as? String
            {
                venue.setValue(shortName, forKey: "type")
            }
            else
            {
                venue.setValue("", forKey: "type")
            }
            
            if let iconDict = category["icon"] as? NSDictionary
            {
                let prefix = (iconDict["prefix"] as! String).stringByReplacingOccurrencesOfString("\\", withString: "")
                let suffix = iconDict["suffix"] as! String
                let icon = prefix + "64" + suffix
                
                venue.setValue(icon, forKey: "icon")
            }
            else
            {
                venue.setValue("", forKey: "icon")
            }
        }
        
        if let _ = venue.valueForKey("favorite") {}
        else
        {
            venue.setValue(false, forKey: "favorite")
        }
        
        return venue
    }
}
