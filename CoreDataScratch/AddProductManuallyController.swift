//
//  AddProductManuallyController.swift
//  CoreDataScratch
//
//  Created by syed farrukh Qamar on 21/01/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit
import AVFoundation

var enteredProduct = ""

class AddProductManuallyController: UIViewController {
    var enteredProductInside = ""

    var productManualBarCodeText = "nil"
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var productBarCodeEnteredManually: UITextField!
    
    @IBOutlet weak var productBarCodeTextValue: UITextField!
    @IBAction func productBarCodeTextBox(sender: AnyObject) {
        
    print("productBarCodeTextValue:::\(productBarCodeTextValue.text)")
       enteredProduct =  productBarCodeTextValue.text!
        
    }
    
    
    
    
//    override func viewWillDisappear(animated: Bool) {
//        //productBarCodeDisplay = "TEST"
//        productBarCodeGlobal = productBarCodeEnteredManually.text!
//    print("viewWillDisappear just called::: and value of text box is :::\(productBarCodeEnteredManually.text)")
//        enteredProduct = productBarCodeEnteredManually.text!
//    print("productBarCodeGlobal's value is :::\(productBarCodeGlobal)")
//
//    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      //productManualBarCodeText = productBarCodeTextValue.text!
        if saveButton === sender {
            let name = productBarCodeTextValue.text
            
            
            // Set the meal to be passed to MealListTableViewController after the unwind segue.
           print("name is 989898:::\(name)")
            productManualBarCodeText = name!
        }
    }

}
