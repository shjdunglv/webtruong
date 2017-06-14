//
//  CheckBox.swift
//  CheckBox
//
//  Created by ReasonAmu on 12/5/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class CheckBox: UIButton {

    // Images
    var checkedImage = UIImage(named: "checked")
    var uncheckedImage = UIImage(named: "unchecked")
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customCheckBox()
    }
    required override init(frame: CGRect) {
        super.init(frame: frame)
        customCheckBox()
    }
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }    
    override func awakeFromNib() {
       isChecked = false
    }
    func customCheckBox() {
            layer.cornerRadius = 5.0
        
    }
    
  
    
    
    
    
   
}
