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


// switch off with Section A------ // class DataController: NSObject {

class DataController {
    // MARK: - Core Data stack
    //--- Section B ----replacing Section A with Section B on 10th of feb-----start
    
    
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
    
    
    
    //--- Section B ----replacing Section A with Section B on 10th of feb-----end
    
    //---Section A---old code until 10th feb before major change start
 /*
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
        self.applicationDocumentsDirectory.URLByAppendingPathComponent("ProductsWithIngredientDB.sqlite")
        
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
   //------old code until 10th feb before major change end here
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
   */
    // Mark Data Controller functions
    
    func createDBConnectionAndSearchFor (tableName: String, columnName: String, searchString: String,filtered: Bool) -> AnyObject  {
      //-----Section----A-----switch off start
       // let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
      //-----Section----A-----switch off end
        
        print("inside createDBConnectionAndSearchFor------")
        print("SEARCH STRING IS table name :\(tableName) and column name is :::\(columnName) while the search string is ::\(searchString)")
        
        
        var table_Name = tableName
        var column_name = columnName
        var searchFor = searchString
        //-----Section----A-----switch off start
        //  let context: NSManagedObjectContext = appDel.managedObjectContext
        //-----Section----A-----switch off end

        let tableFetch = NSFetchRequest(entityName: table_Name)
        
        if (filtered == true){
            tableFetch.predicate = NSPredicate(format: "%K = %@",column_name, searchFor)
        }
        else if (filtered == false) {
            print("filtered == false")
            tableFetch.predicate = nil
        }
        
        var fetchedResult = [AnyObject]()
        
        do {
            //----section A----switch off
            //----replaced context with self.managedObjectContext
            fetchedResult = try self.managedObjectContext.executeFetchRequest(tableFetch) //as! [Ingredients]
            print("inside createDBConnectionAndSearchFor-FetchResult Attempt----count is fetchedResult-= \(fetchedResult.count)")
            
            print("SEARCH STRING IS table name :\(tableName) and column name is :::\(columnName) while the search string is ::\(searchString)")
            
            // print("fetched Result first is \(fetchedResult[0].)")
            
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
    
    
    // create db connection to return nsmanaged object instead of anyobject
    func searchFor (tableName: String, columnName: String, searchString: String,filtered: Bool) -> [NSManagedObject]  {
        
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        print("inside createDBConnectionAndSearchFor------")
        print("SEARCH STRING IS table name :\(tableName) and column name is :::\(columnName) while the search string is ::\(searchString)")
        
        
        var table_Name = tableName
        var column_name = columnName
        var searchFor = searchString
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let tableFetch = NSFetchRequest(entityName: table_Name)
        
        if (filtered == true){
            tableFetch.predicate = NSPredicate(format: "%K = %@",column_name, searchFor)
        }
        else if (filtered == false) {
            print("filtered == false")
            tableFetch.predicate = nil
        }
        
        var fetchedResult = [NSManagedObject]()
        
        do {
            
            fetchedResult = try context.executeFetchRequest(tableFetch) as! [NSManagedObject]
            print("inside createDBConnectionAndSearchFor-FetchResult Attempt----count is fetchedResult-= \(fetchedResult.count)")
            
            print("SEARCH STRING IS table name :\(tableName) and column name is :::\(columnName) while the search string is ::\(searchString)")
            
            // print("fetched Result first is \(fetchedResult[0].)")
            
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
    
    
    // MARK Update records function
    
    func updateMasterProducts (productID: String,hStatus: String)  {
        
        // let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        print("inside update function------")
        
        var searchFor = productID
        
        let context: NSManagedObjectContext = self.managedObjectContext
        
        let tableFetch = NSFetchRequest(entityName: "MasterProducts")
        //tableFetch.predicate = NSPredicate(format: "%K Contains %@",column_name, searchFor)
        print("searching for product inside update product is :product ID::\(searchFor)")
        tableFetch.predicate = NSPredicate(format: "%K = %@","product_id", searchFor)
        
        //var predicateTest = NSPredicate(format: "%K = %@","product_id", searchFor)
        
        //   var fetchedResult = [AnyObject]()
        
        do {
            //var  fetchedResult = try context.executeFetchRequest(tableFetch) as! [NSManagedObject]
            var  fetchedResult = try self.managedObjectContext.executeFetchRequest(tableFetch) as! [NSManagedObject]
            
            print("inside Update function fetching results---fetched count is::\(fetchedResult.count)")
          //  print("inside Update function h_status is :::\(fetchedResult[0].valueForKey("h_status")!)")
            
            if fetchedResult.count != 0{
                var managedObject = fetchedResult[0]
                var existingProductStatus = managedObject.valueForKey("h_status") as! String
                
                // MARK Product Halal Status Logic is here
                // if DNK is found then any value can be updated against that product id
                // use a bool to check if context.save must be called or not
                var toSaveStatus = false
                if (existingProductStatus == "DNK" || existingProductStatus == HALAL )
                {
                    print("product status will be updated with \(hStatus)")
                    managedObject.setValue(hStatus, forKey: "h_status")
                    toSaveStatus = true
                }
                    // if "HARAM" FOUND THEN do not change
                else if (existingProductStatus == HARAM){
                    
                    print ("product status will not be Changed as it is ::\(hStatus)")
                }
                    // If "MUSHBOOH" IS FOUND THEN it can be changed to only "Haram" else exit
                else if (existingProductStatus == MUSHBOOH){
                    if (hStatus == HARAM)
                        
                    {  print ("Existing product status is mushbooh and hStatus variable is :\(hStatus)")
                        
                        // change the value to haram
                        managedObject.setValue(hStatus, forKey: "h_status")
                        toSaveStatus = true
                        
                    }
                }
                
                if (toSaveStatus == true){
                    
                    // new record will be saved if toSaveStatus is true else it will not
                    
                    try context.save()
                }
                
                
            }
            //return fetchedResult
            
        } catch {
            fatalError("Failed to update Products for h_status: \(error)")
        }
        //    var result = [String]()
        //    result [0] = "False"
        //    return result
        // return fetchedResult
        
        
    }
    
    
    // MARK Register Ingredient To Product
    
    func registerIngredientToProduct (productID: String, ingredientID: String, h_status: String, ing_name: String,ingredient_descryption: String){
        
        // First check if the specific product is available in the products main table
        let productCheck = DataController()
        
        let productResult = productCheck.createDBConnectionAndSearchFor("MasterProducts", columnName: "product_id", searchString: productID, filtered: true) as! [AAAMasterProductsMO]
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
            
            let productResult = productCheck.createDBConnectionAndSearchFor("MasterProducts", columnName: "product_id", searchString: productID,filtered: true) as! [AAAMasterProductsMO]
            
            print("product id count is here:: \(productResult.count)")
            print("found product id is:: \(productID)")
            
        }
        
        
        
        // check if the ingredient has been registered against same product id
        
        
        
        let ingredientRegisterationCheck = DataController()
        let ingredientRegisterationCheckResult = ingredientRegisterationCheck.createDBConnectionAndSearchFor("ProductsWithIngredients", columnName: "prd_id", searchString: productID,filtered: true) as! [AAAProductsWithIngredientsMO]
        
        // If NO product id is found then add it together with ingredient id
        
        var ingredientToAddStatus = true
        
        
        if (ingredientRegisterationCheckResult.count == 0){
            print ("-----Registering Ingredients to Products with ingredient id is :\(ingredientID) ")
            print ("-----againsta product id is :\(productID) ")
            print ("-----and halal_haram_mushbooh status is  :\(h_status) ")
            
            // ingredientRegisterationCheck.addIngredientsToProduct(ingredientID, productID: productID, halal_haram_mushbooh_Status: h_status, ing_name: String, ing_descryption : String)
            ingredientRegisterationCheck.addIngredientsToProduct(ingredientID, productID: productID, halal_haram_mushbooh_Status: h_status, ing_name: ing_name, ing_descryption: ingredient_descryption)
            
            print ("-----Ingredients Registered---------")
            // MARK Updateing product's status in MasterProducts table based on the ingredient's status
            // MARK BACK BONE Of product , halal, haram, mushbooh status update
            print("updating product status also 878")
            var productStatusUpdate = DataControllerCentral()
            productStatusUpdate.updateMasterProducts(productID, hStatus: h_status)
            //  productStatusUpdate.up
            
        }
            
        else {
            
            //            var productIngredientsFetchResult = ingredientRegisterationCheck.createDBConnectionAndSearchFor("MasterProducts", columnName: "product_id", searchString: productID) as! [AAAProductsWithIngredientsMO]
            
            // change ingredientoaddstatus to false if ingredient is already registered
            for index in 0..<ingredientRegisterationCheckResult.count {
                
                if (ingredientRegisterationCheckResult[index].ing_id == ingredientID){
                    
                    ingredientToAddStatus = false
                    print("Ingredient----\(ingredientID) is already registered 878")
                }
            }
            // if Ingredient is not registered against existing product in ProductIngredient Table then register it i.e. if ingredienttoAddStatus == false
            
            if (ingredientToAddStatus == true){
                
                ingredientRegisterationCheck.addIngredientsToProduct(ingredientID, productID: productID, halal_haram_mushbooh_Status: h_status, ing_name: ing_name, ing_descryption: ingredient_descryption)
                // old code replaced with above. to add more detail of ingredients t
                //ingredientRegisterationCheck.addIngredientsToProduct(ingredientID, productID: productID, halal_haram_mushbooh_Status: h_status)
                print("ingredient--\(ingredientID)----has been just now registered against product id: \(productID)")
                
                // MARK Updateing product's status in MasterProducts table based on the ingredient's status
                // MARK BACK BONE Of product , halal, haram, mushbooh status update
                print("updating product status also 656")
                print("ing status was:\(h_status)")
                
                var productStatusUpdate = DataControllerCentral()
                productStatusUpdate.updateMasterProducts(productID, hStatus: h_status)
                
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
    
    func addIngredientsToProduct ( ingredientToRegister: String, productID: String, halal_haram_mushbooh_Status: String,ing_name: String, ing_descryption : String) {
        
        // print("")
        var ingredientsExistsOrNot = DataController()
        var productCode = String()
        
        var productIngredientsSearchResult =  ingredientsExistsOrNot.createDBConnectionAndSearchFor("ProductsWithIngredients", columnName: "prd_id",searchString: productCode,filtered: true) as! [AAAProductsWithIngredientsMO]
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
            insertRecordToProductsIngredients.setValue("Prd_name",forKey: "prd_name")
            print("product id is :987:\(productID)")
            insertRecordToProductsIngredients.setValue(productID,forKey: "prd_id")
            insertRecordToProductsIngredients.setValue(ing_name,forKey: "ing_name")
            insertRecordToProductsIngredients.setValue(ing_descryption,forKey: "ing_descryption")
            
            print("----ingProd-------127")
            
            do {
                print("Registering Ingredient id :\(ingredientToRegister) against product ID::\(productID)")
                try self.managedObjectContext.save()
                //try context.save()
                //context.unlock()
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
                insertRecordToProductsIngredients.setValue("Prd_name",forKey: "prd_name")
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
    
    // MARK DB updating DB LOADINg Status
    
    func updateDB () -> Bool {
        var productExistsOrNot = DataController()
        var productCode = String()
        // productCode = productToAdd["product_id"]!
        
        print("------updateDB------124")
       //--replaced on 10th feb
        // let context: NSManagedObjectContext = self.managedObjectContext
        print("125")
       //--replacing context with self.managedcontext
        var insertRecordTo_DB_Log = NSEntityDescription.insertNewObjectForEntityForName("DB_Log", inManagedObjectContext: self.managedObjectContext) as! AAADB_LogMO
        print("---------updateDB------126")
        
        var date = NSDateComponents()
        insertRecordTo_DB_Log.setValue(true,forKey: "db_loaded")
        insertRecordTo_DB_Log.setValue(date.date,forKey: "db_loaded_date")
        insertRecordTo_DB_Log.setValue(date.date,forKey: "db_loaded_time")
        insertRecordTo_DB_Log.setValue("Loaded",forKey: "status")
        print("------updateDB-----127")
        
        
        do {
            print("-----updateDB--db_loaded--- \(true)")
            print("-----updateDB---db_loaded_date-- \(date.date)")
            print("-----updateDB--db_loaded_time--- \(date)")
            print("-----updateDB--status--- Loaded")
            try self.managedObjectContext.save()
            print("------------test update db----------")

            return true
            //  print("------")
            
            //               statusSave = true
        } catch let error {
            print("Could not cache the response \(error)")
            return false
            //             statusSave=false
            //           print("Here is productRecords::\(productRecords.count)")
            
            // return statusSave
        }
        
        
        return false
        
    }
    
    
    
    // MARK DB Adding products
    
    func addRecordToProduct ( productToAdd: [String: String]) {
      
        //var productExistsOrNot = DataController()
        var productExistsOrNot = DataControllerCentral()
        
        var productCode = String()
        productCode = productToAdd["product_id"]!
        
        var productSearchResult =        productExistsOrNot.createDBConnectionAndSearchFor("MasterProducts", columnName: "product_id",searchString: productCode,filtered: true) as! [AAAMasterProductsMO]
        if ( productSearchResult.count == 0 )
        {
            
            print("The product id =\(productCode) doesnt exist and the count is = \(productSearchResult.count)")
            print("Adding it to the db now")
            
            print("------------124")
           // let context: NSManagedObjectContext = self.managedObjectContext
            print("125")
            var insertRecordToMasterProducts = NSEntityDescription.insertNewObjectForEntityForName("MasterProducts", inManagedObjectContext: self.managedObjectContext) as! AAAMasterProductsMO
            print("---------------126")
            
            
            insertRecordToMasterProducts.setValue(productHStatus,forKey: "h_status")
            insertRecordToMasterProducts.setValue(productToAdd["product_id"],forKey: "product_id")
            insertRecordToMasterProducts.setValue(productToAdd["product_name"],forKey: "product_name")
            insertRecordToMasterProducts.setValue(productToAdd["product_type"],forKey: "product_type")
            print("-----------127")
            do {
                print("Inserting Record in Product for Product ID \(productToAdd["product_id"])")
               print("self.managedObjectContext in DataController:addRecordToProduct is = \(self.managedObjectContext)")
                try self.managedObjectContext.save()
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
    
    // MARK DB: getProductIngredientStatus
    
    func getProductOrIngredientStatus (productID:String, ingredientID:String) -> String {
        var status = "Error Occured While retrieving status"
        
        // MARK Assumption getproductOrIngredientStatus()-> that ingredient is registered already if product id is there.
        // Create DB Search Object
        // Case A: product_id = yes & Ing_Id = Yes
        // Check in Table MAsterProducts
        // registered flag =true
        if (!productID.isEmpty)
        {
            print("inside product id check for status func name is =getProductOrIngredientStatus")
           // var masterProducts = DataController()
            var masterProducts = DataControllerCentral()
            
            var productStatus = masterProducts.createDBConnectionAndSearchFor("MasterProducts", columnName: "product_id", searchString: productID,filtered: true) as! [AAAMasterProductsMO]
            
            
            if (productStatus.count != 0){
                
                //if ((productStatus[0].valueForKey("h_status")?.isEqual("DNK")) != nil)
                if (productStatus[0].valueForKey("h_status")!.isEqual("DNK"))
                {
                    status = "DNK found"
                    return status
                }
                    
                else
                {
                    
                    status = productStatus[0].valueForKey("h_status") as! String
                    return status
                }
                
                
            }
        }
            
        else {
            print("inside ingredient id check for status func name is =getProductOrIngredientStatus")
            
            
           // var ingredientStatus = DataController()
            var ingredientStatus = DataControllerCentral()
            
            var ingredientStatusCheck = ingredientStatus.createDBConnectionAndSearchFor("Ingredients", columnName: "ingredient_id", searchString: ingredientID,filtered: true) as! [Ingredients]
            print("ingredientID is ::121: \(ingredientID)")
            print("ingredientStatusCheck Count is ::: \(ingredientStatusCheck.count )")
            
            if (ingredientStatusCheck.count != 0 )
            {
                print("ingredientStatusCheck Count is ::: \(ingredientStatusCheck.count )")
                status = ingredientStatusCheck[0].valueForKey("halal_status_detail") as! String
                return status
            }
        }
        
        
        // Case A: product_id = nil & Ing_Id = Yes
        
        // registered flag =false
        
        
        
        
        
        return status
        
    }
    
    
    
    func halalExtractStatus_DataController (halalStatusColumn: String) -> [String:String]
    {
        // set value to be entered in the db value column in halalStatusExtracted
        var halalStatusExtracted = DONOTKNOW
        var colorHalalStatus = String()
        var halalStatusReturn = [String : String]()
        // trim the text first
        var trimmedHalalStatus = halalStatusColumn.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        // length of the text
        var lengthHalalStatus = trimmedHalalStatus.characters.count
        
        var forComparisonHalalStatus = trimmedHalalStatus.lowercaseString
        
        
        if (lengthHalalStatus >= 8) {
            colorHalalStatus = mushboohColorText
            print ("True: (lengthHalalStatus >= 8) ---MUSHBOOH--- ")
            halalStatusExtracted = MUSHBOOH
        } else {
            
            
            if (lengthHalalStatus <= 5)
            {   // if halal
                if (forComparisonHalalStatus.containsString(HALAL.lowercaseString)) {
                    
                    halalStatusExtracted = HALAL
                    //halalStatusColumn.cont
                    colorHalalStatus = halalColorText
                    print ("True: (lengthHalalStatus <= 5)---HALAL--- ")
                    
                }
                    
                    // if haram
                else if (forComparisonHalalStatus.containsString(HARAM.lowercaseString)) {
                    halalStatusExtracted = HARAM
                    colorHalalStatus = haramColorText
                    print ("True: (lengthHalalStatus <= 5)---HARAM--- ")
                    
                    
                }
            }
            else if (lengthHalalStatus >= 5)
            {
                // if Mushbooh
                if (forComparisonHalalStatus.containsString(MUSHBOOH.lowercaseString))
                {
                    halalStatusExtracted = MUSHBOOH
                    colorHalalStatus = mushboohColorText
                    print ("True: (lengthHalalStatus >= 5)---MUSHBOOH--- ")
                    
                    
                }
            }
            else {
                
                
                colorHalalStatus = doNotKnowColorText
                halalStatusExtracted = DONOTKNOW
                print ("NO GREATER THAN 8 SO ---DONOTKNOW--- ")
            }
            
            // if do not know
            
        }
        
        
        
        halalStatusReturn = [ "length" : String(lengthHalalStatus), "trimmedHalalStatus" : trimmedHalalStatus , "color" : colorHalalStatus, "halalStatusExtracted" : halalStatusExtracted   ]
        return halalStatusReturn
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
    This code uses a file named "ProductsWithIngredientDB.sqlite" in the application's documents directory.
    */
    print("Inside DataController.swift:Directory for SQLITE is:\(docURL)")
    let storeURL = docURL.URLByAppendingPathComponent("ProductsWithIngredientDB.sqlite")
    do {
    try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
    } catch {
    fatalError("Error migrating store: \(error)")
    }
    }
    }
    */
    
}



