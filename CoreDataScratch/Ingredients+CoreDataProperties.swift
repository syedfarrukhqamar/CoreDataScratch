//
//  Ingredients+CoreDataProperties.swift
//  CoreDataScratch
//
//  Created by syed farrukh Qamar on 24/12/15.
//  Copyright © 2015 Be My Competence AB. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Ingredients {

    @NSManaged var descryption: String?
    @NSManaged var ingredient_id: String?
    @NSManaged var name: String?
    @NSManaged var halal_status: String?

}
