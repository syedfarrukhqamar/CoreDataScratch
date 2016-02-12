//
//  IngredientsTableViewController.swift
//  CoreDataScratch
//
//  Created by syed farrukh Qamar on 02/02/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class IngredientsTableViewController: UITableViewController,NSFetchedResultsControllerDelegate,UISearchBarDelegate {
//----table View Cell Variables
    var ingredient_Name = String()
    var ingredient_Id = String()
    var ingredient_Descryption = String()
    var ingredient_H_Status = String()
//----table View Cell Variables def end here
    var productBarCodeGlobal = ""
    var ingredientsForTableViewDataSource = [NSManagedObject]()
    var managedObjectContext: NSManagedObjectContext!
    var fetchedResultsController: NSFetchedResultsController!
    var searchActive : Bool = false
    var showFilteredIngredients = false
    //----temp---start
    var filtered = [NSManagedObject]()
    //-----temp end
    @IBOutlet weak var ingredientsTableView: UITableView!
    //var managedObjectContext: NSManagedObjectContext!
    //var dataController = DataControllerCentral()
    override func viewDidLoad() {
        print("self.managedObject Context inside ingredients VC is :\(self.managedObjectContext)")
        //UIApplication.sharedApplication().delegate.
        // var dataControllerCentral = DataControllerCentral()
        super.viewDidLoad()
        title = "Ingredients"
        
        // following : https://developer.apple.com/library/tvos/documentation/Cocoa/Conceptual/CoreData/nsfetchedresultscontroller.html#//apple_ref/doc/uid/TP40001075-CH8-SW1
        //
        print("--------------about to initialize Fetch Result Controller--1---")
        
        initializeFetchedResultsController()
        
        ingredientsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //---------------------------search bar controller start
        
        // Create the search results controller and store a reference to it.
        //        MySearchResultsController* resultsController = [[MySearchResultsController alloc] init];
        //        self.searchController = [[UISearchController alloc] initWithSearchResultsController:resultsController];
        //
        //        // Use the current view controller to update the search results.
        //        self.searchController.searchResultsUpdater = self;
        //
        //        // Install the search bar as the table header.
        //        self.tableView.tableHeaderView = self.searchController.searchBar;
        //
        //        // It is usually good to set the presentation context.
        //        self.definesPresentationContext = YES;
        
        // --------------------------search bar controller ends
        
        // assigning identifier to the cell inside the table view
        
        
        //         fetchIngredients(false,entityName: "Ingredients")
        //        print("-------starting to fetch ingredients")
        //        print("count of ingredients is \(ingredientsForTableViewDataSource.count)")
    
    }
    
    func initializeFetchedResultsController() {
        print("------------2---")
        
        
        
        //   let moc = managedObjectContext.existingObjectWithID(<#T##objectID: NSManagedObjectID##NSManagedObjectID#>)
        
        
        if (self.managedObjectContext == nil){
            
            
            print("self.managedObjectContext is nil")
        }
        print("lk---------------")
        //            self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: "ingredients", cacheName: "rootCache")
        
        // sectionIdentifier = sectionForCurrentState().toRaw()
        // NSPredicate(format: "ingredient_id == %@", ingredient_id)
        
//        var ingredientsPredicate = NSPredicate(format: "ingredient_id contains %@", "107")
        
        
        if ( showFilteredIngredients == false) {
            let request = NSFetchRequest(entityName: "Ingredients")
            print("------------3---")
            
            let ingredientIDSort = NSSortDescriptor(key: "ingredient_id", ascending: true)
            // let lastNameSort = NSSortDescriptor(key: "lastName", ascending: true)
            print("------------4---")
            
            request.sortDescriptors = [ingredientIDSort]
            print("------------5---")
            
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: "ingredient_id", cacheName: "rootCache")
        }
        
        else if (showFilteredIngredients == true){
            let request = NSFetchRequest(entityName: "ProductsWithIngredients")
            print("//---creating a predicate----")
            let filteredPorductIngredientsPredicate = NSPredicate(format: "@product_id like %@",productBarCodeGlobal)
            
            print("------------3---")
            
            let ingredientIDSort = NSSortDescriptor(key: "ing_id", ascending: true)
            // let lastNameSort = NSSortDescriptor(key: "lastName", ascending: true)
            print("------------4--\(productBarCodeGlobal)-")
            print ("------character count-----\(productBarCodeGlobal.characters.count)")
            request.sortDescriptors = [ingredientIDSort]
            print("------------5---")
            self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: "ing_id", cacheName: "rootCache")
            print("----count of ingredientsProducts---\(fetchedResultsController.sections?.count)")
        
        
        }
        // fetchedResultsController.sections?.filter({$0.ingredient_id = "107"})
        //fetchedResultsController.filter ({$0.ingredient_id = "107"})
        //          fetchedResultsController.
        print("------------6---")
        
        
        //--start---temp working area formed on 10th of feb 1000
        
        
        // testing area for search tab bar
        
        
        
        ////-end----temp working area formed on 10th of feb 1000
        self.fetchedResultsController.delegate = self
        print("------------7---")
        
        do {
            print("about to fetch the results")
            try self.fetchedResultsController.performFetch()
            
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    // each time the view is loading but with new ingredients if added
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    //------start of TableViewController
    
    func halalExtractStatus (halalStatusColumn: String) -> [String:String]
    {
        var colorHalalStatus = String()
        var halalStatusReturn = [String : String]()
        // trim the text first
        var trimmedHalalStatus = halalStatusColumn.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        // length of the text
        var lengthHalalStatus = trimmedHalalStatus.characters.count
        
        var forComparisonHalalStatus = trimmedHalalStatus.lowercaseString
        
        if (lengthHalalStatus >= 8) {
            colorHalalStatus = mushboohColorText
            
            
        } else {
            
            // if halal
            if (forComparisonHalalStatus.containsString(HALAL.lowercaseString)) {
                
                //halalStatusColumn.cont
                colorHalalStatus = halalColorText
                
                
            }
                
                // if haram
            else if (forComparisonHalalStatus.containsString(HARAM.lowercaseString)) {
                
                colorHalalStatus = halalColorText
                
                
            }
                // if Mushbooh
            else if (forComparisonHalalStatus.containsString(MUSHBOOH.lowercaseString)) {
                
                colorHalalStatus = mushboohColorText
                
                
            }
            else {
                
                
                colorHalalStatus = doNotKnowColorText
            }
            
            // if do not know
            
        }
        
        
        halalStatusReturn = [ "length" : String(lengthHalalStatus), "trimmedHalalStatus" : trimmedHalalStatus , "color" : colorHalalStatus   ]
        return halalStatusReturn
    }

    
    
    //------End of Table View Controller
    //-------start----------NS Fetched Result Controller Delegate
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Move:
            break
        case .Update:
            break
        }
    }


    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    
    //-----------------DataSourcing to Table View------Start
    
    func configureCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        print("------------8---")
        
        let ingredients = self.fetchedResultsController.objectAtIndexPath(indexPath) //as! Ingredients
        // Populate cell from the NSManagedObject instance
        print("--------------00000-------------")
    }
    
    let cellIdentifier = "IngredientsTableViewCell"
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! IngredientsTableViewCell
        
        if (showFilteredIngredients == false){
        let fetchedIngredients = fetchedResultsController.objectAtIndexPath(indexPath) as! Ingredients
            
            ingredient_Name = fetchedIngredients.name!
            ingredient_Id = fetchedIngredients.ingredient_id!
            ingredient_Descryption = fetchedIngredients.descryption!
            ingredient_H_Status = fetchedIngredients.halal_haram_flag!
        }
        
        else if (showFilteredIngredients == true){
        
            let fetchedIngredients = fetchedResultsController.objectAtIndexPath(indexPath) as! AAAProductsWithIngredientsMO
           ingredient_Name = fetchedIngredients.ing_name!
             ingredient_Id = fetchedIngredients.ing_id!
             ingredient_Descryption = fetchedIngredients.ing_descryption!
            ingredient_H_Status = fetchedIngredients.h_Status!
            
        }
        //        let fetched1Ingredients = fetchedResultsController as! [Ingredients]
        //
        //
        // Set up the cell
        print("------------9-indexPath--\(indexPath)")
        print("status is :=\(ingredient_Name)")
        print("status is :=\(ingredient_Descryption)")
        
        cell.nameIngredient.text = ingredient_Name
        cell.descryptionIngredient.text = ingredient_Descryption
        cell.ingredient_id.text = ingredient_Id
        cell.halal_status.text = ingredient_H_Status
        
        self.configureCell(cell, indexPath: indexPath)
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        print("------------10---")
        print("----numberOfSectionsInTableView--------10-\(self.fetchedResultsController.sections!.count)--")
        
        return self.fetchedResultsController.sections!.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("------------11---")
        let sections = self.fetchedResultsController.sections //as! [NSFetchedResultsSesionInfo]
        let sectionInfo = sections![section]
        print("------numberOfRowsInSection---s = \(sectionInfo.numberOfObjects)")
        return sectionInfo.numberOfObjects
    }
    
    //-----------------DataSourcing to Table View------End
    // ----------prepare for segue
    
    let CellDetailIdentifier = "CellDetailIdentifier"
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("test prepare for segure 1")
        print("test prepare for segure 2")
        
        if segue.identifier == "editIngredients" {
            print("test prepare for segure 3")
            print("test prepare for segure 3-a")
            //let mealDetailViewController = segue.destinationViewController as! MealViewController
            let ingredientEditController = segue.destinationViewController as! IngredientsViewController
            print("test prepare for segure 3-b")
            // Get the cell that generated this segue.
            if let selectedIngredientCell = sender as? IngredientsTableViewCell {
                print("test prepare for segure 3-c")
                let indexPath = tableView.indexPathForCell(selectedIngredientCell)!
                
                //var selectedIngredient = NSManagedObject()
                var testName = "Farrukh Qamar and Aahil"
                ingredientEditController.testNameDestination = testName
                print("testing::::\(ingredientEditController.testNameDestination)")
                
                let selectedIngredient = fetchedResultsController.objectAtIndexPath(indexPath) as! Ingredients
                print ("indexPath==\(indexPath)")
                print("big day is today in sha Allah:::ingredient_id:= \(selectedIngredient.ingredient_id))")
                // print("big day is today in sha Allah:::ingredient_id:= \(selectedIngredient)")
                
                ingredientEditController.productsWithIngredientsInjected = selectedIngredient
                ingredientEditController.managedObjectContext = self.managedObjectContext
                ingredientEditController.fetchedResultController = self.fetchedResultsController
                ingredientEditController.currentIndex = indexPath
                print("managed object -----\(self.managedObjectContext)")
                
                
                //              ingredientDetailViewController.productsWithIngredientsInjected = selectedIngredient
                
                print("big day is today in sha Allah::::= \(selectedIngredient)")
                
            }
            print("edit ingredients has been called---------")
        }
        else if segue.identifier == "AddItem" {
        }
    }
}
        //        let fetchedIngredients = fetchedResultsController as! [Ingredients]
        //
        //        print("--fetched ingredients = \(fetchedIngredients[1].ingredient_id)")
        
        //        switch segue.identifier! {
        //        case CellDetailIdentifier:
        //            let destination = segue.destinationViewController as! IngredientsViewController
        //            let indexPath = self.tableView.indexPathForSelectedRow!
        //            let selectedObject = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Ingredients
        //
        //            destination.productsWithIngredientsInjected = selectedObject
        //        print ("----------selected object---------\(selectedObject.name)")
        //            print ("----------selected object-----\(selectedObject.ingredient_id)")
        //            print ("----------selected object-----\(selectedObject.description)")
        //
        //
        //        default:
        //
        //            print("Unknown segue: \(segue.identifier)")
        //        }

    //    func controller(controller: NSFetchedResultsController, didChangeObject anObject: NSManagedObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
    //        switch type {
    //        case .Insert:
    //            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
    //        case .Delete:
    //            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
    //        case .Update:
    //            configureCell(self.tableView.cellForRowAtIndexPath(indexPath!)!, indexPath: indexPath!)
    //        case .Move:
    //            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
    //            tableView.insertRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
    //        }
    //    }
    

