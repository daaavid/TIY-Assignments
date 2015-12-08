//
//  Todo+CoreDataProperties.swift
//  In-Due-Time
//
//  Created by david on 10/21/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Todo
{
    @NSManaged var isDone: Bool
    @NSManaged var title: String?
    @NSManaged var date: String?

}
