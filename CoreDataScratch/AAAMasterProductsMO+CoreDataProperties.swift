//
//  AAAMasterProductsMO+CoreDataProperties.swift
//  CoreDataScratch
//
//  Created by syed farrukh Qamar on 30/12/15.
//  Copyright © 2015 Be My Competence AB. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension AAAMasterProductsMO {

    @NSManaged var product_id: String?
    @NSManaged var product_type: String?
    @NSManaged var product_name: String?

}
