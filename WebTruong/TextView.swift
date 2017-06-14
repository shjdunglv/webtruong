//
//  TextView.swift
//  RaoViet
//
//  Created by Chung on 12/27/16.
//  Copyright © 2016 3i. All rights reserved.
//
import UIKit
import Foundation
extension UITextView {

    func autoResize() {
        let fixedWidth = self.frame.size.width
        self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = self.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        self.frame = newFrame;
    }
 }
