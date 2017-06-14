//
//  TextView.swift
//  RaoViet
//
//  Created by Chung on 11/28/16.
//  Copyright © 2016 3i. All rights reserved.
//

import Foundation
import UIKit
extension UITextField {
    func addIconForTextView(_ stringImage: String) {
        let leftIcon = UIImageView(image: UIImage(named: stringImage)?.withRenderingMode(.automatic))
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        leftIcon.center = paddingView.center
        paddingView.addSubview(leftIcon)
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func addIconTextFieldRight(imageName : String!){
        
        let rightIcon = UIImageView(image: UIImage(named: imageName)?.withRenderingMode(.automatic))
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        rightIcon.center = paddingView.center
        paddingView.addSubview(rightIcon)
        self.rightView = paddingView
        self.rightViewMode = .never
        
        
        
        
    }
    
    
    func showAndHiddenIconTextField(showAndHidden : Bool ){
        
        if(showAndHidden){
            self.rightViewMode  = .always
        }else{
            self.rightViewMode = .never
        }
    }
}
