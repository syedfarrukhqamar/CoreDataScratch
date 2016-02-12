//
//  AAAUsersMO+CoreDataProperties.swift
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

extension AAAUsersMO {

    @NSManaged var user_id: NSNumber?
    @NSManaged var user_name: String?
    @NSManaged var contact_Number: NSNumber?
    @NSManaged var email: String?
    @NSManaged var city: String?
    @NSManaged var registered_via_reference_code: String?
    @NSManaged var reference_code_to_give: String?
    @NSManaged var country: String?
    @NSManaged var age: String?
    @NSManaged var gender: String?

}
