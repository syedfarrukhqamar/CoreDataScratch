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

class ViewController: UIViewController,UITableViewDelegate, NSXMLParserDelegate,NSFetchedResultsControllerDelegate,UITextFieldDelegate, BarcodeDelegate {
    
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
    // MARK Reset Constants Data
    let firstAddProductCode = "First Add Product Bar Code"
    //___fetch data end
    
    @IBOutlet weak var addProductsBarCode: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var halalStatusLabel: UILabel!
    
    @IBOutlet weak var productBarCodeDisplay: UILabel!
    var productBarCode = String()
    var productDBAdded = Bool()
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
    var fetchedIngredients = [Ingredients]()
    var centralDisplay = String()
    
    //var nItem: List? = nil
    
    
    @IBOutlet weak var eNumberEntered: UILabel!
    //@IBOutlet var eNumberEntered: UITextField!
    //MARK add all interface functions here
    
    @IBAction func aTyped(sender: UIButton) {
        centralDisplay = centralDisplay + "A"
        eNumberEntered.text = centralDisplay
        checkIngredientStatus ()
        
    }
    @IBAction func bTyped(sender: UIButton) {
        centralDisplay = centralDisplay + "B"
        eNumberEntered.text = centralDisplay
        checkIngredientStatus ()
    }
    
    @IBAction func cTyped(sender: UIButton) {
        centralDisplay = centralDisplay + "C"
        eNumberEntered.text = centralDisplay
        checkIngredientStatus ()
    }
    
    @IBAction func dTyped(sender: UIButton) {
        centralDisplay = centralDisplay + "D"
        eNumberEntered.text = centralDisplay
        checkIngredientStatus ()
    }
    
    @IBAction func eTyped(sender: UIButton) {
        centralDisplay = centralDisplay + "E"
        eNumberEntered.text = centralDisplay
        checkIngredientStatus ()
    }
    
    
    @IBAction func fTyped(sender: UIButton) {
        centralDisplay = centralDisplay + "F"
        eNumberEntered.text = centralDisplay
        checkIngredientStatus ()
    }
    // MARK E450A,B,C TYPED
    @IBAction func abcTyped(sender: UIButton) {
        centralDisplay = centralDisplay + "E450A,B,C"
        eNumberEntered.text = centralDisplay
        checkIngredientStatus ()
    }
    
    @IBAction func oneTyped(sender: UIButton) {
        centralDisplay = centralDisplay + "1"
        eNumberEntered.text = centralDisplay
        checkIngredientStatus ()
    }
    
    @IBAction func twoTyped(sender: UIButton) {
        centralDisplay = centralDisplay + "2"
        eNumberEntered.text = centralDisplay
        checkIngredientStatus ()
        
    }
    
    @IBAction func threeTyped(sender: UIButton) {
        centralDisplay = centralDisplay + "3"
        eNumberEntered.text = centralDisplay
        checkIngredientStatus ()
        
    }
    
    @IBAction func fourTyped(sender: UIButton) {
        centralDisplay = centralDisplay + "4"
        eNumberEntered.text = centralDisplay
        checkIngredientStatus ()
        
    }
    
    @IBAction func fiveTyped(sender: UIButton) {
        centralDisplay = centralDisplay + "5"
        eNumberEntered.text = centralDisplay
        checkIngredientStatus ()
        
    }
    
    @IBAction func sixTyped(sender: UIButton) {
        centralDisplay = centralDisplay + "6"
        eNumberEntered.text = centralDisplay
        checkIngredientStatus ()
        
    }
    
    @IBAction func sevenTyped(sender: UIButton) {
        centralDisplay = centralDisplay + "7"
        eNumberEntered.text = centralDisplay
        checkIngredientStatus ()
    }
    @IBAction func eight(sender: UIButton) {
        centralDisplay = centralDisplay + "8"
        eNumberEntered.text = centralDisplay
        checkIngredientStatus ()
    }
    
    @IBAction func nineTyped(sender: UIButton) {
        centralDisplay = centralDisplay + "9"
        eNumberEntered.text = centralDisplay
        checkIngredientStatus ()
    }
    
