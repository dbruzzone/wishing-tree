//
//  MediaItem+CoreDataProperties.swift
//  Annotate
//
//  Created by Davide Bruzzone on 11/10/15.
//  Copyright © 2015 Bitwise Samurai. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MediaItem {

    @NSManaged var title: String?
    @NSManaged var artist: String?
    @NSManaged var url: String?
    @NSManaged var currentPosition: NSNumber?
    @NSManaged var createdDate: NSDate?
    @NSManaged var updatedDate: NSDate?
    @NSManaged var notes: NSOrderedSet?

}
