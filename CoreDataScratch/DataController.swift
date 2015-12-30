//
//  DataController.swift
//  CoreDataScratch
//
//  Created by syed farrukh Qamar on 18/12/15.
//  Copyright © 2015 Be My Competence AB. All rights reserved.
//

import Foundation


import UIKit
import CoreData
class DataController: NSObject {
   
    var managedObjectContext: NSManagedObjectContext
   override init() {
        // This resource is the same name as your xcdatamodeld contained in your project.
    print("about to find core data scratch in datacontroller")
    guard let modelURL = NSBundle.mainBundle().URLForResource("CoreDataScratch", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        self.managedObjectContext.persistentStoreCoordinator = psc
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
            let docURL = urls[urls.endIndex-1]
            /* The directory the application uses to store the Core Data store file.
            This code uses a file named "ProductsWithIngredientsDB.sqlite" in the application's documents directory.
            */
            print("Inside DataController.swift:Directory for SQLITE is:\(docURL)")
            let storeURL = docURL.URLByAppendingPathComponent("ProductsWithIngredientsDB.sqlite")
            do {
                try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
    }
}