    @IBAction func zeroTyped(sender: UIButton) {
        centralDisplay = centralDisplay + "0"
        eNumberEntered.text = centralDisplay
        checkIngredientStatus ()
    }
    
    @IBAction func clearTyped(sender: UIButton) {
        centralDisplay = ""
        eNumberEntered.text = centralDisplay
        nameLabel.text = "Name"
        descriptionLabel.text = "Description"
        halalStatusLabel.text = "Halal / Haram / Mushbooh"
    }
    
    @IBAction func displayedText(sender: UITextField) {
        
        print("String being entered is :212:\(eNumberEntered.text)")
    }
    
    @IBAction func eNumberedTextValueChanged(sender: UITextField) {
        print("Value Changed is :\(eNumberEntered.text)")
    }
    func checkIngredientStatus () {
        
        var str = String()
        str = eNumberEntered.text!
        
        
        if str.characters.count >= 3 {
            // MARK searchin via action
            let strReturned: [Ingredients] = fetchResults(str)
            
            if strReturned.count == 0 {
                // Mark ingredient check Ingredient not found
                eNumberEntered.backgroundColor = UIColor.yellowColor()
                //eNumberEntered.selectedTextRange = eNumberEntered.textRangeFromPosition(eNumberEntered.beginningOfDocument, toPosition: eNumberEntered.endOfDocument)
            }
            else if strReturned.count >= 1 {
                
                var firstIngredientId: String = (strReturned.first?.valueForKey("ingredient_id"))! as! String
                var secondIngredientId: String = (strReturned.last?.valueForKey("ingredient_id"))! as! String
                print("firstIngredientId is ::: \(firstIngredientId)")
                print("if else has just started")
                
                
                
                if firstIngredientId == secondIngredientId
                {
                    var halalHaram: String = (strReturned.first?.valueForKey("halal_status"))! as! String
                    //let replaced = halalHaram.stringByReplacingOccurrencesOfString(" ", withString: "")
                    let replaced = halalHaram.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                    
                    let halal = "HALAL"
                    let haRaM = "HARAM"
                    print("count of replaced is : \(replaced.characters.count) ")
                    print("count of halal is : \(halal.characters.count) ")
                    print("count of halal is : \(haRaM.characters.count) ")
                    
                    
                    // let halal = "HALALHARAM"
                    
                    print("halalHaram :-:-: \(halalHaram)")
                    
                    // Change color of text box to green if Halal
                    if replaced.lowercaseString == halal.lowercaseString {
                        eNumberEntered.backgroundColor=UIColor.greenColor()
                        // MARK check if the ingredient is already registered
                        print("searchregisteredIngredient had been called and now it on next statement")
                        // MARK updating the labels on main screen accordingly
                        nameLabel.text = (strReturned.first?.valueForKey("name"))! as! String
                        descriptionLabel.text = (strReturned.first?.valueForKey("descryption"))! as! String
                        halalStatusLabel.text = (strReturned.first?.valueForKey("halal_status"))! as! String
                        halalStatusLabel.backgroundColor = UIColor.greenColor()
                        //var recIngredients = [AAAProductsWithIngredientsMO()]
                        //var temp = eNumberEntered.text!
                        //recIngredients =
                        searchRegisteredIngredient()
                        print("lowercasestring:: \(replaced.lowercaseString)")
                        
                        print("Halal has been found:: \(strReturned.first?.valueForKey("halal_status")!)")
                        
                        
                        
                        
                        
                    }
                        // Change color of text box to red if Haram
                        
                    else if replaced.lowercaseString == haRaM.lowercaseString {
                        eNumberEntered.backgroundColor=UIColor.redColor()
                        // MARK updating the labels on main screen accordingly
                        nameLabel.text = (strReturned.first?.valueForKey("name"))! as! String
                        descriptionLabel.text = (strReturned.first?.valueForKey("descryption"))! as! String
                        halalStatusLabel.text = (strReturned.first?.valueForKey("halal_status"))! as! String
                        halalStatusLabel.backgroundColor = UIColor.redColor()
                        searchRegisteredIngredient()
                        
                        
                        print("Haram has been found:: \(strReturned.first?.valueForKey("halal_status")!)")
                        
                    }
                        
                        // Change color of text box to Grey if Mushbooh or other
                    else if replaced != "HALAL" || halalHaram != "HARAM"{
                        eNumberEntered.backgroundColor=UIColor.grayColor()
                        // MARK updating the labels on main screen accordingly
                        nameLabel.text = (strReturned.first?.valueForKey("name"))! as! String
                        
                        halalStatusLabel.textColor = UIColor.whiteColor()
                        descriptionLabel.text = (strReturned.first?.valueForKey("descryption"))! as! String
                        halalStatusLabel.text = (strReturned.first?.valueForKey("halal_status"))! as! String
                        halalStatusLabel.backgroundColor = UIColor.grayColor()
                        searchRegisteredIngredient()
                        
                        print("Mushbooh or need to be checked has been found:: \(halalHaram.lowercaseString)")
                        
                    }
                    
                }
                
                
            }
            
            print ("strReturned value is : \(strReturned)")
        }
        
        
    }
    @IBAction func checkENumbers(sender: UITextField) {
        
        var str = String()
        str = eNumberEntered.text!
        
        
        if str.characters.count >= 3 {
            // MARK searchin via action
            let strReturned: [Ingredients] = fetchResults(str)
            
            if strReturned.count == 0 {
                // Mark ingredient check Ingredient not found
                eNumberEntered.backgroundColor = UIColor.yellowColor()
                //        eNumberEntered.selectedTextRange = eNumberEntered.textRangeFromPosition(eNumberEntered.beginningOfDocument, toPosition: eNumberEntered.endOfDocument)
            }
            else if strReturned.count >= 1 {
                
                var firstIngredientId: String = (strReturned.first?.valueForKey("ingredient_id"))! as! String
                var secondIngredientId: String = (strReturned.last?.valueForKey("ingredient_id"))! as! String
                print("firstIngredientId is ::: \(firstIngredientId)")
                print("if else has just started")
                
                
                
                if firstIngredientId == secondIngredientId
                {
                    var halalHaram: String = (strReturned.first?.valueForKey("halal_status"))! as! String
                    //let replaced = halalHaram.stringByReplacingOccurrencesOfString(" ", withString: "")
                    let replaced = halalHaram.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                    
                    let halal = "HALAL"
                    let haRaM = "HARAM"
                    print("count of replaced is : \(replaced.characters.count) ")
                    print("count of halal is : \(halal.characters.count) ")
                    print("count of halal is : \(haRaM.characters.count) ")
                    
                    
                    // let halal = "HALALHARAM"
                    
                    print("halalHaram :-:-: \(halalHaram)")
                    
                    // Change color of text box to green if Halal
                    if replaced.lowercaseString == halal.lowercaseString {
                        eNumberEntered.backgroundColor=UIColor.greenColor()
                        
                        print("Halal has been found:: \(strReturned.first?.valueForKey("halal_status")!)")
                        
                    }
                        // Change color of text box to red if Haram
                        
                    else if replaced.lowercaseString == haRaM.lowercaseString {
                        eNumberEntered.backgroundColor=UIColor.redColor()
                        print("Haram has been found:: \(strReturned.first?.valueForKey("halal_status")!)")
                        
                    }
                        
                        // Change color of text box to Grey if Mushbooh or other
                    else if replaced != "HALAL" || halalHaram != "HARAM"{
                        eNumberEntered.backgroundColor=UIColor.grayColor()
                        print("Mushbooh or need to be checked has been found:: \(halalHaram.lowercaseString)")
                        
                    }
                    
                }
                
                
            }
            
            print ("strReturned value is : \(strReturned)")
        }
        
        
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
      print("before app del")
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
      print("After app del")  
        //fetchResults()
        fetchRecords()
        // parser.delegate = self

        print("Parsing started::\(parser.parse())")
        //self.beginParsing()
        print("product records total count ---:\(productRecords.count)")
        
        print("posts records total count ---:\(posts.count)")
        // Mark remove it later
        print ("DB Saved Status:::::\(saveObjectsToDB())")
        // MARK checking new DB Connection function
        
        
        var connectToDBAndGet = DataController()
        
        
        
        //var productToAdd = NSEntityDescription.insertNewObjectForEntityForName("MasterProducts", inManagedObjectContext: context) as! AAAMasterProductsMO

        
//        var productToAdd = AAAMasterProductsMO()
        print ("Creating productToAdd-----999--")
        let productToAdd:[String:String] = ["h_status": "Test Status Dict","product_id":"3873","product_name":"Temp Name DIct","product_type":"Temp Type Dict"]
         print ("Created productToAdd-----999--")
//        productToAdd.setValue("Test Status", forKey: "h_status")
//        productToAdd.setValue("1111", forKey: "product_id")
//        productToAdd.setValue("Test Product", forKey: "product_name")
//        productToAdd.setValue("Test Type", forKey: "product_type")
        
        connectToDBAndGet.addRecordToProduct(productToAdd)
         print ("connectToDBAndGet----after---")
        
        
        var ingredients = connectToDBAndGet.createDBConnectionAndSearchFor("MasterProducts", columnName: "product_id", searchString: "3333") as! [AAAMasterProductsMO]
       
        
       print("DB Connection has been established and total count of result is::> \(ingredients.count)")
//
//        for index in 0..<ingredients.count {
//            print("Result is ::=\(ingredients[index].product_id)")
//          
//            
//        }
        
        
        
        connectToDBAndGet.registerIngredientToProduct("4021", ingredientID: "E450", h_status: "HALAL")
        
        
        
        // MARK TEmp adding products
        
        // MARK Delegate to centralDisplay
        // eNumberEntered.delegate = self
        
        
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
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("TextField did begin editing method called")
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return false
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
        
        
           }
    
