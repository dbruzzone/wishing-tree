//
//  Category+CoreDataProperties.swift
//  Time
//
//  Created by Davide Bruzzone on 10/18/15.
//  Copyright © 2015 Davide Bruzzone. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Category {

    @NSManaged var name: String?
    @NSManaged var activities: NSSet?

}