//-----------------
    //-------start----------NS Fetched Result Controller Delegate
    
    //-----search start
    /*
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    print("search active current value is = \(searchActive)")
    searchActive = false;
    print("search active new value is = \(searchActive)")
    //  self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchActive = true;
    print("searchBarSearchButtonClicked just called ------------search Active is := \(searchActive)")
    
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    
    //let ingredientResult = bundledIngredients[index.]
    print("text did change: \(searchText))")
    //        filtered = bundledIngredients.filter{$0.valueForKey("ingredient_id")!.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil}
    filtered = self.fetchedResultsController.filter{$0.valueForKey("ingredient_id")!.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil}
    
    
    print("before filtering -----1111112233= \(filtered.count)")
    
    //
    //
    //
    //        var includeElemenet = NSManagedObject()
    //        includeElemenet.setValue(searchText, forKey: "ingredient_id")
    
    
    print("searchEntityResults------------:=\(searchText)")
    searchEntityResults(searchText, columnName: "ingredient_id")
    print("returning the filtered count as = \(filtered.count)")
    
    //   filtered = bundledIngredients.filter{$0.valueForKey("ingredient_id")!.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil}
    
    //          var test = NSArray(array: bundledIngredients)
    //
    //       var  fil = test.filteredArrayUsingPredicate(ingredientsPredicate)
    //
    //
    //        print("fil----\(fil.count)")
    // filtered = bundledIngredients.filter{$0.valueForKey("ingredient_id")!.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil}.
    
    //filtered = bundledIngredients.f
    //func (entityNSObject: [NSManagedObject])
    
    print("Current count of search researches is = \(filtered.count)")
    
    print ("searchActive status is  = \(searchActive)")
    if(filtered.count == 0){
    print ("-filtered count is zero 8987 = \(filtered.count)")
    print("filtered.count == 0-searchActive Value is= \(searchActive)")
    print("filtered.count == 0-showFilteredIngredients is = \(showFilteredIngredients)")
    print ("filtered count is 787 = \(filtered.count)")
    
    searchActive = true
    } else {
    searchActive = true
    print("searchActive Value is= \(searchActive)")
    print("showFilteredIngredients is = \(showFilteredIngredients)")
    print ("filtered count is  = \(filtered.count)")
    }
    // self.tableView.reloadData()
    }
    
    func searchEntityResults (searchText: String,columnName: String){
    
    //entityArrayInNsManagedObject[0].valueForKey("test").conta
    
    var filteredResult = [NSManagedObject]()
    var comparisonString = [String]()
    
    
    for (var index = 0 ; index < fetchedResultsController.count;index++){
    
    print ("entity Array value no \(index) :\(bundledIngredients[index].valueForKey("ingredient_id"))")
    
    var test = bundledIngredients[index].valueForKey("ingredient_id") as! String
    
    if (  test.containsString(searchText))
    
    {
    
    print("-------------------------=\(index)")
    print("--test---search Text is------=\(test)")
    print("------------esearchText -------------=\(searchText)")
    filtered.append(bundledIngredients[index])
    }
    
    //        if ((entityArrayInNsManagedObject[index].valueForKey("ingredient_id")?.isEqualToString(searchText))  != nil)
    //        {
    //            print ("TRUE")
    //            print ("value is :\(entityArrayInNsManagedObject[index].valueForKey("ingredient_id"))")
    //            print("search Text =\(searchText)")
    //            }
    //        else {
    //            print("false")
    //            }
    //
    
    }
    
    
    //        for var index = 0; index <  entityArrayInNsManagedObject.count; ++index
    //
    //        {
    //
    //
    //            comparisonString[index] = entityArrayInNsManagedObject[index].valueForKey("ingredient_id") as! String
    //            print("1010-comparisonString[index]= \(comparisonString[index])")
    //        }
    //
    //        var filteredString = [String]()
    //        //comparisonString.filter(<#T##includeElement: (String) throws -> Bool##(String) throws -> Bool#>)
    //        filteredString = comparisonString.filter{$0.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil}
    //
    //        for var index = 0; index <  comparisonString.count; ++index
    //
    //        {
    //            filtered[index].setValue(comparisonString[index], forKey: "ingredient_id")
    //            print("comparisonString[index]= \(comparisonString[index])")
    //        }
    //
    //
    
    
    }
    */
    //-----search end
    
    

