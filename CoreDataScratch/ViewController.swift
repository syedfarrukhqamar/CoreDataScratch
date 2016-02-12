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

let productHStatus = "DNK"
let HALAL = "HALAL"
let HARAM = "HARAM"
let MUSHBOOH = "MUSHBOOH"
let DONOTKNOW = "DNK"
// UI Colors global for changing colors to default response based on different statuses
// Halal
let halal_BG_Color = UIColor.greenColor()
let halal_Text_Color = UIColor.blackColor()
// Haram
let haram_BG_Color = UIColor.redColor()
let haram_Text_Color = UIColor.whiteColor()
// Mushbooh
let mushbooh_BG_Color = UIColor.grayColor()
let mushbooh_Text_Color = UIColor.whiteColor()
// Do NOT Know
let doNotKnow_BG_Color = UIColor.blueColor()
let doNotKnow_Text_Color = UIColor.blackColor()
// let Default colors
let default_BG_Color = UIColor.lightGrayColor()
let default_Text_Color = UIColor.blackColor()

// segues handling

var autoBarCodeDetected = false


// halal Haram status colors

let halalColorText = "Green"
let haramColorText = "Red"
let mushboohColorText = "Orange"
let doNotKnowColorText = "Blue"

// For table view controller Global Variables
let ingredientsBasedAll = "ALL_ING_BASED"
let productBasedIngredients = "PRD_BASED_ING"
var pullIngredientsScope = String()


var registeredIngredient = false
let productLevelForStatus = "Prd-LEVEL"
let ingredientLevelForStatus = "Ing-LEVEL"
var displayShow = false
var productBarCodeGlobal = ""

var ing_name = String()
var ing_descryption = String()
var showFilteredIngredients = Bool()
// MARK app setting variables and constants
// DB
var dbLoadedStatus_atAppLaunch = false
var dbLoadedStatus_atViewRefresh = false

class ViewController: UIViewController,UITableViewDelegate, NSXMLParserDelegate,UITextFieldDelegate, BarcodeDelegate {
    var managedObjectContext: NSManagedObjectContext!
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
    
    @IBOutlet weak var homeNavigationBar: UINavigationBar!
    @IBOutlet weak var addProductsBarCode: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var halalStatusLabel: UILabel!
    
    @IBOutlet weak var productBarCodeDisplay: UILabel!
    @IBOutlet weak var eNumberEntered: UILabel!
    
    @IBOutlet weak var navigationHome: UINavigationItem!
    //@IBOutlet var eNumberEntered: UITextField!
    // MARK Constants
    
    // MARK Variables: View Controller Level
    // MARK: Display Color Variables
    
    var bgColorDefaultButton = UIColor()
    var bgColorViewController = UIColor()
    var bgColorNameLabel = UIColor()
    var bgColorDescryptionLabel = UIColor()
    var bgColorHalalStatusLabel = UIColor()
    var bgColorENumberEntered = UIColor()
    
    
    var productBarCode = ""
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
    var halal_status_detail = NSMutableString()
    var halal_haram_flag = NSMutableString()
    
    var name = NSMutableString()
    // MARK Core data settings
    // let context1 = (UIApplication.sharedApplication().delegate as!AppDelegate).managedObjectContext
    var fetchedIngredients = [Ingredients]()
    var centralDisplay = String()
    
    //var nItem: List? = nil
    
    // mark: register ingredients code
    
    @IBAction func registerIngredient(sender: UIButton) {
        // get the ingredients h_status from the global? variable
        
        // MARK : Work left. need to change to DB values insteead of label values
        
        var registerIngredientToProductInDB =  DataController()
        
        
        //registerIngredientToProductInDB.registerIngredientToProduct(productBarCode, ingredientID: eNumberEntered.text!, h_status: halalStatusLabel.text!)
        print("product bar code global's value is  \(productBarCodeGlobal)")
        
        registerIngredientToProductInDB.registerIngredientToProduct(productBarCodeGlobal,ingredientID: eNumberEntered.text!, h_status: halalStatusLabel.text!,ing_name : nameLabel.text!,ingredient_descryption: descriptionLabel.text!)
        
        
        //        registerIngredientToProductInDB.registerIngredientToProduct(<#T##productID: String##String#>, ingredientID: <#T##String#>, h_status: <#T##String#>, ing_name: <#T##String#>, ingredient_descryption: <#T##String#>)
        //
        //        registerIngredientToProductInDB.registerIngredientToProduct(<#T##productID: String##String#>, ingredientID: <#T##String#>, h_status: <#T##String#>, ing_name: <#T##String#>, ingredient_descryption: <#T##String#>)
        
        
        
        
        
    }
    
    // exit view test
    
