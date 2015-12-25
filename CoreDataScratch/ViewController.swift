//
//  ViewController.swift
//  CoreDataScratch
//
//  Created by syed farrukh Qamar on 18/12/15.
//  Copyright © 2015 Be My Competence AB. All rights reserved.
//

import UIKit
import CoreData
//import DataController

class ViewController: UIViewController,UITableViewDelegate, NSXMLParserDelegate,NSFetchedResultsControllerDelegate {
    
    //--MARK Fetching Data
    
//    lazy var fetchedResultsController: NSFetchedResultsController = {
//        let ingredientsFetchRequest = NSFetchRequest(entityName: "Ingredients")
//        let primarySortDescriptor = NSSortDescriptor(key: "ingredient_id", ascending: true)
//        let secondarySortDescriptor = NSSortDescriptor(key: "name", ascending: true)
//        ingredientsFetchRequest.sortDescriptors = [primarySortDescriptor, secondarySortDescriptor]
//        
//        let frc = NSFetchedResultsController(
//            fetchRequest: ingredientsFetchRequest,
//            managedObjectContext: self.context,
//            sectionNameKeyPath: "name",
//            cacheName: nil)
//        
//        frc.delegate = self
//        
//        return frc
//    }()
    
    //___fetch data end
    var parser = NSXMLParser()
    // Mark temp
    var posts = NSMutableArray()
    var productRecords = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    // remove them later- Temp-start
    var title1 = NSMutableString()
    var date = NSMutableString()
    // remove them later- Temp-End
    var desc = NSMutableString()
    var ingredient_id = NSMutableString()
    var halal_status = NSMutableString()
    var name = NSMutableString()
    // MARK Core data settings
    let context1 = (UIApplication.sharedApplication().delegate as!AppDelegate).managedObjectContext
    
    
    //var nItem: List? = nil
    
    
    @IBOutlet var eNumberEntered: UITextField!
    @IBAction func btnLoad(){
    
        
        
  //   = "Load Button Pressed"
     print("Fetch results have been called 787")
        fetchResults()
     print("Fetch results have been called 888")
        print("User name is :: \(eNumberEntered.text)")
        
        print("Product Records available are :: \(productRecords.count)")
        
//Moving this section to viewDidLoad-Start
//        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//        var context: NSManagedObjectContext = appDel.managedObjectContext
//        
//        var newIngredient = NSEntityDescription.insertNewObjectForEntityForName("Ingredients", inManagedObjectContext: context) as NSManagedObject
//            newIngredient.setValue("Halal", forKey: "ingredient_id")
//            newIngredient.setValue("Halal", forKey: "name")
//            newIngredient.setValue("Halal", forKey: "descryption")
//            newIngredient.setValue("Halal", forKey: "usage_example")
//        do {
//            try context.save()
//        } catch let error {
//            print("Could not cache the response \(error)")
//        }
//        print("newIngredient")
//        print(newIngredient)
//        print("Object Saved")
//         //____Moving this section to viewDidLoad-end
    
        
    }
    
    // Mark: ENumber.Search
    
