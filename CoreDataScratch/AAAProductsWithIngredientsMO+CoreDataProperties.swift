//
//  AAAProductsWithIngredientsMO+CoreDataProperties.swift
//  CoreDataScratch
//
//  Created by syed farrukh Qamar on 26/01/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension AAAProductsWithIngredientsMO {

    @NSManaged var h_Status: String?
    @NSManaged var ing_descryption: String?
    @NSManaged var ing_id: String?
    @NSManaged var ing_name: String?
    @NSManaged var prd_id: String?
    @NSManaged var prd_name: String?

}