    @IBAction func cancelToPlayersViewController(segue:UIStoryboardSegue) {
        print("segue-____\(segue.identifier)")
    }
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue)
    {
        
        let productEnteredView = unwindSegue.sourceViewController as? AddProductManuallyController
        
        checkProduct((productEnteredView?.productBarCodeEnteredManually.text!)!)
        productBarCodeGlobal = ""
        productBarCodeGlobal = productEnteredView!.productBarCodeEnteredManually.text!
        
        print("productEnteredView?.productBarCodeEnteredManually-----\(productEnteredView?.productBarCodeEnteredManually.text!)")
        
        
        
    }
    // MARK: Func= this function take values entered on screen for product as BarCod
    // it checks if the product is available in db , if not then it adds it
    // then it gets the product as an object
    // extracts the status of the product i.e. h:status
    // then hand over these values to changeStatus Display and changes accordingly
    // this will be called at all those places which are taking product value and wants to change the status as well
    
    func checkProduct (barCodeEntered: String)
    {
        
        productBarCodeDisplay.text = barCodeEntered
        productBarCode = barCodeEntered
        productBarCodeGlobal = barCodeEntered
        let productFound = searchProduct()
        // change the status based on the product received
        
        print("productCheck Function called.productFound status is = \(productFound.h_status!)")
        
        if (productFound.h_status != nil) {
            
            changeDisplayStatus(productFound.h_status!, productOrIngredientLevel: productLevelForStatus )
        }
        else {
            
            changeDisplayStatus(productHStatus, productOrIngredientLevel: productLevelForStatus)
        }
    }
    // exit view test end
    // MARK Exit from Add Manuall Product Scene
    @IBAction func cancelToMoveToViewController(segue:UIStoryboardSegue) {
    }
    @IBAction func UpdateProductBarCodeDisplayAndMoveToViewController(segue:UIStoryboardSegue) {
        //     productBarCodeGlobal =
        productBarCodeDisplay.text = productBarCodeGlobal
        
        
        print("manually entered text of product code is ::::\(productBarCodeGlobal)")
        print("Product id label is  ::::\(productBarCodeDisplay.text)")
    }
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
    // MARK: Clearing Products and ingredients
    
    @IBAction func clearProductsAndIngredients(sender: AnyObject) {
        masterReset(productLevelForStatus)
    }
    
    // MARK: Clearing ingredients
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
        
        masterReset (ingredientLevelForStatus)
        
        //        centralDisplay = ""
        //        eNumberEntered.text = centralDisplay
        //        nameLabel.text = "Name"
        //        descriptionLabel.text = "Description"
        //        halalStatusLabel.text = "Halal / Haram / Mushbooh"
    }
    
    @IBAction func displayedText(sender: UITextField) {
        
        print("String being entered is :212:\(eNumberEntered.text)")
    }
    
    @IBAction func eNumberedTextValueChanged(sender: UITextField) {
        print("Value Changed is :\(eNumberEntered.text)")
    }
    
    func checkIngredientStatus () {
        
        //MARK ingredient instant reset is temporarily switched off
        
        //print("displayShow is ::before: \(displayShow)")
        
        //        if (displayShow == true)
        //
        //     {
        //     var eNumberedTemp = eNumberEntered.text
        //        print("displayShow is ::: \(displayShow)")
        //        masterReset(ingredientLevelForStatus)
        //        displayShow = false
        //        eNumberEntered.text = eNumberedTemp
        //        }
        //
        var str = ""
        print("str last value is ::: \(str)")
        
        
        str = eNumberEntered.text!
        print("str updated value is ::: \(str)")
        
        if str.characters.count >= 3 {
            // check for the ingredient or product status via Data Controller status funciton
            
            var dbCheckHalalStatus = DataController()
            print("Calling status check function viewcontroller.checkIngredients() eNumber Entered is:\(str)")
            var halalStatusFromDB = dbCheckHalalStatus.getProductOrIngredientStatus(productBarCode, ingredientID: str)
            
            print("halal Status from db for the above eNumber ENtered is ::\(halalStatusFromDB)")
            changeDisplayStatus(halalStatusFromDB, productOrIngredientLevel: ingredientLevelForStatus)
            
            print("changeDisplayStatus(halalStatusFromDB, productOrIngredientLevel: ingredientLevelForStatus)----Called")
            var ingredientFound = dbCheckHalalStatus.createDBConnectionAndSearchFor("Ingredients", columnName: "ingredient_id", searchString: str,filtered: true) as! [Ingredients]
            print("ingredients found 181:: \(ingredientFound.count)")
            
            
            if (ingredientFound.count != 0){
                // Mark Display Label's changes on the basis of ingredient info
                descriptionLabel.text = ingredientFound[0].valueForKey("descryption") as! String
                nameLabel.text = ingredientFound[0].valueForKey("name") as! String
                halalStatusLabel.text = ingredientFound[0].valueForKey("halal_haram_flag") as! String
                ing_name = nameLabel.text!
                ing_descryption = descriptionLabel.text!
            }
        }
       }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print ("count 1 __::\(autoBarCodeDetected)")
        print ("managed object value is  __::\(self.managedObjectContext)")
        
        self.navigationController?.navigationBar.hidden = false
        self.navigationItem.hidesBackButton = true
        if (autoBarCodeDetected == true){
            
            checkProduct(productBarCodeGlobal)
            productBarCodeDisplay.text = productBarCodeGlobal
            
            print("productBarCodeGlobal-----\(productBarCodeGlobal)")
            
            
            
            autoBarCodeDetected = false
        }

        
        
        
        
        // MARK app level db loading check 
        // dbstatus flag would be initiated with false value so that app check
        
        // MARK check if the db is already loaded or not
        // once loaded the flag would be set to true and then next time when the view is being loaded the check willnt be run through
        //
        //homeNavigationBar.hidden = true

        print ("-----appLevel------------db status at view controllers didload method =\(dbLoadedStatus_atAppLaunch)")
        print ("--------ViewLevel---------db status at view controllers didload method =\(dbLoadedStatus_atViewRefresh)")

        if (dbLoadedStatus_atAppLaunch == false){
            
            
            if (dbLoadedStatus_atViewRefresh == false){
       
                var connectToDBAndGet = DataController()
                var checkDBStatus = connectToDBAndGet.createDBConnectionAndSearchFor("DB_Log", columnName: "status", searchString: "Loaded", filtered: true) as! [AAADB_LogMO]
               
        print ("----viewControllers-----check db status result is = \(checkDBStatus.count)")
                
                if (autoBarCodeDetected == true){
            
                checkProduct(productBarCodeGlobal)
                productBarCodeDisplay.text = productBarCodeGlobal
                    
                print("productBarCodeGlobal-----\(productBarCodeGlobal)")
                    
                
                
                autoBarCodeDetected = false
                }
                if (checkDBStatus.count == 0)
                {
        // MARK Seed Ingredients
        //seedIngredients()
        
        let urlpath = NSBundle.mainBundle().pathForResource("temp", ofType: "xml")
        let url:NSURL = NSURL.fileURLWithPath(urlpath!)
        parser = NSXMLParser(contentsOfURL: url)!
        parser.delegate = self
        self.beginParsing()
        print("before app del")
       //---replacing on 10th Of Feb
        // var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        print("After app del")
        //fetchResults()
        fetchRecords()
        parser.delegate = self
        
        print("Parsing started::\(parser.parse())")
        
        
        print("product records total count --565-:\(productRecords.count)")
        
        print("posts records total count --565-:\(posts.count)")
        // Mark DB Saving of xml to DB is switched off for now later add some logic based on business logic what to do and how to maintain db for keeping data. should it be on the cloud or individual etc
        print ("DB Saved Status:::565::\(saveObjectsToDB())")
        // MARK checking new DB Connection function
         //MARK beginParsing function will reset all the variables
        //MARK BeginParsing Usage: use it after saving records to the db and parsing. else nothing will be saved to db
        
        self.beginParsing()
         //var productToAdd = NSEntityDescription.insertNewObjectForEntityForName("MasterProducts", inManagedObjectContext: context) as! AAAMasterProductsMO
          //        var productToAdd = AAAMasterProductsMO()
        print ("Creating productToAdd-----999--")
        let productToAdd:[String:String] = ["h_status": productHStatus,"product_id":"1234","product_name":"Temp Name DIct","product_type":"Temp Type Dict"]
        print ("Created productToAdd-----999--")
        connectToDBAndGet.addRecordToProduct(productToAdd)
        print ("connectToDBAndGet----after---")
        var ingredients = connectToDBAndGet.createDBConnectionAndSearchFor("Ingredients", columnName: "ingredient_id", searchString: "E127",filtered: true) as! [AAAMasterProductsMO]
        print("DB Connection has been established and total count of result is:111:> \(ingredients.count)")
        // MARK need to change strings to the real variables to add required perfectly
        
        //connectToDBAndGet.registerIngredientToProduct("878", ingredientID: "WE32", h_status: "HALAL")
        
        // MARK getting the status via new getproductOrIngredientStatus Function
        
        var statusProductOrIngredient = connectToDBAndGet.getProductOrIngredientStatus("", ingredientID: "E127")
        
        print("Status of Product or Ingredient has been reported as :: \(statusProductOrIngredient)")
                    // MARK: db change status to Loaded
                   var loadDB = DataController()
                    var dbLoadingStatus = loadDB.updateDB()
                    print ("db loading status in view controller is :: \(dbLoadingStatus)")
     } // db check on  table level if it has been loaded or not
            
            dbLoadedStatus_atViewRefresh = true
            } // db check at view refresh ended here
        dbLoadedStatus_atAppLaunch = true
        }// db check at app launch ended here
    }
    
    
    func viewWillAppear() {
        super.viewWillAppear(true)
        
        checkProduct(productBarCodeGlobal)
       productBarCodeDisplay.text = productBarCodeGlobal
        
        print("viewWillAppear() ----\(productBarCodeGlobal)")
        if (autoBarCodeDetected == true){
            
            checkProduct(productBarCodeGlobal)
            productBarCodeDisplay.text = productBarCodeGlobal
            
            print("productBarCodeGlobal-----\(productBarCodeGlobal)")
            
            
            
            autoBarCodeDetected = false
        }
        
        
       // var segueIdent = self.segue
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
            halal_status_detail = NSMutableString()
            halal_status_detail = ""
            halal_haram_flag = NSMutableString()
            halal_haram_flag = ""
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
            if !halal_status_detail.isEqual(nil) {
                elements.setObject(halal_status_detail, forKey: "halal_status")
                
                print("Halal_Status is :::::::\(halal_status_detail)")
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
            
            
            if (string.containsString(" "))
            {
                print("Space found")
                
            }
            else {
                ingredient_id.appendString(string)
                
            }
            
            
            
        } else if element.isEqualToString("description") {
            desc.appendString(string)
        }
        else if element.isEqualToString("name") {
            name.appendString(string)
        }
        else if element.isEqualToString("halal_status") {
            halal_status_detail.appendString(string)
        }
        
        
    }
    
    func fetchRecords() {
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
      // upadating context with self.managed.context()  let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let ingredientFetch = NSFetchRequest(entityName: "Ingredients")
        
        var fetchRequest = NSFetchRequest(entityName: "Ingredients")
        let sortDescriptor = NSSortDescriptor(key: "ingredient_id", ascending: true)
        let predicate = NSPredicate(format: "ingredient_id contains %@", "E101")
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        
        do {
            
            let fetchedIngredient = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Ingredients]
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
        // commenting because of Section A
//        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//        let context: NSManagedObjectContext = appDel.managedObjectContext
        var ing = [Ingredients]()
        
        print("Just before for loop to save the records::\(productRecords.count)")
        
        
        for index in 0..<productRecords.count
            
        {
            
            var newIngredient = NSEntityDescription.insertNewObjectForEntityForName("Ingredients", inManagedObjectContext: self.managedObjectContext) as! Ingredients
            productRecords[index].valueForKey("ingredient_id")
            
            print("Ingredient_ID :::\(productRecords[index].valueForKey("ingredient_id"))")
            
            // Temp white space removal
            newIngredient.setValue(productRecords[index].valueForKey("ingredient_id")!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()), forKey: "ingredient_id")
            
            // Temp comments testing to remove white spaces
            //newIngredient.setValue(productRecords[index].valueForKey("ingredient_id"), forKey: "ingredient_id")
            
            print("Ingredient_ID set value is:::\(newIngredient.valueForKey("ingredient_id")!)")
            
            print("iteration\(productRecords[index].valueForKey("name"))")
            
            newIngredient.setValue(productRecords[index].valueForKey("ingredient_id"), forKey: "ingredient_id")
            newIngredient.setValue(productRecords[index].valueForKey("name"), forKey: "name")
            newIngredient.setValue(productRecords[index].valueForKey("description"), forKey: "descryption")
          
            
            
            
            print("halal_status_detail set value is:::\(productRecords[index].valueForKey("halal_status"))")
            
          
            newIngredient.setValue(productRecords[index].valueForKey("halal_status"), forKey: "halal_status_detail")
            // extract value for halal_haram_flag
            print("NsManaged Objects Value = 8981\(self.managedObjectContext)")
          let extractHalalHaramFlag = DataController()
             print("NsManaged Objects Value = 8981\(self.managedObjectContext)")
          let extractedDictionaryHalalFlag = extractHalalHaramFlag.halalExtractStatus_DataController(productRecords[index].valueForKey("halal_status") as! String)
            
             print("NsManaged Objects Value = 8981\(self.managedObjectContext)")
            
            print("extracted value is here for halal_haram:flag : \(extractedDictionaryHalalFlag["halalStatusExtracted"])")
            
            
            
            newIngredient.setValue(extractedDictionaryHalalFlag["halalStatusExtracted"], forKey: "halal_haram_flag")
            
            
            print("Record #909# \(index)")
            
            // MARK DB Saving is switched off for now
            do {
                print("trying to save records- BEFORE")
               // try context.save()
                
                print("elf.managedObjectContext.save just called in viewController: \(self.managedObjectContext)")
                 try self.managedObjectContext.save()
                print("trying to save records-AFTER")
                
                statusSave = true
            } catch let error {
                print("Could not cache the response \(error)")
                statusSave=false
                print("Here is productRecords::\(productRecords.count)")
                
                // return statusSave
            }
            
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
    func addProduct ()->AAAMasterProductsMO
    {
        
        // create db connection
        print("323a")
        var statusSave = Bool()
        print("323b")
        
       // let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        print("323c")
        
        print("323d")
     //   let context: NSManagedObjectContext = appDel.managedObjectContext
        // var ing = AAAMasterProductsMO()
        print("323e")
        
        var newProduct = NSEntityDescription.insertNewObjectForEntityForName("MasterProducts", inManagedObjectContext: self.managedObjectContext) as! AAAMasterProductsMO
        
        print("323f")
        
        
        // print("Product_ID :::\(productRecords[index].valueForKey("ingredient_id"))")
        newProduct.setValue(productBarCode, forKey: "product_id")
        newProduct.setValue("New Product", forKey: "product_name")
        newProduct.setValue("Product Type", forKey: "product_type")
        newProduct.setValue("DNK", forKey: "h_status")
        
        do {
            // print("trying to save records- BEFORE")
            print("self.managedObjectContext in viewController--new product- \(self.managedObjectContext)")
            
            try self.managedObjectContext.save()
            print("Product is saved\(productBarCode)")
            
            statusSave = true
        } catch let error {
            print("Could not cache the response \(error)")
            statusSave=false
            //    print("Here is productRecords::\(productRecords.count)")
            
            // return statusSave
        }
        return newProduct
        
    }
    
    // DB Record Insertion and Editing-- end
    // MARK Search product BarCode if exists then do not add it if doesnt exist then add it-START------
    
    func searchProduct()-> AAAMasterProductsMO
    {
        // Create Connection and get context
        //        var dataController = DataController()
        //        let context = dataController.managedObjectContext
        //        var newProduct = NSEntityDescription.insertNewObjectForEntityForName("MasterProducts", inManagedObjectContext: context) as! AAAMasterProductsMO
//--- commenting on 10th of Feb
        //        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let productFetch = NSFetchRequest(entityName:"MasterProducts")
        productFetch.predicate = NSPredicate(format: "%K Contains %@","product_id", productBarCode)
        var fetchedProducts = [AAAMasterProductsMO]()
        var statusSave = Bool()
        var ing = [AAAMasterProductsMO]()
        
        
        do {
            print("self.managedObjectContext in viewController: \(self.managedObjectContext)")
            print("fetched Products: self.managedObjectContext just called : \(self.managedObjectContext)")
            fetchedProducts = try self.managedObjectContext.executeFetchRequest(productFetch) as! [AAAMasterProductsMO]
            
            //  fetchedProducts = try context.executeFetchRequest(productFetch) as! [AAAMasterProductsMO]
            // context.executeFetchRequest(<#T##request: NSFetchRequest##NSFetchRequest#>)
            
            if fetchedProducts.count == 0
            {// if no product found then add the product
                var addedProduct = addProduct()
                print("Product saved with id (DB Value is):\(addedProduct.product_id!)")
                return addedProduct
                
            }
                
                //            print("1 \(fetched)")
                
            else {
                
                print("Product is allready available ::: \(fetchedProducts.count)")
                return fetchedProducts[0]
            }
        } catch {
            fatalError("Failed to fetch Products: \(error)")
        }
        print ("about to return fetched products[]")
        return fetchedProducts[0]
        
    }
    // MARK Search product BarCode if exists then do not add it if doesnt exist then add it -END-------
    
    func fetchResults (eNUmValue: String)-> [Ingredients] {
        //        print("eNumValue: \(eNUmValue)")
        //        print("-FetchResults have been called up-1")
        //        // let moc = self.managedObjectContext
        //        print("fetchResults func 2")
        //        //var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        //---------------COMMENTING BELOW CONTEXT ON 10TH OF FEB-----------------
//        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//        let context: NSManagedObjectContext = appDel.managedObjectContext
//        //let ingredientsFetch = NSEntityDescription.insertNewObjectForEntityForName("Ingredients", inManagedObjectContext: context) as NSManagedObject
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
          //  fetchedIngredients = try context.executeFetchRequest(ingredientsFetch) as! [Ingredients]
            print("self.managedObjectContext in viewController--- \(self.managedObjectContext)")
            fetchedIngredients = try self.managedObjectContext.executeFetchRequest(ingredientsFetch) as! [Ingredients]
            
            if fetchedIngredients.count == 0
            {
                
                return fetchedIngredients
            }
            ingId = (fetchedIngredients.first!.ingredient_id)!
            nme = (fetchedIngredients.first!.name)!
            desc = (fetchedIngredients.first!.descryption)!
            usgExm = (fetchedIngredients.first!.halal_status_detail)!
            
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
        
       // commenting on 10th of Feb
        
//        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//        let context: NSManagedObjectContext = appDel.managedObjectContext
//        

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
            print("self.managedObjectContext in viewController--- \(self.managedObjectContext)")
            
            receivedIngredients = try self.managedObjectContext.executeFetchRequest(ingredientsFetch) as! [Ingredients]
            print ("eNumbered.Text is \(ingredientsID)")
            if receivedIngredients.count == 0
            {
                print("d11")
                return receivedIngredients
            }
            ingId = (receivedIngredients.first!.ingredient_id)!
            nme = (receivedIngredients.first!.name)!
            desc = (receivedIngredients.first!.descryption)!
            usgExm = (receivedIngredients.first!.halal_status_detail)!
            print("Total Record Founds are::8769:: \(receivedIngredients.count)")
        } catch {
            print("e11")
            fatalError("Failed to fetch employees: \(error)")
        }
        print("f11")
        return receivedIngredients
    }
    
    //Mark register ingredient to product start 26TH JAN 2016 BECAUSE MAY BE WE HAVE THIS IN DATACONTROLLER ALREADY, REDUNDANCY
    // SWITCHING IT OFF ON
    //    func registerIngredientToProduct (halalStatus: String)
    //    {
    //
    //        // create db connection
    //        print("i323a")
    //        var statusSave = Bool()
    //        print("323b")
    //
    //        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    //        print("i323c")
    //
    //        print("i323d")
    //        let context: NSManagedObjectContext = appDel.managedObjectContext
    //        // var ing = AAAMasterProductsMO()
    //        print("i323e")
    //
    //        var registerIngredientAgainstProduct = NSEntityDescription.insertNewObjectForEntityForName("ProductsWithIngredients", inManagedObjectContext: context) as! AAAProductsWithIngredientssMO
    //
    //        print("i323f")
    //
    //
    //        // print("Product_ID :::\(productRecords[index].valueForKey("ingredient_id"))")
    //        registerIngredientAgainstProduct.setValue(productBarCode, forKey: "prd_id")
    //        registerIngredientAgainstProduct.setValue(eNumberEntered.text, forKey: "ing_id")
    //        registerIngredientAgainstProduct.setValue(halalStatus, forKey: "h_status")
    //        registerIngredientAgainstProduct.setValue(nameLabel.text, forKey: "ing_name")
    //        registerIngredientAgainstProduct.setValue(descriptionLabel.text, forKey: "ing_descryption")
    //
    //
    //
    //
    //        do {
    //            // print("trying to save records- BEFORE")
    //            try context.save()
    //            print("Ingredient has been registered against product::\(productBarCode)")
    //
    //            statusSave = true
    //            print("New ingredient has been registered i.e. ingredient id is : \(eNumberEntered.text)")
    //            print("Against the barcode is : \(productBarCode)")
    //            print("Againsta halal status i.e. : \(halalStatus)")
    //        } catch let error {
    //            print("Could not cache theƒ‹ response \(error)")
    //            statusSave=false
    //            //    print("Here is productRecords::\(productRecords.count)")
    //
    //            // return statusSave
    //        }
    //
    //
    //    }
    // Mark register ingredient to product end
    
    func searchRegisteredIngredient() -> [AAAProductsWithIngredientsMO]{
  // 10th feb replacing
        //let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//      let context: NSManagedObjectContext = appDel.managedObjectContext
        let registeredIngredientsToProductFetch = NSFetchRequest(entityName:"ProductsWithIngredients")
        registeredIngredientsToProductFetch.predicate = NSPredicate(format: "%K Contains %@","ing_id", eNumberEntered.text!)
        print ("98789checking against eNumberEntered.text!\(eNumberEntered.text!)")
        //print ("checking against eNumberEntered.text!\(eNumberEntered.text!)")
        
        var fetchedregisteredIngredientsToProduct = [AAAProductsWithIngredientsMO]()
        var statusSave = Bool()
        var registeredIngredientsToProducts = [AAAProductsWithIngredientsMO]()
        
        
        do {
            fetchedregisteredIngredientsToProduct = try self.managedObjectContext.executeFetchRequest(registeredIngredientsToProductFetch) as! [AAAProductsWithIngredientsMO]
            
            //            fetchedregisteredIngredientsToProduct = try context.executeFetchRequest(registeredIngredientsToProductFetch) as! [AAAProductsWithIngredientsMO]
//            // context.executeFetchRequest(<#T##request: NSFetchRequest##NSFetchRequest#>)
            print("registeredIngredientsToProductFetch---- inside do:::\(fetchedregisteredIngredientsToProduct.count)")
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
        // commenting on 10th of Feb
        
        //let moc     = DataController().managedObjectContext
        print("self.managedObjectContext in viewController-seed Ingredients-- \(self.managedObjectContext)")
        
        let entity  = NSEntityDescription.insertNewObjectForEntityForName("Ingredients", inManagedObjectContext: self.managedObjectContext) as! Ingredients
        entity.setValue("seed_id", forKey: "ingredient_id")
        entity.setValue("Seed Name", forKey: "name")
        entity.setValue("seed Desc", forKey: "descryption")
        entity.setValue("seed usage", forKey: "halal_status")
        do{
            try self.managedObjectContext.save()
            
        }
        catch {
            fatalError("Failure to save error \(error)")
        }
    }
    
    // MARK text field delegates
    
    // MARK BARCODE reading
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Segue!")
        print("segue.identifier::::::\(sender?.tag)")
        print("segue.identifier::::::\(segue.identifier)")
       // print("segueViewController.destination segue is = \(segue.destinationViewController.)")
        if (segue.identifier == "segueToBarCode")
        
        {
        
            segue.destinationViewController.setValue(self.managedObjectContext, forKey: "managedObjectContext")
            
        }
        
        // set tag to 9 which will bring all the ingredients belongs to some product
        if ( sender?.tag == 9 || sender?.tag == 11)
        {
            
            print("Filtered ingredients are going to be printed \(self.managedObjectContext)")
            
            segue.destinationViewController.setValue(self.managedObjectContext, forKey: "managedObjectContext")
            
            showFilteredIngredients = true
        }
            // set tag to 7 which will bring all the ingredients
        else if (sender?.tag == 7)
        {
            print("all ingredients are going to be printed")
     
            segue.destinationViewController.setValue(self.managedObjectContext, forKey: "managedObjectContext")
            showFilteredIngredients = false
        }
             else if (sender?.tag == 4)
        {
         }
        else {
            let barcodeViewController: BarcodeViewController = segue.destinationViewController as! BarcodeViewController
            print("after barcode view controller")
            barcodeViewController.delegate = self
        }
    }
    func barcodeReaded(barcode: String) {
        print("Barcode leido::::: \(barcode)")
        productBarCodeDisplay.text = "Product:" + barcode
        productBarCode = barcode
        //MARK SearchProduct
        checkProduct(productBarCode)
        // let productFound = searchProduct()
        // change the status based on the product received
        // changeDisplayStatus(productFound.h_status!, productOrIngredientLevel: productLevelForStatus )
        // codeTextView.text = barcode
    }
    func changeColor ( setColorValueTo: UIColor, setViewColorValue: UIColor ,productOrIngredienLevelColorChange: String ) {
        print("setColorValueto is ::: \(setColorValueTo)")
        print("setViewColorValue is ::: \(setViewColorValue)")
        print("productOrIngredienLevelColorChange is ::: \(productOrIngredienLevelColorChange)")
        
        //self.view.backgroundColor = UIColor.greenColor()
        
        // first save object colors' default state
        bgColorViewController = self.view.backgroundColor!
        bgColorDefaultButton = addProductsBarCode.backgroundColor!
        bgColorDescryptionLabel = descriptionLabel.backgroundColor!
        bgColorNameLabel = nameLabel.backgroundColor!
        bgColorHalalStatusLabel = halalStatusLabel.backgroundColor!
        bgColorENumberEntered = eNumberEntered.backgroundColor!
        // assign new color value
        // Product Level (all)
        if (productOrIngredienLevelColorChange == productLevelForStatus){
            self.view.backgroundColor = setViewColorValue
            addProductsBarCode.backgroundColor = setColorValueTo
        }
        // ingredient Level (without product)
        descriptionLabel.backgroundColor = setColorValueTo
        nameLabel.backgroundColor = setColorValueTo
        halalStatusLabel.backgroundColor = setColorValueTo
        eNumberEntered.backgroundColor = setColorValueTo
    }
    
    // MARK Change Display Status based on the Halal Status value of Product or ingredient:
    
    func changeDisplayStatus (halalStatusDB: String, productOrIngredientLevel: String) {
        
        print("halalStatusDB= \(halalStatusDB) and productOrIngredientLevel=\(productOrIngredientLevel)")
        
        /*
        1) Status will only be changed based on the product id 's status
        2) if ingredient is not registered then register it first
        
        */
        
        // Product Level Change (if Pid was found
        
        if (productOrIngredientLevel == productLevelForStatus)
        {
            print("Inside Product Level Display change")
            print("halal status found is :: = \(halalStatusDB.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()))")
            
            // Halal Found Product Level
            
            if ((halalStatusDB.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())) == HALAL)
            {
                changeColor(UIColor.grayColor(), setViewColorValue: UIColor.greenColor(), productOrIngredienLevelColorChange: productLevelForStatus)
                
                print("Inside Product Level-halal with sub Level :: \(halalStatusDB.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())))")
                
                print("Inside Product Level Display change")
                //addProductsBarCode.backgroundColor=UIColor.greenColor()
                displayShow = true
                
            }
                // HARAM Found Product Level
            else if ((halalStatusDB.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())) == HARAM) {
                
                changeColor(UIColor.redColor(), setViewColorValue: UIColor.redColor(), productOrIngredienLevelColorChange: productLevelForStatus)
                
                print("Inside Product Level-HARAM Display change")
                //         addProductsBarCode.backgroundColor=UIColor.redColor()
                displayShow = true
            }
                // MUSHBOOH Found Product Level
            else if ((halalStatusDB.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())) == MUSHBOOH) {
                print("Inside Product Level-MUSHBOOH Display change")
                
                changeColor(UIColor.grayColor(), setViewColorValue: UIColor.orangeColor(), productOrIngredienLevelColorChange: productLevelForStatus)
                
                // addProductsBarCode.backgroundColor=UIColor.grayColor()
                displayShow = true
            }
                // DO NOT KNOW Found Product Level
            else if ((halalStatusDB.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())) == DONOTKNOW) {
                
                
                changeColor(UIColor.grayColor(), setViewColorValue: UIColor.blueColor(), productOrIngredienLevelColorChange: productLevelForStatus)
                
                //        print("addProductsBarCode.backgroundColor\(addProductsBarCode.backgroundColor!)")
                
                // Saving default colors
                
                //   changeColor()
                
                bgColorDefaultButton = addProductsBarCode.backgroundColor!
                // Changing colors accordingly
                //        self.view.backgroundColor = UIColor.blueColor()
                //        addProductsBarCode.backgroundColor=UIColor.blueColor()
                displayShow = true
            }
            
            // Ingredient Level
        }
            
            // MARK INGREDIENT LEVEL CHANGE
        else if (productOrIngredientLevel == ingredientLevelForStatus)
        {
            
            print("Inside ingredient Level Display change")
            // Halal Found Ingredient Level
            if ((halalStatusDB.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())) == HALAL)
            {
                print("Inside ingredient Level-halal")
                
                changeColor(UIColor.greenColor(), setViewColorValue: UIColor.greenColor(), productOrIngredienLevelColorChange: ingredientLevelForStatus)
                
                //                eNumberEntered.backgroundColor=UIColor.greenColor()
                //                halalStatusLabel.backgroundColor=UIColor.greenColor()
                //                descriptionLabel.backgroundColor=UIColor.greenColor()
                //
                displayShow = true
            }
                // HARAM Found Ingredient Level
            else if ((halalStatusDB.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())) == HARAM) {
                print("Inside ingredient Level-HARAM")
                changeColor(UIColor.redColor(), setViewColorValue: UIColor.yellowColor(), productOrIngredienLevelColorChange: ingredientLevelForStatus)
                
                //                eNumberEntered.backgroundColor=UIColor.redColor()
                //                halalStatusLabel.backgroundColor=UIColor.redColor()
                //                descriptionLabel.backgroundColor=UIColor.redColor()
                //            displayShow = true
            }
                // MUSHBOOH Found Ingredient Level
            else if ((halalStatusDB.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())) == MUSHBOOH) {
                print("Inside ingredient Level-MUSHBOOH")
                changeColor(UIColor.grayColor(), setViewColorValue: UIColor.grayColor(), productOrIngredienLevelColorChange: ingredientLevelForStatus)
                
                //                eNumberEntered.backgroundColor=UIColor.grayColor()
                //                halalStatusLabel.backgroundColor=UIColor.grayColor()
                //                descriptionLabel.backgroundColor=UIColor.grayColor()
                displayShow = true
            }
                // DO NOT KNOW Found Ingredient Level
            else if ((halalStatusDB.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())) == DONOTKNOW) {
                print("Inside ingredient Level-DONOTKNOW")
                changeColor(UIColor.yellowColor(), setViewColorValue: UIColor.blueColor(), productOrIngredienLevelColorChange: ingredientLevelForStatus)
                
                //                eNumberEntered.backgroundColor=UIColor.blueColor()
                //                halalStatusLabel.backgroundColor=UIColor.blueColor()
                //                descriptionLabel.backgroundColor=UIColor.blueColor()
                displayShow = true
            }
            
            
            
            
            
            
            
            // Haram Found
            
            // Mushbooh Found
            
            // Do Not Know Found (DNK)
            
            
        }
        
        // MARK: Func changeColors
        
        
        // Mark Master Reset Status of display to start checking product or ingredient from start
        
        
        
    }
    func masterReset (resetLevel: String) {
        
        if (resetLevel == ingredientLevelForStatus)
        {
            
            
            
            // setting variables to default state
            centralDisplay = ""
            // Ingredient Level
            // Setting up Label text
            descriptionLabel.text = "Descryption"
            nameLabel.text = "Name"
            halalStatusLabel.text = "Halal / Haram / Mushbooh"
            eNumberEntered.text = "Use Buttons"
            // Setting up colors
            
            nameLabel.backgroundColor = UIColor.lightGrayColor()
            descriptionLabel.backgroundColor = UIColor.lightGrayColor()
            halalStatusLabel.backgroundColor = UIColor.lightGrayColor()
            eNumberEntered.backgroundColor = UIColor.lightGrayColor()
            
        }
        else {
            
            // resetting variables
            
            centralDisplay = ""
            // Product Level
            // Setting up text for Product level Labels & Text Boxes
            productBarCodeDisplay.text = "Product ID"
            addProductsBarCode.isEqual("First Add Product Bar Code")
            
            // Setting up Color for Product level Labels & Text Boxes
            productBarCodeDisplay.backgroundColor = UIColor.whiteColor()
            addProductsBarCode.backgroundColor = UIColor.orangeColor()
            
            
            // Ingredient Level
            
            
            // Setting up text for Ingredients Labels/Text Boxes
            descriptionLabel.text = "Descryption"
            nameLabel.text = "Name"
            halalStatusLabel.text = "Halal / Haram / Mushbooh"
            eNumberEntered.text = "Use Buttons"
            // Setting up colors for Ingredients Labels/Text Boxes
            
            nameLabel.backgroundColor = UIColor.lightGrayColor()
            descriptionLabel.backgroundColor = UIColor.lightGrayColor()
            halalStatusLabel.backgroundColor = UIColor.lightGrayColor()
            eNumberEntered.backgroundColor = UIColor.lightGrayColor()
            self.view.backgroundColor = UIColor.whiteColor()
            
            
            
        }
        
        // if master reset level found in resetLevel then reset every thing
        
        
        // if ingredient level reset found then reset only ingredient info and let the product info stays
        
        
    }
    
}