    @IBAction func eNumberSearch(sender: AnyObject) {
    }
    
    
    override func viewDidLoad() {
       
    
        super.viewDidLoad()
        // MARK Seed Ingredients
        //seedIngredients()
        
        let urlpath = NSBundle.mainBundle().pathForResource("temp", ofType: "xml")
        let url:NSURL = NSURL.fileURLWithPath(urlpath!)
        parser = NSXMLParser(contentsOfURL: url)!
        parser.delegate = self
        self.beginParsing()
        
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        fetchResults()
        fetchRecords()
       // parser.delegate = self
        
         print("Parsing started::\(parser.parse())")
        //self.beginParsing()
        print("product records total count ---:\(productRecords.count)")
        
        print("posts records total count ---:\(posts.count)")
        // Mark remove it later
        print ("DB Saved Status:::::\(saveObjectsToDB())")
        
// MARK Need Fixing : above xml parsing has some errors
        
        
        
//        do {
//            try fetchedResultsController.performFetch()
//            
//        } catch {
//            print("An error occurred")
//            
//        }

        
        
        //  fetchResults()
        
        // MARK Functions Parser are here-Start
        
        
        
        // MARK Functions Parser are here-End
        
                //test 1 is ending here
        // var dataControl = DataController()
       

        //MARK SQLLITE DB Loading started from xml
        
       // print("newIngredient")
       // print(newIngredient)
       // print("Object Saved")
       // print("the objects::::\(productRecords.objectsAtIndex(indexPath.row)")
        
       // productRecords.objectAtIndex(indexPath.row).valueForKey("name") as! NSString as String
        
//        print("PRODUCT COUNTS IS:\(productRecords.lastObject)")
//       print("Product Records are going to be printed\(productRecords.valueForKey("halal_status"))")
//     
//        var str = productRecords.objectAtIndex(2).valueForKey("name") as! NSString as String
//        print ("----\(str)")
//       // print("\(productRecords.objectAtIndex(0))")
        
       // posts.objectAtIndex(indexPath.row).valueForKey("date") as! NSString as String
        //MARK SQLLITE DB Loading started from xml-Ended
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
// MARK: All parsing work
    func beginParsing()
    {
        
        // Mark temp
      
        print("setting up posts and product records to zero---start---")
       
        posts = []
        productRecords = []
        
        print("setting up posts and product records to zero---end---")
        
        // print("before -101-parser")
       
          // parser = NSXMLParser(contentsOfURL:(NSURL(string:"http://images.apple.com/main/rss/hotnews/hotnews.rss"))!)!
        // var urlString = "http://72.41.35.93/xml/temp.xml"
        //  var urlString = "temp.xml"
        
        //NSURL: *url = [NSURL URLWithString:urlString];
        //  let url = NSURL(string: "https://72.41.35.93/xml/hotnews.rss")
        //parser = NSXMLParser(contentsOfURL:(url)!)!
        //        http://72.41.35.93/xml/temp.xml
        print("after parser")
        print("\(parser.parse())")
        
        parser.delegate = self
        print("After Delegate")
        //  tbData!.reloadData()
    }
    
    //XMLParser Methods
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        //print("element Name ::\(elementName)")
        element = elementName
        if (elementName as NSString).isEqualToString("Table1")
        {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            date = NSMutableString()
            date = ""
            
            //reset
            ingredient_id = NSMutableString()
            ingredient_id = ""
            name = NSMutableString()
            name = ""
            halal_status = NSMutableString()
            halal_status = ""
            desc = NSMutableString()
            desc = ""
            
           // print("title1 is ::\(title1)")
            
        }
    }
    
     func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqualToString("Table1") {
            if !ingredient_id.isEqual(nil) {
                elements.setObject(ingredient_id, forKey: "ingredient_id")
                print("ingredient id is :::::::\(ingredient_id)")
            }
            if !name.isEqual(nil) {
                elements.setObject(name, forKey: "name")
                print("Name is :::::::\(name)")
            }
            if !desc.isEqual(nil) {
                elements.setObject(desc, forKey: "description")
                print("Desc is :::::::\(desc)")
            }
            if !halal_status.isEqual(nil) {
                elements.setObject(halal_status, forKey: "halal_status")
                print("Halal_Status is :::::::\(halal_status)")
            }
            
           
            productRecords.addObject(elements)
            print("Count of Product Records is :: \(productRecords.count)")
            posts.addObject(elements)
            
        }
   // return posts.count
        
    }
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        
        if element.isEqualToString("ingredient_id") {
            
            ingredient_id.appendString(string)
            
            
        } else if element.isEqualToString("description") {
            desc.appendString(string)
        }
        else if element.isEqualToString("name") {
            name.appendString(string)
        }
        else if element.isEqualToString("halal_status") {
            halal_status.appendString(string)
        }
        
        
        
        
