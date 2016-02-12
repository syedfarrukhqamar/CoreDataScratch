//
//  UserRoles+CoreDataProperties.swift
//  CoreDataScratch
//
//  Created by syed farrukh Qamar on 28/01/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension UserRoles {

    @NSManaged var user_id: NSNumber?
    @NSManaged var role_id: String?

}
