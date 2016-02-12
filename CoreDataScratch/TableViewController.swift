//
//  TableViewController.swift
//  CoreDataScratch
//
//  Created by syed farrukh Qamar on 23/12/15.
//  Copyright © 2015 Be My Competence AB. All rights reserved.
//

import UIKit
import CoreData



class TableViewController: UITableViewController,UISearchBarDelegate{
    // , NSFetchedResultsControllerDelegate
    var IngredientsCell = [AAAProductsWithIngredientsMO]()
    var ingredientAll = [Ingredients]()
    var shoppingList = [String]()
    
    
    var temp = String()
    
    @IBOutlet var ingredientsTableView: UITableView!
    
 //   @IBOutlet var searchBar: UITableView!
    
    
    var searchActive : Bool = false
    //var data = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
    //var filtered:[String] = []
    func searchEntityResults (searchText: String,columnName: String){
        
        //entityArrayInNsManagedObject[0].valueForKey("test").conta
        
        var filteredResult = [NSManagedObject]()
        var comparisonString = [String]()
        
        
        for (var index = 0 ; index < bundledIngredients.count;index++){
            
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
    // temp change on tuesday 2nd feb to test ns managed object
     //var filtered = [IngredientBundles]()
    //var bundledIngredients = [IngredientBundles]()
    var filtered = [NSManagedObject]()
    var bundledIngredients = [NSManagedObject]()
    override func viewDidLoad() {
        
        
        var fetchedResultsController: NSFetchedResultsController!
        
        print("table view controller has been called 101")
        super.viewDidLoad()
        
        // load ingredients to ingredient mutable array
        //temp 2nd of feb
        // loadIngredients()
        loadIngredientsForTableView()
        
        
        //searchBar.delegate = self
        
        //-----1------//
    }
    //    */
    // MARK: loading ingredients based on the product based on only ingredient based
    func loadIngredientsForTableView()
        
    {
        let ingredientsGetFromDB = DataController()
        var fetchedResult = ingredientsGetFromDB.searchFor("Ingredients", columnName: "ingredient_id", searchString: "", filtered: false) as? [NSManagedObject]
        
        print("showfiltered Ingredients is= \(showFilteredIngredients)")
        
        if let results = fetchedResult
        {
            
            bundledIngredients = results
            print("BundledIngredients result count is :: \(bundledIngredients.count)")
            
        }
        else {
            print("Error has been reported inside loadIngredientsForTable")
            
        }
        
        //  self.tableView.reloadData()
    }
     func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
        searchActive = true;
        print("searchBarTextDidBeginEditing just called  ------------ search Active is := \(searchActive)")
    }
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
        print("searchBarTextDidEndEditing just called ------------ search Active is := \(searchActive)")
    }
    
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
        filtered = bundledIngredients.filter{$0.valueForKey("ingredient_id")!.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil}
        
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
    //-----11th feb------search ending here
    