//        if element.isEqualToString("Table1") {
//            title1.appendString(string)
//            
//            
////            if !string.isEmpty{
////                
////                print("real values are here:\(string)")
////                
////                print("String index is \(string.endIndex)")
////            }
//        }
//        else if element.isEqualToString("ingredient_id"){
//        ingredient_id.appendString(string)
//        }
//        else if element.isEqualToString("name"){
//        name.appendString("name")
//        
//        }
//        
//        else if element.isEqualToString("descryption"){
//        desc.appendString(string)
//        
//        } else if element.isEqualToString("halal_status"){
//        
//        halal_status.appendString(string)
//        }
//        
//        
//        else if element.isEqualToString("pubDate") {
//            date.appendString(string)
//        }
    }
    
    func fetchRecords() {
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
    let ingredientFetch = NSFetchRequest(entityName: "Ingredients")
        
    
        do {
        
         let fetchedIngredient = try context.executeFetchRequest(ingredientFetch) as! [Ingredients]
            print ("fetched ingredients are :: \(fetchedIngredient)")
        }
        catch {
        print("Fatal Error: \(error)")
        }
    
    }
    func saveObjectsToDB ()
    {
        
        print("about to save object which has count of \(productRecords.count)")
        // print("about to save object which has count of \(productRecords)")
        
        var statusSave = Bool()
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        var ing = [Ingredients]()
        
        print("Just before for loop to save the records::\(productRecords.count)")
       
        
        for index in 1..<productRecords.count
            
        {
            
            
            var newIngredient = NSEntityDescription.insertNewObjectForEntityForName("Ingredients", inManagedObjectContext: context) as! Ingredients
            
            print("Ingredient_ID :::\(productRecords[index].valueForKey("ingredient_id"))")
            newIngredient.setValue(productRecords[index].valueForKey("ingredient_id"), forKey: "ingredient_id")
            print("Ingredient_ID set value is:::\(newIngredient.valueForKey("ingredient_id")!)")
            
            print("iteration\(productRecords[index].valueForKey("name"))")
            newIngredient.setValue(productRecords[index].valueForKey("ingredient_id"), forKey: "ingredient_id")
            newIngredient.setValue(productRecords[index].valueForKey("name"), forKey: "name")
            newIngredient.setValue(productRecords[index].valueForKey("description"), forKey: "descryption")
            newIngredient.setValue(productRecords[index].valueForKey("halal_status"), forKey: "usage_example")
           // print("Record # \(index)")
            
          
//            do {
//               // print("trying to save records- BEFORE")
//                try context.save()
//               // print("trying to save records-AFTER")
//                
//                statusSave = true
//            } catch let error {
//                print("Could not cache the response \(error)")
//                statusSave=false
//                print("Here is productRecords::\(productRecords.count)")
//                
//               // return statusSave
//            }
//
           // print("Here is productRecords::\(productRecords)")
            
            
            
        }
       
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        print("App Path: \(dirPaths)")
        
     //   print("\(productRecords[1])")
        
       // print("newIngredient")
       // print(newIngredient)
//        print("Object Saved")
//        print("\(productRecords[1].valueForKey("ingredient_id"))")
//        
        
        //return statusSave
    }
    
    
    func fetchResults ()  {
        
        print("-FetchResults have been called up-1")
        // let moc = self.managedObjectContext
        print("fetchResults func 2")
        //var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        //--------------------------------
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        //let ingredientsFetch = NSEntityDescription.insertNewObjectForEntityForName("Ingredients", inManagedObjectContext: context) as NSManagedObject
        let ingredientsFetch = NSFetchRequest(entityName: "Ingredients")
//        print("fetchResults func  3")
//        //let ingredient_id = "MUSHBOOH"
//        print("fetchResults func 4")
//        //     ingredientsFetch.predicate = NSPredicate(format: "ingredient_id == %@", ingredient_id)
//        //ingredientsFetch.predicate = NSPredicate(format: "ingredient_id like 'e'")
//        
//        print("fetchResults func 5")
        do {
            let fetchedIngredients = try context.executeFetchRequest(ingredientsFetch) as! [Ingredients]
            var a = 1
            print("6")
            print ("Total count at 1012AM is : \(fetchedIngredients[0].ingredient_id)")
            print ("Total count at 1014AM is : \(productRecords.count)")
            
            var index = 1
            while index < fetchedIngredients.count {
                // print("3")
                if fetchedIngredients[index].ingredient_id != nil {
                    print("one value is Please, in sha Allah :id:\(fetchedIngredients[index].ingredient_id!)")
                    print("one value is Please, in sha Allah :id:\(fetchedIngredients[index].name!)")
                    print("one value is Please, in sha Allah :id:\(fetchedIngredients[index].descryption!)")
                    print("one value is Please, in sha Allah :id:\(fetchedIngredients[index].usage_example!)")
                    print("Record # is \(a++)")
                }
                
                //  println(numbers[index])
                index++ }
            // let one = try context.executeFetchRequest(ingredientsFetch). as! Ingredients
            
            
            //            print("one value is Please, in sha Allah :id:\(fetchedIngredients[100].ingredient_id)")
            //
            //            print("one value is Please, in sha Allah :id:\(fetchedIngredients[200].ingredient_id)")
            //
            //            print("one value is Please, in sha Allah :id:\(fetchedIngredients[300].ingredient_id)")
            //            print("one value is Please, in sha Allah :id:\(fetchedIngredients[400].ingredient_id)")
            //            print("one value is Please, in sha Allah :id:\(fetchedIngredients[800].ingredient_id)")
            //
            
            print("test:::Count:::\(fetchedIngredients.count)")
            print("test:::Count:::\(fetchedIngredients.first)")
            
            print("end")
            
            
        } catch {
            print("inside catch")
            fatalError("Failed to fetch employees: \(error)")
        }
        
        print("just after catch in viewDidLoad")
        
    }
    
    /*
let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        //var newIngredient = NSEntityDescription.insertNewObjectForEntityForName("Ingredients", inManagedObjectContext: context) as NSManagedObject
        print("-------2")

        let request = NSFetchRequest(entityName: "Ingredients")
//        let primarySortDescriptor = NSSortDescriptor(key: "ingredient_id", ascending: true)
//        let secondarySortDescriptor = NSSortDescriptor(key: "name", ascending: true)
//        request.sortDescriptors = [primarySortDescriptor, secondarySortDescriptor]
//       let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "ingredient_id", cacheName: nil)
//        
//        frc.delegate = self
      //  print("frc value is 323:::\(frc)")
        
        
//        let predicate = NSPredicate(format: "'ingredient_id' == %@", "636")
//        let resultPredicate = NSPredicate(format: "halal_status [c] %@", "MUSHBOOH")
//        
        //
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(lastName like[cd] %@) AND (birthday > %@)",lastNameSearchString, birthdaySearchDate]
        
        print("-------3")

        var list = NSMutableArray()
        do {
            print("-------4")

           let searchString = "M"
//            let predicate = NSPredicate(format: "SELF contains %@", searchString)
//            
            //let searchDataSource = dataSource.filter { predicate.evaluateWithObject($0) }

            
           // request.predicate = NSPredicate(format: "SELF contains %@", searchString)

            print("-------5")
        

            let fetchedResults = try context.executeFetchRequest(request)
            print("Number of objects it has brought : \(fetchedResults.count)")
            print("-------6")

//            let ingredients = fetchedResults.first as! Ingredients
//            
//            print("The value of Entity is \(ingredients)")
            //                    print("-------1")

            
        }
        catch let error as NSError {
        
        print ("Failure")
        }
        
        
        print ("inside fetch request::()")
    
    }
   // return fetchedResults
    */
    func seedIngredients (){
    
    let moc     = DataController().managedObjectContext
    let entity  = NSEntityDescription.insertNewObjectForEntityForName("Ingredients", inManagedObjectContext: moc) as! Ingredients
    entity.setValue("seed_id", forKey: "ingredient_id")
    entity.setValue("Seed Name", forKey: "name")
    entity.setValue("seed Desc", forKey: "descryption")
    entity.setValue("seed usage", forKey: "usage_example")
        do{
        try moc.save()
        
        }
        catch {
        fatalError("Failure to save error \(error)")
            
        }
        
    }

}

