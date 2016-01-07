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
        
        venue.setValue(venueDict["name"] as? String ?? "", forKey: "name")
        
        let contact = venueDict["contact"] as? NSDictionary ?? NSDictionary()
        venue.setValue(contact["phone"] as? String ?? "", forKey: "phone")
        
        let location = venueDict["location"] as? NSDictionary ?? NSDictionary()
        venue.setValue(location["address"] as? String ?? "", forKey: "address")
            
        venue.setValue(location["lat"] as? Double ?? 0.0, forKey: "lat")
        venue.setValue(location["lng"] as? Double ?? 0.0, forKey: "lng")
        
        venue.setValue(location["distance"] as? Int ?? 0, forKey: "distance")
        
        let category = (venueDict["categories"] as? [NSDictionary])!.first ?? NSDictionary()
        
        venue.setValue(category["shortName"] as? String ?? "", forKey: "type")
        
        let iconDict = category["icon"] as? NSDictionary ?? NSDictionary()
        
        let prefix = (iconDict["prefix"] as! String).stringByReplacingOccurrencesOfString("\\", withString: "")
        let suffix = iconDict["suffix"] as! String
        let icon = prefix + "64" + suffix
        
        venue.setValue(icon ?? "", forKey: "icon")
        
        if let _ = venue.valueForKey("favorite") {}
        else
        {
            venue.setValue(false, forKey: "favorite")
        }
        
        return venue
    }
}