//----extra functions

// it will fetch all ingredients
/*
fetchIngredients(false,entityName: "Ingredients")

}


func fetchIngredients (filtered: Bool,entityName: String){

let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
let managedContext = appDelegate.managedObjectContext
let fetchRequest = NSFetchRequest(entityName: entityName)
do
{
let fetchedResult = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]

if let results = fetchedResult
{
ingredientsForTableViewDataSource = results
}
else
{
print("Could not fetch result")
}
}
catch
{
print("There is some error.")
}

self.ingredientsTableView.reloadData()



}


func editIngredients(ingredientName : String, andIndex theIndex : Int, entityName: String)
{
let appDelegate    = UIApplication.sharedApplication().delegate as! AppDelegate

let managedContext = appDelegate.managedObjectContext

let fetchRequest   = NSFetchRequest(entityName: entityName)

do
{
let fetchResult = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]

if let theResult = fetchResult
{
let ingredientToUpdate = theResult[theIndex] as NSManagedObject
ingredientToUpdate.setValue(ingredientName, forKey:"name")

do
{
try managedContext.save()
}
catch
{
print("There is some error when trying to update ingredients")
}

if ingredientsForTableViewDataSource.contains(ingredientToUpdate)
{
ingredientsForTableViewDataSource.replaceRange(theIndex...theIndex, with: [ingredientToUpdate])
self.ingredientsTableView.reloadData()
}
}
}

catch
{
print("Some error in fetching queries inside editIngredients()")
}



}



func deleteIngredient(atIndex : Int, entityName: String)
{
let appDelegate    = UIApplication.sharedApplication().delegate as! AppDelegate

let managedContext = appDelegate.managedObjectContext

let objectToRemove = ingredientsForTableViewDataSource[atIndex] as NSManagedObject

managedContext.deleteObject(objectToRemove)

do
{
try managedContext.save()
}
catch
{
print("There is some error while updating CoreData.")
}

ingredientsForTableViewDataSource.removeAtIndex(atIndex)

self.ingredientsTableView.reloadData()

}

*/

