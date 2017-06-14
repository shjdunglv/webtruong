//
//  TypeCombobox.swift
//  RaoViet
//
//  Created by Chung on 12/1/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit
import DropDown
class TypeCombobox: UITableViewCell {

    var lbTitle: UILabel!
    var dropdown: DropDown!
    var layoutTop: NSLayoutConstraint!
    var layoutBot: NSLayoutConstraint!
    var layoutLeft: NSLayoutConstraint!
    var layoutRight: NSLayoutConstraint!
    var layoutHeight: NSLayoutConstraint!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubView()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func addSubView() {
        if lbTitle == nil {
            lbTitle = UILabel()
            self.addSubview(lbTitle!)
            lbTitle.translatesAutoresizingMaskIntoConstraints = false
             layoutTop = NSLayoutConstraint(item: lbTitle, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 8)
            layoutHeight = NSLayoutConstraint(item: lbTitle, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)
             layoutRight = NSLayoutConstraint(item: lbTitle, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 8)
             layoutLeft = NSLayoutConstraint(item: lbTitle, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant:8)
            NSLayoutConstraint.activate([layoutTop, layoutLeft, layoutRight, layoutHeight])
        }
        if dropdown == nil {
            dropdown = DropDown()
            self.addSubview(dropdown!)
            dropdown.translatesAutoresizingMaskIntoConstraints = false
            layoutTop = NSLayoutConstraint(item: dropdown, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 8)
            layoutHeight = NSLayoutConstraint(item: dropdown, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
            layoutRight = NSLayoutConstraint(item: dropdown, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 8)
            layoutLeft = NSLayoutConstraint(item: dropdown, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant:8)
            NSLayoutConstraint.activate([layoutTop, layoutLeft, layoutRight, layoutHeight])
            
        }
        
    }
    
}