    func fetchRecords() {
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let ingredientFetch = NSFetchRequest(entityName: "Ingredients")
        
        var fetchRequest = NSFetchRequest(entityName: "Ingredients")
        let sortDescriptor = NSSortDescriptor(key: "ingredient_id", ascending: true)
        let predicate = NSPredicate(format: "ingredient_id contains %@", "E101")
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        
        do {
            
            let fetchedIngredient = try context.executeFetchRequest(fetchRequest) as! [Ingredients]
            print ("fetched ingredients' count are :: \(fetchedIngredient.count)")
            
            
            // print ("fetched ingredients are ::  (fetchedIngredient.first!.valueForKey("ingredient_id")!)")
        }
        catch {
            print("Fatal Error: \(error)")
        }
        
    }
    
    // MARK DB Loading ::::xml to db Move
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
            newIngredient.setValue(productRecords[index].valueForKey("halal_status"), forKey: "halal_status")
            // print("Record # \(index)")
            
            // MARK DB Saving is switched off for now
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
    
    // MARK DB Record Insertion and Editing----Start
    func addProduct ()
    {
        
        // create db connection
        print("323a")
        var statusSave = Bool()
        print("323b")
        
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        print("323c")
        
        print("323d")
        let context: NSManagedObjectContext = appDel.managedObjectContext
        // var ing = AAAMasterProductsMO()
        print("323e")
        
        var newProduct = NSEntityDescription.insertNewObjectForEntityForName("MasterProducts", inManagedObjectContext: context) as! AAAMasterProductsMO
        
        print("323f")
        
        
        // print("Product_ID :::\(productRecords[index].valueForKey("ingredient_id"))")
        newProduct.setValue(productBarCode, forKey: "product_id")
        do {
            // print("trying to save records- BEFORE")
            try context.save()
            print("Product is saved\(productBarCode)")
            
            statusSave = true
        } catch let error {
            print("Could not cache the response \(error)")
            statusSave=false
            //    print("Here is productRecords::\(productRecords.count)")
            
            // return statusSave
        }
        
        
    }
    