    //-----11th feb------search table Populating 

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (showFilteredIngredients == true){
            print("inside number of Sections filtered- showFilteredIngredients\(showFilteredIngredients)")
            
            if (searchActive == true)
            {
                print("inside number of Sections filtered area searchActive= \(searchActive)")
                print("filtered.count = \(filtered.count)")
                return filtered.count
                
            }
            
            print("bundledIngredients.count.count: \(bundledIngredients.count)")
            
            //return IngredientsCell.count
            return bundledIngredients.count
            
        }
            
            
        else if (showFilteredIngredients == false){
            
            if (searchActive == true)
            {
                print("count 878787 is = \(filtered.count)")
                return filtered.count
                
            }
            
            print("bundledIngredients.count-count:----- \(bundledIngredients.count)")
            
            return bundledIngredients.count
        }
        
        
        return 0
    }
    
    // MARK Halal Status check function
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("search active & showfilteredIngredientscurrent value inside cellForRowAtIndexPath is ")
        print("---------showFilteredIngredients global  = :\(showFilteredIngredients)")
        print("---------search active = :\(searchActive)")
        
        
        print("------A-----546")
        let cellIdentifier = "IngredientsTableViewCell"
        // let cell = tableView.de
        let cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! IngredientsTableViewCell
        print("-----------1546")
        
        
        print("index row number is :::::\(indexPath.row)")
        print("------B-----546")
        if (searchActive == false){
            print("search Active is false------09098787")
            print("bundledIngredients is \(bundledIngredients.count)")
            cell.nameIngredient.text = bundledIngredients[indexPath.row].valueForKey("name") as! String
            
            cell.descryptionIngredient.text = bundledIngredients[indexPath.row].valueForKey("descryption") as! String
            
            cell.ingredient_id.text = bundledIngredients[indexPath.row].valueForKey("ingredient_id") as! String
            // temp comment to check ingredients count
            cell.halal_status.text = bundledIngredients[indexPath.row].valueForKey("halal_haram_flag") as! String
            //  indexPath.row
            //    cell.halal_status.text = String(indexPath.row)
            
            var halalTrimmedStatus = bundledIngredients[indexPath.row].valueForKey("halal_status_detail") as! String
            
            
            var halalExtractStatusConculusion = halalExtractStatus(halalTrimmedStatus)
            
            //            for index in 0..<IngredientsCell.count {
            //
            //                print ("....................\(bundledIngredients[indexPath.row].valueForKey("ingredient_id")as! String)")
            //                print ("....................\(bundledIngredients[indexPath.row].valueForKey("name") as! String)")
            //
            //            }
            
            var lengthHalalStatusCellString = Int(halalExtractStatusConculusion["length"]!)
            
            
            
            if (lengthHalalStatusCellString >= 8){
                cell.halal_status.numberOfLines = 8
                cell.halal_status.backgroundColor = mushbooh_BG_Color
                cell.halal_status.textColor = mushbooh_Text_Color
            } else {
                
                // halal
                if (halalExtractStatusConculusion["trimmedHalalStatus"]!.lowercaseString.containsString(HALAL.lowercaseString))
                {
                    cell.halal_status.numberOfLines = 1
                    cell.halal_status.backgroundColor = halal_BG_Color
                    cell.halal_status.textColor = halal_Text_Color
                    
                    
                    
                }
                    
                    
                    // haram
                else if (halalExtractStatusConculusion["trimmedHalalStatus"]!.lowercaseString.containsString(HARAM.lowercaseString))
                {
                    
                    cell.halal_status.numberOfLines = 1
                    cell.halal_status.backgroundColor = haram_BG_Color
                    cell.halal_status.textColor = haram_Text_Color
                    
                    
                }
                    
                    // mushbooh
                    
                else if (halalExtractStatusConculusion["trimmedHalalStatus"]!.lowercaseString.containsString(MUSHBOOH.lowercaseString))
                {
                    cell.halal_status.numberOfLines = 1
                    cell.halal_status.backgroundColor = mushbooh_BG_Color
                    cell.halal_status.textColor = mushbooh_Text_Color
                    
                    
                }
                    
                    // Do not know
                    
                else
                {
                    
                    cell.halal_status.numberOfLines = 1
                    cell.halal_status.backgroundColor = doNotKnow_BG_Color
                    cell.halal_status.textColor = doNotKnow_Text_Color
                    
                }
                
                
            }
        }
            
        else if (searchActive == true){
            print("-------1267----------09")
            print("filtered count is 5435 \(filtered.count)")
            
            cell.nameIngredient.text = filtered[indexPath.row].valueForKey("name") as! String
            cell.descryptionIngredient.text = filtered[indexPath.row].valueForKey("descryption")as! String
            cell.ingredient_id.text = filtered[indexPath.row].valueForKey("ingredient_id")as! String
            cell.halal_status.text = filtered[indexPath.row].valueForKey("halal_haram_flag")as! String
            
            var halalTrimmedStatus = filtered[indexPath.row].valueForKey("halal_status_detail")as! String
            
            
            var halalExtractStatusConculusion = halalExtractStatus(halalTrimmedStatus)
            
            //            for index in 0..<IngredientsCell.count {
            //
            //                print ("....................\(filtered[index].ingredient_id)")
            //                print ("....................\(filtered[index].ingredient_name)")
            //
            //            }
            var lengthHalalStatusCellString = Int(halalExtractStatusConculusion["length"]!)
            if (lengthHalalStatusCellString >= 8){
                cell.halal_status.numberOfLines = 8
                cell.halal_status.backgroundColor = mushbooh_BG_Color
                cell.halal_status.textColor = mushbooh_Text_Color
            } else {
                
                // halal
                if (halalExtractStatusConculusion["trimmedHalalStatus"]!.lowercaseString.containsString(HALAL.lowercaseString))
                {
                    cell.halal_status.numberOfLines = 1
                    cell.halal_status.backgroundColor = halal_BG_Color
                    cell.halal_status.textColor = halal_Text_Color
                }
                    // haram
                else if (halalExtractStatusConculusion["trimmedHalalStatus"]!.lowercaseString.containsString(HARAM.lowercaseString))
                {
                    
                    cell.halal_status.numberOfLines = 1
                    cell.halal_status.backgroundColor = haram_BG_Color
                    cell.halal_status.textColor = haram_Text_Color
                 }
                    
                    // mushbooh
                else if (halalExtractStatusConculusion["trimmedHalalStatus"]!.lowercaseString.containsString(MUSHBOOH.lowercaseString))
                {
                    cell.halal_status.numberOfLines = 1
                    cell.halal_status.backgroundColor = mushbooh_BG_Color
                    cell.halal_status.textColor = mushbooh_Text_Color
                }
                    // Do not know
                    
                else
                {
                    cell.halal_status.numberOfLines = 1
                    cell.halal_status.backgroundColor = doNotKnow_BG_Color
                    cell.halal_status.textColor = doNotKnow_Text_Color
                }
            }
            
        }
        print("returning cell-----123---\(cellIdentifier.isEmpty)")
        print("returning cell-----123---\(indexPath)")
        return cell
    }
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        
        if (segue.identifier == "editIngredients") {
            
            print("segue identifier is ::: \(segue.identifier)")
            print("inside editIngredients segue--------999A & sender is \(sender?.indexPath)")
            print("sender is ++++++++++++\(tableView.indexPathForSelectedRow)")
            let indexPath = self.tableView.indexPathForSelectedRow!
            print("---------iiiiindex path is :\(indexPath))")
            
            let ingredientsDetailViewController = segue.destinationViewController as! IngredientsViewController
            print("inside editIngredients segue--------999B")
            if let selectedIngredientCell = sender as? IngredientsTableViewCell
                
            {
                print("---------------123------565-----\(tableView.indexPathForCell(selectedIngredientCell))")
                let indexPath = self.tableView.indexPathForSelectedRow
                
                print("inside editIngredients segue---888-----c----\(selectedIngredientCell.description)")
                print("inside editIngredients segue--------c----\(selectedIngredientCell)")
                print("index path will get this value -\(tableView.indexPathForCell(selectedIngredientCell))")
                print("index path is -\(indexPath)")
                //  print("tableView.indexPathForCell(selectedIngredientCell indexPath.row)= \(indexPath.row)")
                print("inside editIngredients segue--------d")
                
                
                
                if (searchActive == false)
                {
                    print("inside editIngredients segue--------d-1")
                    
                    let selectedIngredient = bundledIngredients[indexPath!.row]
                }
                    
                else if (searchActive == true)
                    
                {
                    print("inside editIngredients segue--------d-2-a")
                    print("filter count is -------: \(filtered.count)")
                    // var test = filtered.indices
                    let selectedIngredient = filtered[indexPath!.row]
                    // let selectedIngredient = filtered[indexPath!.row]
                    print("inside editIngredients segue--------d-2-b")
                    
                }
                
            }
            
        }
        else if (segue.identifier == "AddIngredients") {
            
            print("Adding a new meal")
        }
    }
    
}
//--------11th of feb -----table populating ending here

                //                print("ing_name :\(bundledIngredients[indexPath.row].ingredient_id)")
                //                print("ing_id : \(bundledIngredients[indexPath.row].ingredient_name)")
                //                print("ing_descryption:\(bundledIngredients[indexPath.row].ingredient_descryption)")
                //                print("ingredientsHalalStatus:\(bundledIngredients[indexPath.row].ingredient_status)")
                
                
                //   ingredientsDetailViewController.ingredients = selectedIngredient
                
                
                //
                //                let indexPath = tableView.indexPathForCell(selectedMealCell)!
                //                let selectedMeal = meals[indexPath.row]
                //                mealDetailViewController.meal = selectedMeal
                //                //tableView.indexPathForCell(<#T##cell: UITableViewCell##UITableViewCell#>)
                

     
    // temp change on tuesday 2nd feb to test ns managed object
    /*
    func loadIngredients () {
    
    
    var pullIngredientsDB = DataController()
    print ("searching against search string ")
    //   productBarCodeGlobal = "9999"
    if (showFilteredIngredients == true)
    {
    print("-----------------------inside pullIngredientsDB----------")
    IngredientsCell = pullIngredientsDB.createDBConnectionAndSearchFor("ProductsWithIngredients", columnName: "prd_id", searchString: productBarCodeGlobal,filtered: showFilteredIngredients) as! [AAAProductsWithIngredientsMO]
    for index in 0..<IngredientsCell.count {
    
    var tempPulledIngredient = IngredientBundles()
    tempPulledIngredient.ingredient_status = IngredientsCell[index].h_Status!
    tempPulledIngredient.ingredient_descryption = IngredientsCell[index].ing_descryption!
    tempPulledIngredient.ingredient_id = IngredientsCell[index].ing_id!
    tempPulledIngredient.ingredient_name = IngredientsCell[index].ing_name!
    // tempPulledIngredient.product_id = IngredientsCell[index].prd_id!
    
    bundledIngredients.append(tempPulledIngredient )
    
    }
    }
    
    else if (showFilteredIngredients == false) {
    
    var pullIngredientsDB1 = DataController()
    print ("searching against search string ")
    // productBarCodeGlobal = "9999"
    
    ingredientAll = pullIngredientsDB1.createDBConnectionAndSearchFor("Ingredients", columnName: "ingredient_id", searchString: productBarCodeGlobal,filtered: showFilteredIngredients) as! [Ingredients]
    
    print("ingredientAll is = \(ingredientAll.count)")
    for index in 0..<ingredientAll.count {
    //print ("ingredientAll[index].ingredient_id!::::\(ingredientAll[index].ingredient_id!)")
    var tempPulledIngredient = IngredientBundles()
    tempPulledIngredient.ingredient_status = ingredientAll[index].halal_status_detail!
    tempPulledIngredient.ingredient_descryption = ingredientAll[index].descryption!
    tempPulledIngredient.ingredient_id = ingredientAll[index].ingredient_id!
    tempPulledIngredient.ingredient_name = ingredientAll[index].name!
    // tempPulledIngredient.product_id = IngredientsCell[index].prd_id!
    
    bundledIngredients.append(tempPulledIngredient)
    
    }
    }
    
    
    var airports: [String: String] = ["stockholm": "Arlanda", "lahore": "Allama Iqbal International"]
    // var colors: [String: String] = ["sky": "blue", "road": "Dark Grey"]
    
    print("-------------------")
    var ingBundle = IngredientBundles()
    ingBundle.ingredient_id = "First Ingredient id"
    ingBundle.ingredient_name = "some name of first ingredient id"
    print("-------------------")
    // bundledIngredients[1] = colors
    
    }
    
    */
    // temp change on tuesday 2nd feb to test ns managed object----end
    
    //------------------searchBar code starts here
   
  // MARK change color of cell (HR, HL, MB )
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print("selected row:\(indexPath)")
//    }



