//
//  AAAProductsWithIngredientsMO+CoreDataProperties.swift
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

extension AAAProductsWithIngredientsMO {

    @NSManaged var prd_id: String?
    @NSManaged var ing_id: String?
    @NSManaged var name: String?

}
