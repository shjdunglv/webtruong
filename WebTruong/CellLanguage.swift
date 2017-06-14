//
//  CellLanguage.swift
//  RaoViet
//
//  Created by ReasonAmu on 12/1/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit
import DLRadioButton

class CellLanguage: UITableViewCell {

    
   
    override func awakeFromNib() {
        super.awakeFromNib()
       
      
    }

  
 
    @IBAction func handleRadioLanguage(_ sender: DLRadioButton) {
        
        print(sender.titleLabel!.text! as Any)
    }
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
