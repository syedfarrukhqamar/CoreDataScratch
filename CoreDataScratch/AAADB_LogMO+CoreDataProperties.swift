//
//  AAADB_LogMO+CoreDataProperties.swift
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

extension AAADB_LogMO {

    @NSManaged var db_loaded: NSNumber?
    @NSManaged var db_loaded_date: NSDate?
    @NSManaged var db_loaded_time: NSDate?
    @NSManaged var status: String?

}
