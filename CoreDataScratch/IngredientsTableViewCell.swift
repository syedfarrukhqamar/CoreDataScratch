//
//  IngredientsTableViewCell.swift
//  CoreDataScratch
//
//  Created by syed farrukh Qamar on 25/01/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {
    
    // MARK: Properties 
    
    @IBOutlet weak var ingredient_id: UILabel!
    @IBOutlet weak var halal_status: UILabel!
    @IBOutlet weak var nameIngredient: UILabel!
    @IBOutlet weak var descryptionIngredient: UILabel!
    
    
    override func awakeFromNib() {
      //  print("awake from nib has been called")
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(selected: Bool, animated: Bool) {
//      
//    //    print("selected has been called inside ingredients table view cell controller")
//    
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}


