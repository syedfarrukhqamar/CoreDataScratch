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
    
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "BeMyCompetenceAB.CoreDataScratch" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("CoreDataScratch", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        //let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        let url = //self.applicationDocumentsDirectory.URLByAppendingPathComponent("IngredientsData.sqlite")
        self.applicationDocumentsDirectory.URLByAppendingPathComponent("ProductsWithIngredientsDB.sqlite")
        
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as! NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
// Mark Data Controller functions
    
    func createDBConnectionAndSearchFor (tableName: String, columnName: String, searchString: String) -> AnyObject  {
    
       // let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    print("inside createDBConnectionAndSearchFor------")
        var table_Name = tableName
        var column_name = columnName
        var searchFor = searchString

        let context: NSManagedObjectContext = self.managedObjectContext
         let tableFetch = NSFetchRequest(entityName: table_Name)
               tableFetch.predicate = NSPredicate(format: "%K Contains %@",column_name, searchFor)
//        var ingId = String()
//        var fetched2 = String()
//        var nme = String()
//        var desc = String()
//        var usgExm = String()
//
        var fetchedResult = [AnyObject]()
        
        do {
            fetchedResult = try context.executeFetchRequest(tableFetch) //as! [Ingredients]
            print("inside createDBConnectionAndSearchFor-FetchResult Attempt-----")
//            if fetchedIngredients.count == 0
//            {
//
//                return fetchedIngredients
//            }
//            ingId = (fetchedIngredients.first!.ingredient_id)!
//            nme = (fetchedIngredients.first!.name)!
//            desc = (fetchedIngredients.first!.descryption)!
//            usgExm = (fetchedIngredients.first!.halal_status)!
//            
//            print("Total Record Founds are:::: \(fetchedIngredients.count)")
        return fetchedResult
            
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
//    var result = [String]()
//    result [0] = "False"
//    return result
return fetchedResult
        
    
    }
    
    // MARK Register Ingredient To Product
    
    func registerIngredientToProduct (productID: String, ingredientID: String, h_status: String){
    
        // First check if the specific product is available in the products main table
        let productCheck = DataController()
        
        let productResult = productCheck.createDBConnectionAndSearchFor("MasterProducts", columnName: "product_id", searchString: productID) as! [AAAMasterProductsMO]
        print("----------------------------------------")
        
        print("product id count is here:-9-: \(productResult.count)")
        print("found product id is:: \(productID)")
        print("----------------------------------------")
        // if product is not present then first add the product
        if (productResult.count == 0){
       print("-------------Product Result count was ZERO ---------------------------")
            
            let productToAdd:[String:String] = ["h_status": "Test Status Dict","product_id":productID,"product_name":"Temp Name DIct","product_type":"Temp Type Dict"]
            print("------------ADDING PRODUCT ---------------------------")
            
            productCheck.addRecordToProduct(productToAdd)
            print("Product id which have been added is:: \(productID)")
            print("------------Checking again for product id --------------------\(productID)")
            
            let productResult = productCheck.createDBConnectionAndSearchFor("MasterProducts", columnName: "product_id", searchString: productID) as! [AAAMasterProductsMO]
            
            print("product id count is here:: \(productResult.count)")
            print("found product id is:: \(productID)")
            
        }
        
        
        
    // check if the ingredient has been registered against same product id
        
        
        
        let ingredientRegisterationCheck = DataController()
        let ingredientRegisterationCheckResult = ingredientRegisterationCheck.createDBConnectionAndSearchFor("ProductsWithIngredients", columnName: "prd_id", searchString: productID) as! [AAAProductsWithIngredientsMO]
        // If NO product id is found then add it together with ingredient id
       
        var ingredientToAddStatus = false
        
        
        if (ingredientRegisterationCheckResult.count == 0){
        print ("-----Registering Ingredients to Products")
        ingredientRegisterationCheck.addIngredientsToProduct(ingredientID, productID: productID, halal_haram_mushbooh_Status: h_status)
            print ("-----Ingredients Registered---------")
        }
        
        else {
            
//            var productIngredientsFetchResult = ingredientRegisterationCheck.createDBConnectionAndSearchFor("MasterProducts", columnName: "product_id", searchString: productID) as! [AAAProductsWithIngredientsMO]
            
            // change ingredientoaddstatus to true if ingredient is already registered
            for index in 0..<ingredientRegisterationCheckResult.count {
              
                if (ingredientRegisterationCheckResult[index].ing_id == ingredientID){
                
                ingredientToAddStatus = true
                    print("Ingredient----\(ingredientID) is already registered 878")
                }
            }
        // if Ingredient is not registered against existing product in ProductIngredient Table then register it i.e. if ingredienttoAddStatus == false
            
            if (ingredientToAddStatus == false){
            ingredientRegisterationCheck.addIngredientsToProduct(ingredientID, productID: productID, halal_haram_mushbooh_Status: h_status)
            print("ingredient--\(ingredientID)----has been just now registered against product id: \(productID)")
            
            }        
        }
        // if product id have been found more than 0 then search for the ingredient if registered against this product
        
        
        //if above is false then register a product against the product
        
        
    
        
    // Check if the combo record is available
        // if not then add the record261
        
        // also change the status of the product based on the priority table
            // if there are three ingredients
                //Ingredient one is halal
                    //Ingredient two is mushbooh
                        // ingredient three is haram
                            // Product is haram
                // if ingredient one is halal
                    //if ingredient two is haram then product is haram
                    //if ingredient two is mushbooh then product is halal
        
    // Check product status must be checked each time by 
            // getting list of the ingredients registered against the specific product
            // then check if any ingredient is haram , show haram
            // if no haram product found then check for mushbooh product

    
    }
    
    
    
    
    // MARK DB Adding Records Function
    
    
    // MARK DB Adding ingredients against products
    
    func addIngredientsToProduct ( ingredientToRegister: String, productID: String, halal_haram_mushbooh_Status: String) {
        
        print("")
        var ingredientsExistsOrNot = DataController()
        var productCode = String()
        
        var productIngredientsSearchResult =  ingredientsExistsOrNot.createDBConnectionAndSearchFor("ProductsWithIngredients", columnName: "prd_id",searchString: productCode) as! [AAAProductsWithIngredientsMO]
        if ( productIngredientsSearchResult.count == 0 )
        {
            
            print("The product id =\(productCode) doesnt exist and the count is = \(productIngredientsSearchResult.count)")
            print("Adding product id and ingredients to the db now")
 
            print("---ingProd---------124")
            let context: NSManagedObjectContext = self.managedObjectContext
            print("ingProd------125")
            var insertRecordToProductsIngredients = NSEntityDescription.insertNewObjectForEntityForName("ProductsWithIngredients", inManagedObjectContext: context) as! AAAProductsWithIngredientsMO
            print("------ingProd---------126")
            insertRecordToProductsIngredients.setValue(halal_haram_mushbooh_Status,forKey: "h_Status")
            insertRecordToProductsIngredients.setValue(ingredientToRegister,forKey: "ing_id")
            insertRecordToProductsIngredients.setValue("Prd_name",forKey: "name")
            insertRecordToProductsIngredients.setValue(productID,forKey: "prd_id")
            print("----ingProd-------127")
          
            do {
                print("Registering Ingredient id :\(ingredientToRegister) against product ID::\(productID)")
                try context.save()
                context.unlock()
                print("Registered Ingredient id :\(ingredientToRegister) against product ID::\(productID)")
                //               statusSave = true
            } catch let error {
                print("Could not cache the response \(error)")
                //             statusSave=false
                //           print("Here is productRecords::\(productRecords.count)")
                
                // return statusSave
            }
            
        }
            
            // if product id found then see if the ingredient is registered or not against it.
        else
            
        {
            var ingredientFoundStatus = false
            print("44433334444")
            for index in 1..<productIngredientsSearchResult.count
                
            {
                print("444 for loop 444")
                
                print("checking for ingredients against product if registered")
                if (productIngredientsSearchResult[index].valueForKey("ing_id")?.string == ingredientToRegister)
                {
                    print("ingredient status is \(ingredientFoundStatus)")
                    
                    ingredientFoundStatus = true
                }
            }
            
            // ingredient id couldnt be found against the given product id thus adding because status is false
            if ingredientFoundStatus == false
            {
                let context: NSManagedObjectContext = self.managedObjectContext
                print("ingProd------125")
                var insertRecordToProductsIngredients = NSEntityDescription.insertNewObjectForEntityForName("ProductsWithIngredients", inManagedObjectContext: context) as! AAAProductsWithIngredientsMO
                print("------ingProd---------126")
                insertRecordToProductsIngredients.setValue(halal_haram_mushbooh_Status,forKey: "h_Status")
                insertRecordToProductsIngredients.setValue(ingredientToRegister,forKey: "ing_id")
                insertRecordToProductsIngredients.setValue("Prd_name",forKey: "name")
                insertRecordToProductsIngredients.setValue(productID,forKey: "prd_id")
                print("----ingProd-------127")
                
                do {
                    print("Registering Ingredient id :\(ingredientToRegister) against product ID::\(productID)")
                    try context.save()
                    print("Registered Ingredient id :\(ingredientToRegister) against product ID::\(productID)")
                    //               statusSave = true
                } catch let error {
                    print("Could not cache the response \(error)")
                }
            }
            
            
            
            print("The product id =\(productID) already exists and Thus not adding it, the count is = \(productIngredientsSearchResult.count)")
            
        }
        
    }

    
    // MARK DB Adding products
    
    func addRecordToProduct ( productToAdd: [String: String]) {
        var productExistsOrNot = DataController()
        var productCode = String()
        productCode = productToAdd["product_id"]!

var productSearchResult =        productExistsOrNot.createDBConnectionAndSearchFor("MasterProducts", columnName: "product_id",searchString: productCode) as! [AAAMasterProductsMO]
        if ( productSearchResult.count == 0 )
        {
        
            print("The product id =\(productCode) doesnt exist and the count is = \(productSearchResult.count)")
            print("Adding it to the db now")
    
            print("------------124")
        let context: NSManagedObjectContext = self.managedObjectContext
        print("125")
        var insertRecordToMasterProducts = NSEntityDescription.insertNewObjectForEntityForName("MasterProducts", inManagedObjectContext: context) as! AAAMasterProductsMO
        print("---------------126")
        insertRecordToMasterProducts.setValue(productToAdd["h_status"],forKey: "h_status")
        insertRecordToMasterProducts.setValue(productToAdd["product_id"],forKey: "product_id")
        insertRecordToMasterProducts.setValue(productToAdd["product_name"],forKey: "product_name")
        insertRecordToMasterProducts.setValue(productToAdd["product_type"],forKey: "product_type")
       print("-----------127")
                    do {
                    print("Inserting Record in Product for Product ID \(productToAdd["product_id"])")
                    try context.save()
                    print("Inserted Record in Product for Product ID::\(productToAdd["product_id"])")
        
         //               statusSave = true
                    } catch let error {
                        print("Could not cache the response \(error)")
           //             statusSave=false
             //           print("Here is productRecords::\(productRecords.count)")
        
                       // return statusSave
                    }
            
        }
        else
            
        {
            print("The product id =\(productCode) already exists and Thus not adding it, the count is = \(productSearchResult.count)")
            
        }
        
    }
    
   
   /*
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
*/
    
}



