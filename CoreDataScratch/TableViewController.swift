//
//  TableViewController.swift
//  CoreDataScratch
//
//  Created by syed farrukh Qamar on 23/12/15.
//  Copyright © 2015 Be My Competence AB. All rights reserved.
//

import UIKit
import CoreData


class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    
    
    var frc: NSFetchedResultsController = NSFetchedResultsController()
//    //MARK make a func to bring records
//    
//    func getFetchedResultsController() ->NSFetchedResultsController{
//    frc = NSFetchedResultsController(fetchRequest: NSFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
//
//        return frc
//        
//    }
//    func listFetchRequest () -> NSFetchRequest {
//    let fetchRequest = NSFetchRequest(entityName: "Ingredients")
//        let sortDescriptor = NSSortDescriptor(key: "ingredient_id", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//        print("some data has been fetched")
//        return fetchRequest
//        
//    }
//    
    override func viewDidLoad() {
        print("1")
        super.viewDidLoad()
       // var fetchedResultIngredients = Ingredients()
       // let moc = self.managedObjectContext
        print("2")
        //var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
       
       //--------------------------------
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        //let ingredientsFetch = NSEntityDescription.insertNewObjectForEntityForName("Ingredients", inManagedObjectContext: context) as NSManagedObject
        let ingredientsFetch = NSFetchRequest(entityName: "Ingredients")
        print("3")
        //let ingredient_id = "MUSHBOOH"
     print("4")
   //     ingredientsFetch.predicate = NSPredicate(format: "ingredient_id == %@", ingredient_id)
         //ingredientsFetch.predicate = NSPredicate(format: "ingredient_id like 'e'")
       
        print("5")
        do {
            let fetchedIngredients = try context.executeFetchRequest(ingredientsFetch) as! [Ingredients]
            var a = 1
            print("6")
            print ("Total count at 1018PM is : \(fetchedIngredients.count)")
            var index = 1
            while index < fetchedIngredients.count {
               // print("3")
                if fetchedIngredients[index].ingredient_id != nil {
                print("one value is Please, in sha Allah :id:\(fetchedIngredients[index].ingredient_id)")
                print("one value is Please, in sha Allah :id:\(fetchedIngredients[index].name)")
                print("one value is Please, in sha Allah :id:\(fetchedIngredients[index].descryption)")
                print("one value is Please, in sha Allah :id:\(fetchedIngredients[index].usage_example)")
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
        
     //   print("Ingredients are here \(fetchedResultIng)")

        
        
        
       /*
        var frc: NSFetchedResultsController = NSFetchedResultsController()

        // MARK Context add it he
        
        print("1")
        var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        print("2")
        var fetchedResultsController: NSFetchedResultsController!*/
        
     /*
        print("3")
        
       // func initializeFetchedResultsController() {
            print("3.1")
            let request = NSFetchRequest(entityName: "Ingredients")
            print("3.2")
            let ingredientId = NSSortDescriptor(key: "ingredient_id", ascending: true)
            print("3.1")
            let nameSort = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [ingredientId, nameSort]
            print("4")
            // let moc = self.dataController.managedObjectContext
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = self
            print("5")
            do {
                print("6")
                try fetchedResultsController.performFetch()
                
                print("7")
                print("fetch count is)")
            } catch {
                fatalError("Failed to initialize FetchedResultsController: \(error)")
            }
            */
      //  }
      //  var ingredients = fetchedResultsController.sections
       // print("ingredients value is 121:\(Ingredients.valueForKey("name"))")
      //  print("ingredients value is 121:\(fetchedResultsController.sections?.)")
//        frc.delegate = self
//        do {
//        try frc.performFetch()
//        }
//        catch let error as NSError {
//        
//        
//        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MArk reload the data if data changed
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
    tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
      // let numberOfSections = frc.sections?.count
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       // let numberOfRowsInSection = frc.sections?[section].numberOfObjects
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        
        
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

       // let list = frc.objectAtIndexPath(indexPath) as! Lists
        
        
     
        //cell.textLabel?.text = list.
      //  var qty =list.qty
     //   var note =list.note
    //    cell.detailTextLabel?.text ="Qty: \(qty) - \(note)"
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
