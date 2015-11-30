//
//  Venue+CoreDataProperties.swift
//  
//
//  Created by david on 11/29/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Venue {

    @NSManaged var address: String?
    @NSManaged var distance: NSNumber?
    @NSManaged var icon: String?
    @NSManaged var lat: NSNumber?
    @NSManaged var lng: NSNumber?
    @NSManaged var name: String?
    @NSManaged var phone: String?
    @NSManaged var type: String?
    @NSManaged var favorite: NSNumber?

}
