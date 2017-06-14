//
//  PaddingLabel.swift
//  RaoViet
//
//  Created by Chung on 12/22/16.
//  Copyright © 2016 3i. All rights reserved.
//
import UIKit
import Foundation
class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 3.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 5.0
    @IBInspectable var rightInset: CGFloat = 5.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
    
    func setConeradiusTop() {
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.frame
        rectShape.position = self.center
        rectShape.backgroundColor = UIColor(hex: "#FFF5DF").cgColor
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topRight , .topLeft], cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.layer.mask = rectShape
    }
    func setConeradiusBottom() {
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.frame
        rectShape.position = self.center
        rectShape.backgroundColor = UIColor(hex: "#FFF5DF").cgColor
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 8, height: 8)).cgPath
        
        self.layer.mask = rectShape
    }
    
}
