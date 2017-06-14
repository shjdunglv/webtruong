//
//  CustomTextFieldForSearch.swift
//  RaoViet
//
//  Created by Chung on 12/12/16.
//  Copyright © 2016 3i. All rights reserved.
//

import Foundation
import  UIKit
class CustomTextFieldForSearch: UITextField {
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
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        if self.placeholder != nil {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder!,
                                                            attributes:[NSForegroundColorAttributeName: UIColor(hex: "#CCCCCC")])
        }
    }
}
