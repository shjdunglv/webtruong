//
//  CustomButton.swift
//  RaoViet
//
//  Created by Chung on 11/28/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawBoder()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawBoder()
    }
    
    
    func drawBoder() {
        layer.cornerRadius = 12.0
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(hex: "#eeeeee").cgColor
        self.titleLabel!.font =  UIFont(name: "opensans", size: 14)
        self.setTitleColor(UIColor.black, for: .selected)
    }
}
