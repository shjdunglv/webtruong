//
//  CellForUserApply.swift
//  RaoViet
//
//  Created by Chung on 12/28/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit

class CellForUserApply: UITableViewCell {
    @IBOutlet weak var mySubView: UIView!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbDate: UILabel!

    @IBOutlet weak var lbName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupViews(){
        mySubView.layer.borderColor = UIColor.black.cgColor
        mySubView.layer.borderWidth = 0.5
        mySubView.layer.cornerRadius = 8
        mySubView.layer.masksToBounds = true
    }
    
}
