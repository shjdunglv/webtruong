//
//  CellForMenu.swift
//  RaoViet
//
//  Created by Chung on 12/1/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit

//struct DataTableViewCellData {
//    
//    init(imageUrl: String, text: String) {
//        self.imageUrl = imageUrl
//        self.text = text
//    }
//    var imageUrl: String
//    var text: String
//}
class CellForMenu: UITableViewCell {

    @IBOutlet weak var lbCount: UILabel!
    @IBOutlet weak var constranLeft: NSLayoutConstraint!
    @IBOutlet weak var titleMenu: UILabel!
    @IBOutlet weak var iconMenu: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(title: String, icon: String, level: Int) {
        
            self.iconMenu.image = UIImage(named: icon)
            self.titleMenu.text = title
                let left = 11.0 + 20.0 * CGFloat(level)
                constranLeft.constant = left
       
    }
    
}