    // DB Record Insertion and Editing-- end
    // MARK Search product BarCode if exists then do not add it if doesnt exist then add it-START------
    
    func searchProduct()
    {
        // Create Connection and get context
        //        var dataController = DataController()
        //        let context = dataController.managedObjectContext
        //        var newProduct = NSEntityDescription.insertNewObjectForEntityForName("MasterProducts", inManagedObjectContext: context) as! AAAMasterProductsMO
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let productFetch = NSFetchRequest(entityName:"MasterProducts")
        productFetch.predicate = NSPredicate(format: "%K Contains %@","product_id", productBarCode)
        var fetchedProducts = [AAAMasterProductsMO]()
        var statusSave = Bool()
        var ing = [AAAMasterProductsMO]()
        
        
        do {
            fetchedProducts = try context.executeFetchRequest(productFetch) as! [AAAMasterProductsMO]
            // context.executeFetchRequest(<#T##request: NSFetchRequest##NSFetchRequest#>)
            
            if fetchedProducts.count == 0
            {// if no product found then add the product
                addProduct()
                print("Product saved 999")
            }
                
                //            print("1 \(fetched)")
                
            else {
                print("Product is allready available ::: \(fetchedProducts.count)")
            }
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
        
        
    }
    // MARK Search product BarCode if exists then do not add it if doesnt exist then add it -END-------
    
    func fetchResults (eNUmValue: String)-> [Ingredients] {
//        print("eNumValue: \(eNUmValue)")
//        print("-FetchResults have been called up-1")
//        // let moc = self.managedObjectContext
//        print("fetchResults func 2")
//        //var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        //--------------------------------
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        //let ingredientsFetch = NSEntityDescription.insertNewObjectForEntityForName("Ingredients", inManagedObjectContext: context) as NSManagedObject
        let ingredientsFetch = NSFetchRequest(entityName: "Ingredients")
        //        print("fetchResults func  3")
        //        //let ingredient_id = "MUSHBOOH"
        //        print("fetchResults func 4")
        var eNum = eNUmValue
        ingredientsFetch.predicate = NSPredicate(format: "%K Contains %@","ingredient_id", eNum)
        //ingredientsFetch.predicate = NSPredicate(format: "ingredient_id like 'e'")
        //
        //        print("fetchResults func 5")
        var ingId = String()
        var fetched2 = String()
        var nme = String()
        var desc = String()
        var usgExm = String()
        
        do {
            fetchedIngredients = try context.executeFetchRequest(ingredientsFetch) as! [Ingredients]
            
            if fetchedIngredients.count == 0
            {
                
                return fetchedIngredients
            }
            ingId = (fetchedIngredients.first!.ingredient_id)!
            nme = (fetchedIngredients.first!.name)!
            desc = (fetchedIngredients.first!.descryption)!
            usgExm = (fetchedIngredients.first!.halal_status)!
            
            //            print("1 \(fetched)")
            
            print("Total Record Founds are:::: \(fetchedIngredients.count)")
            
            /*    var index = 1
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
            */
            // let one = try context.executeFetchRequest(ingredientsFetch). as! Ingredients
            
            
            //            print("one value is Please, in sha Allah :id:\(fetchedIngredients[100].ingredient_id)")
            //
            //            print("one value is Please, in sha Allah :id:\(fetchedIngredients[200].ingredient_id)")
            //
            //            print("one value is Please, in sha Allah :id:\(fetchedIngredients[300].ingredient_id)")
            //            print("one value is Please, in sha Allah :id:\(fetchedIngredients[400].ingredient_id)")
            //            print("one value is Please, in sha Allah :id:\(fetchedIngredients[800].ingredient_id)")
            //
            
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
        
        return fetchedIngredients
        
    }
    
    // MARK Search DB Functions
    // MARK Search Ingredients
    func searchIngredients (ingredientsID: String)-> [Ingredients]{
        //    //var dataController = DataController()
        //    //print("a11")
        ////        let context: NSManagedObjectContext = dataController.managedObjectContext    //let ingredientsFetch =
        ////    let ingredientsFetch = NSFetchRequest(entityName: "Ingredients")
        ////        print("b11")
        //        // create db connection
        //        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        //        let context: NSManagedObjectContext = appDel.managedObjectContext
        //        let ingredientsFetch = NSFetchRequest(entityName:"Ingredients")
        //    //    ingredientsFetch.predicate = NSPredicate(format: "%K Contains %@","ingredient_id", eNumberEntered.text!)
        //        print("checking value agains ::65\(eNumberEntered.text!)")
        //        var fetchedIngredients = [Ingredients]()
        //        var statusSave = Bool()
        //    //var eNum = ingredientsID
        //    ingredientsFetch.predicate = NSPredicate(format: "%K Contains %@","ingredient_id","ingredient_id" ,eNumberEntered.text!)
        
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let ingredientsFetch = NSFetchRequest(entityName:"Ingredients")
        ingredientsFetch.predicate = NSPredicate(format: "%K Contains %@","ingredient_id", ingredientsID)
        var fetchedProducts = [Ingredients]()
        var statusSave = Bool()
        var ing = [Ingredients]()
        
        var ingId = String()
        var fetched2 = String()
        var nme = String()
        var desc = String()
        var usgExm = String()
        var receivedIngredients = [Ingredients]()
        do {
            print("c11")
            
            receivedIngredients = try context.executeFetchRequest(ingredientsFetch) as! [Ingredients]
            print ("eNumbered.Text is \(ingredientsID)")
            if receivedIngredients.count == 0
            {
                print("d11")
                return receivedIngredients
            }
            ingId = (receivedIngredients.first!.ingredient_id)!
            nme = (receivedIngredients.first!.name)!
            desc = (receivedIngredients.first!.descryption)!
            usgExm = (receivedIngredients.first!.halal_status)!
            print("Total Record Founds are::8769:: \(receivedIngredients.count)")
        } catch {
            print("e11")
            fatalError("Failed to fetch employees: \(error)")
        }
        print("f11")
        return receivedIngredients
    }
    
    //Mark register ingredient to product start
    
    func registerIngredientToProduct (halalStatus: String)
    {
        
        // create db connection
        print("i323a")
        var statusSave = Bool()
        print("323b")
        
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        print("i323c")
        
        print("i323d")
        let context: NSManagedObjectContext = appDel.managedObjectContext
        // var ing = AAAMasterProductsMO()
        print("i323e")
        
        var registerIngredientAgainstProduct = NSEntityDescription.insertNewObjectForEntityForName("ProductsWithIngredients", inManagedObjectContext: context) as! AAAProductsWithIngredientsMO
        
        print("i323f")
        
        
        // print("Product_ID :::\(productRecords[index].valueForKey("ingredient_id"))")
        registerIngredientAgainstProduct.setValue(productBarCode, forKey: "prd_id")
        registerIngredientAgainstProduct.setValue(eNumberEntered.text, forKey: "ing_id")
        registerIngredientAgainstProduct.setValue(halalStatus, forKey: "name")
        do {
            // print("trying to save records- BEFORE")
            try context.save()
            print("Ingredient has been registered against product::\(productBarCode)")
            
            statusSave = true
            print("New ingredient has been registered i.e. ingredient id is : \(eNumberEntered.text)")
            print("Against the barcode is : \(productBarCode)")
            print("Againsta halal status i.e. : \(halalStatus)")
        } catch let error {
            print("Could not cache the response \(error)")
            statusSave=false
            //    print("Here is productRecords::\(productRecords.count)")
            
            // return statusSave
        }
        
        
    }
    // Mark register ingredient to product end
    
    func searchRegisteredIngredient() -> [AAAProductsWithIngredientsMO]{
        
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let registeredIngredientsToProductFetch = NSFetchRequest(entityName:"ProductsWithIngredients")
        registeredIngredientsToProductFetch.predicate = NSPredicate(format: "%K Contains %@","ing_id", eNumberEntered.text!)
        print ("98789checking against eNumberEntered.text!\(eNumberEntered.text!)")
        //print ("checking against eNumberEntered.text!\(eNumberEntered.text!)")
        
        var fetchedregisteredIngredientsToProduct = [AAAProductsWithIngredientsMO]()
        var statusSave = Bool()
        var registeredIngredientsToProducts = [AAAProductsWithIngredientsMO]()
        
        
        do {
            fetchedregisteredIngredientsToProduct = try context.executeFetchRequest(registeredIngredientsToProductFetch) as! [AAAProductsWithIngredientsMO]
            // context.executeFetchRequest(<#T##request: NSFetchRequest##NSFetchRequest#>)
            
            var index = 0
            for index = 0; index < 10; index++ {
                // print("3")
                //
                //                    if (fetchedregisteredIngredientsToProduct[index].ing_id == eNumberEntered.text! && fetchedregisteredIngredientsToProduct[index].prd_id == productBarCode )
                //                    {
                //                    print("fetchedregisteredIngredientsToProduct[index].ing_id   ::::\(fetchedregisteredIngredientsToProduct[index].ing_id)")
                //                    print("fetchedregisteredIngredientsToProduct[index].prd_id   ::::\(fetchedregisteredIngredientsToProduct[index].prd_id)")
                //                    }
                
                
                print("while condition one:\(fetchedregisteredIngredientsToProduct[index].ing_id)")
                print("condition one compare with: \(eNumberEntered.text!)")
                print("while condition TWO:\(fetchedregisteredIngredientsToProduct[index].prd_id)")
                print("condition one compare with: \(productBarCode)")
                
                //  println(numbers[index])
            }
            
            
            
            if fetchedregisteredIngredientsToProduct.count == 0
            {// if no product found then add the product
                addProduct()
                print("Product saved 999")
                return fetchedregisteredIngredientsToProduct
            }
                
                //            print("1 \(fetched)")
                
            else {
                print("Product is allready available ::: \(fetchedregisteredIngredientsToProduct.count)")
                return fetchedregisteredIngredientsToProduct
            }
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
        return fetchedregisteredIngredientsToProduct
        
        
        //
        //        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        //        let context: NSManagedObjectContext = appDel.managedObjectContext
        //
        //        let productFetch = NSFetchRequest(entityName:"MasterProducts")
        //        productFetch.predicate = NSPredicate(format: "%K Contains %@","product_id", productBarCode)
        //        var fetchedProducts = [AAAMasterProductsMO]()
        //        var statusSave = Bool()
        //        var ing = [AAAMasterProductsMO]()
        //
        //
        //        do {
        //            fetchedProducts = try context.executeFetchRequest(productFetch) as! [AAAMasterProductsMO]
        //            // context.executeFetchRequest(<#T##request: NSFetchRequest##NSFetchRequest#>)
        //
        //            if fetchedProducts.count == 0
        //            {// if no product found then add the product
        //                addProduct()
        //                print("Product saved 999")
        //            }
        //
        //                //            print("1 \(fetched)")
        //
        //            else {
        //                print("Product is allready available ::: \(fetchedProducts.count)")
        //            }
        //        } catch {
        //            fatalError("Failed to fetch employees: \(error)")
        //        }
        //
        //
        //
    }
    
    // MArk Search Products
    
    
    
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
        entity.setValue("seed usage", forKey: "halal_status")
        do{
            try moc.save()
            
        }
        catch {
            fatalError("Failure to save error \(error)")
        }
    }
    
    // MARK text field delegates
    
    // MARK BARCODE reading
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Segue!")
        
        let barcodeViewController: BarcodeViewController = segue.destinationViewController as! BarcodeViewController
        barcodeViewController.delegate = self
        
    }
    
    func barcodeReaded(barcode: String) {
        print("Barcode leido: \(barcode)")
        productBarCodeDisplay.text = "Product:" + barcode
        productBarCode = barcode
        //MARK SearchProduct
        searchProduct()
        
        // codeTextView.text = barcode
    }
    
    
}

