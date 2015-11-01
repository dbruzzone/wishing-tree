//
//  Location+CoreDataProperties.swift
//  Pace
//
//  Created by Davide Bruzzone on 11/1/15.
//  Copyright © 2015 Davide Bruzzone. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Location {

    @NSManaged var altitude: NSNumber?
    @NSManaged var horizontalAccuracy: NSNumber?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var summary: String?
    @NSManaged var timestamp: NSDate?
    @NSManaged var verticalAccuracy: NSNumber?

}
