//
//  IngredientsViewController.swift
//  CoreDataScratch
//
//  Created by syed farrukh Qamar on 01/02/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation
import UIKit
import CoreData

var productsWithIngredientsInjected = AAAProductsWithIngredientsMO()

class IngredientsViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func commitChange(sender: AnyObject) {
        [self.navigationController?.popViewControllerAnimated(true)]
        print("going back to all Ingredients screen----------")
        //-------
        
        if (self.managedObjectContext == nil ){
            
            print(".--------nil--------")
            
        }
        else
        {
            
            do {
                print("check--------3")
                var editedIngredientID = ingredient_ID.text
                
                var editedIngredientName = ingredientName.text
                var editedIngredientDescryption = descryptionIngredient.text
                var editedHalalStatus = halalStatus.text
                
                productsWithIngredientsInjected.setValue(editedIngredientID, forKey: "ingredient_id")
                productsWithIngredientsInjected.setValue(editedIngredientName, forKey: "name")
                productsWithIngredientsInjected.setValue(editedIngredientDescryption, forKey: "descryption")
                productsWithIngredientsInjected.setValue(editedHalalStatus, forKey: "halal_haram_flag")
               // print("current index: \(productsWithIngredientsInjected.)")
                
                try self.productsWithIngredientsInjected.managedObjectContext!.save()
                
                
                
                //    print("trying to save::::::\(result)")
                //   print("managed object -----\(self.managedObjectContext)")
                
                
                
            }
            catch {
                fatalError("Failure to save context: Inside Ingredients View Controller \(error)")
            }
        }

        //_________End
    }
    var currentIndex = NSIndexPath()
    
    var productsWithIngredientsInjected: NSManagedObject!
    var managedObjectContext: NSManagedObjectContext!
    var fetchedResultController: NSFetchedResultsController!
    
    var testNameDestination = String()
    //var ingredientBundles : IngredientBundles?
    var ingredients : IngredientBundles?
    

    @IBAction func saveIngredients(sender: UIButton) {
                    if (self.managedObjectContext == nil ){
            
            print(".--------nil--------")
            
            }
                    else
                    {
                        
                        do {
                            print("check--------3")
                            var editedIngredientID = ingredient_ID.text
                            
                            var editedIngredientName = ingredientName.text
                            var editedIngredientDescryption = descryptionIngredient.text
                            var editedHalalStatus = halalStatus.text
                            
                           productsWithIngredientsInjected.setValue(editedIngredientID, forKey: "ingredient_id")
                            productsWithIngredientsInjected.setValue(editedIngredientName, forKey: "name")
                            productsWithIngredientsInjected.setValue(editedIngredientDescryption, forKey: "descryption")
                            productsWithIngredientsInjected.setValue(editedHalalStatus, forKey: "halal_haram_flag")
                            
                            
                            try self.productsWithIngredientsInjected.managedObjectContext!.save()
                            
                            
                            
                        //    print("trying to save::::::\(result)")
                            //   print("managed object -----\(self.managedObjectContext)")
                            
                            
                            
                        }
                        catch {
                            fatalError("Failure to save context: Inside Ingredients View Controller \(error)")
                        }
        }
        
        
    }
    
    @IBOutlet weak var ingredient_ID: UITextField!
    
    
    @IBOutlet weak var ingredientName: UITextField!
    
    //@IBOutlet weak var ingredientsName: UITextField!
    
    @IBOutlet weak var halalStatus: UITextField!
    
    @IBOutlet weak var descryptionIngredient: UITextField!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        print ("currentIndex of the object \(currentIndex)")
        print("TEST 1-------")
        ingredient_ID.text = productsWithIngredientsInjected.valueForKey("ingredient_id") as! String
        
        print("productsWithIngredientsInjected.ingredient_id---------\(productsWithIngredientsInjected.valueForKey("ingredient_id") as! String)")
        ingredientName.text = productsWithIngredientsInjected.valueForKey("name") as! String
        
        halalStatus.text = productsWithIngredientsInjected.valueForKey("halal_haram_flag") as! String
        
        descryptionIngredient.text = productsWithIngredientsInjected.valueForKey("description") as! String
          // Handle the text field’s user input through delegate callbacks.
        ingredientName.delegate = self
//        var halalStatus: String?
//        var ingredientDescryption: String?
//        var ingredientID: String?
//        var ingredientName: String?
//        var productID: String?
//        var productName: String?
        
//        if  let ingredients = ingredients {
//            ingredient_ID.text = ingredients.ingredient_id.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
//            ingredientName.text = ingredients.ingredient_name.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
//            halalStatus.text = ingredients.ingredient_status.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
//            descryptionIngredient.text = ingredients.ingredient_descryption.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
//          
//        }
          // Enable the Save button only if the text field has a valid Ingredients name.
    }
// implement the nsfetched result controller delegate
//    func controllerWillChangeContent(controller: NSFetchedResultsController) {
//        tableView.beginUpdates()
//    }
//    
//    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
//        switch type {
//        case .Insert:
//            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
//        case .Delete:
//            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
//        case .Move:
//            break
//        case .Update:
//            break
//        }
//    }
//    
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
//    
//    func controllerDidChangeContent(controller: NSFetchedResultsController) {
//        tableView.endUpdates()
//    }
//    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( sender?.tag == 8 )
        {

        print("save button has been pressed")
        }
        else {
            print("---------prepare for segue---------")
        }
    }
}
//class ViewController: UIViewController,UITableViewDelegate,
