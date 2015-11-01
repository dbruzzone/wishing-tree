//
//  Activity+CoreDataProperties.swift
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

extension Activity {

    @NSManaged var name: String?
    @NSManaged var locations: NSSet?

}
