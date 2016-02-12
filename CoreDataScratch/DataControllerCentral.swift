//
//  DataControllerCentral.swift
//  CoreDataScratch
//
//  Created by syed farrukh Qamar on 04/02/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataControllerCentral {
    
    var managedObjectContext: NSManagedObjectContext
    init() {
        // This resource is the same name as your xcdatamodeld contained in your project.
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
            This code uses a file named "DataModel.sqlite" in the application's documents directory.
            */
            let storeURL = docURL.URLByAppendingPathComponent("ProductsWithIngredientDB.sqlite")
            do {
                try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
    }
    
    // Record Creation
    func addNewIngredient (ingredientAgainstProduct: AAAProductsWithIngredientsMO)
    {
        print("check--------1")
        let ingredientWithProduct = NSEntityDescription.insertNewObjectForEntityForName("ProductsWithIngredients", inManagedObjectContext: self.managedObjectContext) as! AAAProductsWithIngredientsMO
        
    }
    
    // Saving
    func saveExecute (){
        print("check--------2")
        
        do {
            print("check--------3")
            
            try self.managedObjectContext.save()
            
        }catch {
            fatalError("Failure to save context: Inside DataControllerCentral\(error)")
        }
        
    }
    
    // Fetch Request
    
    func fetchProductsIngredients (){
        let moc = self.managedObjectContext
        let employeesFetch = NSFetchRequest(entityName: "ProductsWithIngredients")
        
        do {
            let fetchedProductsIngredients = try moc.executeFetchRequest(employeesFetch) as! [AAAProductsWithIngredientsMO]
        } catch {
            fatalError("Failed to fetch ---ProductsWithIngredients: \(error)")
        }
        
    }
    // Filtering resukts
    // let firstName = "Trevor"
    //    fetchRequest.predicate = NSPredicate(format: "firstName == %@", firstName)
    
}