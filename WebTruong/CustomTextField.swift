//
//  CustomTextField.swift
//  RaoViet
//
//  Created by Chung on 11/28/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    required override init(frame: CGRect) {
        super.init(frame: frame)
        drawBoder()
    }
    required init?(coder aDecode: NSCoder) {
        super.init(coder: aDecode)
        drawBoder()
    }
    func drawBoder() {
        layer.cornerRadius = 8.0
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        if self.placeholder != nil {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder!,
                                                            attributes:[NSForegroundColorAttributeName: UIColor.white])
        }
    }
    
    
    
   
}
