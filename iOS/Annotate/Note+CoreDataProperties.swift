//
//  Note+CoreDataProperties.swift
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

extension Note {

    @NSManaged var note: String?
    @NSManaged var createdDate: NSDate?
    @NSManaged var updatedDate: NSDate?
    @NSManaged var start: NSNumber?
    @NSManaged var end: NSNumber?

}