//    func showEditNameAlert(atIndex theIndex : Int)
//    {
//        let ingredient     = ingredientsForTableViewDataSource[theIndex]
//        let nameToEdit = ingredient.valueForKey("name") as? String
//
//        let alert = UIAlertController(title: "Update Ingredient", message: "Edit All Records", preferredStyle: .Alert)
//
//        let updateAction = UIAlertAction(title: "Update", style: .Default)
//            {
//                (action : UIAlertAction!) -> Void in
//
//                let textField = alert.textFields![0] as UITextField!
//
//                if nameToEdit != textField.text
//                {
//                    self.editName(textField.text!, andIndex: theIndex)
//                }
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .Default)
//            {
//                (action : UIAlertAction) -> Void in
//        }
//
//        alert.addTextFieldWithConfigurationHandler
//            {
//                (textField : UITextField!) -> Void in
//                textField.text = nameToEdit
//        }
//
//        alert.addAction(updateAction)
//        alert.addAction(cancelAction)
//
//        presentViewController(alert, animated: true, completion: nil)
//    }
//
//------------------------------DATA EXTRACTION FROM DB
//    func initializeFetchedResultsController(){
//
//        let request = NSFetchRequest(entityName: "Ingredients")
//        let ingredientIDSort = NSSortDescriptor(key: "ingredient_id",ascending: true)
//        let ingredientNameSort = NSSortDescriptor(key: "name",ascending: true)
//        request.sortDescriptors = [ingredientIDSort,ingredientNameSort]
//        let appDel = AppDelegate()
//        //let context: NSManagedObjectContext = appDel.managedObjectContext
//        let moc = appDel.managedObjectContext
//        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: "IngredientsData", cacheName: "rootCache")
//        fetchedResultsController.delegate = self.data
//
//        do {
//            try fetchedResultsController.performFetch()
//
//        }
//
//        catch {
//        fatalError("Failed to initialize Fetched Results Controller:\(error)")
//
//        }
//
//        print("------fetchedResultsController-------\(fetchedResultsController.sections?.count)")
//
//    }




/*

extension IngredientsTableViewController : UITableViewDataSource {

func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
{

print("inside table view 101")
/*let theCell                      = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell?

if let theNewCell = theCell
{
theNewCell.textLabel!.textAlignment = .Center
}*/

return true
}

func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
{

print("inside table view 101-delete")
if editingStyle == .Delete
{
//self.deleteName(indexPath.row)
// self.deleteIngredient(indexPath.row, entityName: "Ingredients")
}
}

func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
{
return ingredientsForTableViewDataSource.count
}

func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
{
let theCell              = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!

tableView.separatorInset = UIEdgeInsetsZero

let ingredient              = ingredientsForTableViewDataSource[indexPath.row]
theCell.textLabel!.text = ingredient.valueForKey("name") as? String
return theCell
}

}





extension IngredientsTableViewController : UITableViewDelegate{
func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
{
//self.showEditNameAlert(atIndex: indexPath.row)
}



}
*/