//    let CellDetailIdentifier = "CellDetailIdentifier"
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        switch segue.identifier! {
//        case CellDetailIdentifier:
//            let destination = segue.destinationViewController as! DetailViewController
//            let indexPath = self.tableView.indexPathForSelectedRow!
//            let selectedObject = self.fetchedResultsController.objectAtIndexPath(indexPath) as! AAAEmployeeMO
//            destination.employee = selectedObject
//        default:
//            print("Unknown segue: \(segue.identifier)")
//        }
//    }




//-----1------//
// var fetchedResultIngredients = Ingredients()
// let moc = self.managedObjectContext
//        print("2")
//        //var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
//
//       //--------------------------------
//        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//        let context: NSManagedObjectContext = appDel.managedObjectContext
//        //let ingredientsFetch = NSEntityDescription.insertNewObjectForEntityForName("Ingredients", inManagedObjectContext: context) as NSManagedObject
//        let ingredientsFetch = NSFetchRequest(entityName: "Ingredients")
//        print("3")
//        //let ingredient_id = "MUSHBOOH"
//     print("4")
//   //     ingredientsFetch.predicate = NSPredicate(format: "ingredient_id == %@", ingredient_id)
//         //ingredientsFetch.predicate = NSPredicate(format: "ingredient_id like 'e'")
//
//        print("5")
//        do {
//            let fetchedIngredients = try context.executeFetchRequest(ingredientsFetch) as! [Ingredients]
//            var a = 1
//            print("6")
//            print ("Total count at 1018PM is : \(fetchedIngredients.count)")
//            var index = 1
//            while index < fetchedIngredients.count {
//               // print("3")
//                if fetchedIngredients[index].ingredient_id != nil {
//                print("one value is Please, in sha Allah :id:\(fetchedIngredients[index].ingredient_id)")
//                print("one value is Please, in sha Allah :id:\(fetchedIngredients[index].name)")
//                print("one value is Please, in sha Allah :id:\(fetchedIngredients[index].descryption)")
//                print("one value is Please, in sha Allah :id:\(fetchedIngredients[index].halal_status)")
//                print("Record # is \(a++)")
//                }
//
//              //  println(numbers[index])
//                index++ }
//          // let one = try context.executeFetchRequest(ingredientsFetch). as! Ingredients
//
//
////            print("one value is Please, in sha Allah :id:\(fetchedIngredients[100].ingredient_id)")
////
////            print("one value is Please, in sha Allah :id:\(fetchedIngredients[200].ingredient_id)")
////
////            print("one value is Please, in sha Allah :id:\(fetchedIngredients[300].ingredient_id)")
////            print("one value is Please, in sha Allah :id:\(fetchedIngredients[400].ingredient_id)")
////            print("one value is Please, in sha Allah :id:\(fetchedIngredients[800].ingredient_id)")
////
//
//       print("test:::Count:::\(fetchedIngredients.count)")
//            print("test:::Count:::\(fetchedIngredients.first)")
//
//            print("end")
//
//
//        } catch {
//            print("inside catch")
//            fatalError("Failed to fetch employees: \(error)")
//        }
//
//        print("just after catch in viewDidLoad")
//
//     //   print("Ingredients are here \(fetchedResultIng)")
//
//
//
//
//       /*
//        var frc: NSFetchedResultsController = NSFetchedResultsController()
//
//        // MARK Context add it he
//
//        print("1")
//        var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
//        print("2")
//        var fetchedResultsController: NSFetchedResultsController!*/
//
//     /*
//        print("3")
//
//       // func initializeFetchedResultsController() {
//            print("3.1")
//            let request = NSFetchRequest(entityName: "Ingredients")
//            print("3.2")
//            let ingredientId = NSSortDescriptor(key: "ingredient_id", ascending: true)
//            print("3.1")
//            let nameSort = NSSortDescriptor(key: "name", ascending: true)
//            request.sortDescriptors = [ingredientId, nameSort]
//            print("4")
//            // let moc = self.dataController.managedObjectContext
//            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
//            fetchedResultsController.delegate = self
//            print("5")
//            do {
//                print("6")
//                try fetchedResultsController.performFetch()
//
//                print("7")
//                print("fetch count is)")
//            } catch {
//                fatalError("Failed to initialize FetchedResultsController: \(error)")
//            }
//            */
//      //  }
//      //  var ingredients = fetchedResultsController.sections
//       // print("ingredients value is 121:\(Ingredients.valueForKey("name"))")
//      //  print("ingredients value is 121:\(fetchedResultsController.sections?.)")
////        frc.delegate = self
////        do {
////        try frc.performFetch()
////        }
////        catch let error as NSError {
////
////
////        }
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    // MArk reload the data if data changed
//
//    func controllerDidChangeContent(controller: NSFetchedResultsController) {
//    tableView.reloadData()
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//      // let numberOfSections = frc.sections?.count
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//       // let numberOfRowsInSection = frc.sections?[section].numberOfObjects
//        return 0
//    }
//
//
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//
//
//
//
//
//        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
//
//        // Configure the cell...
//
//       // let list = frc.objectAtIndexPath(indexPath) as! Lists
//
//
//
//        //cell.textLabel?.text = list.
//      //  var qty =list.qty
//     //   var note =list.note
//    //    cell.detailTextLabel?.text ="Qty: \(qty) - \(note)"
//        return cell
//    }
//
//
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//    */
//
//    /*
//    // Override to support editing the table view.
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            // Delete the row from the data source
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
//    */
//
//    /*
//    // Override to support rearranging the table view.
//    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
//
//    }
//    */
//
//    /*
//    // Override to support conditional rearranging of the table view.
//    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return false if you do not want the item to be re-orderable.
//        return true
//    }
//    */
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
