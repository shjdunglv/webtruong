//
//  CellNotification.swift
//  RaoViet
//
//  Created by ReasonAmu on 12/2/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit
import Kingfisher

class CellNotification: BaseTableViewCell {

    @IBOutlet weak var imageProfile: UIImageView!
    
    @IBOutlet weak var datetime: UILabel!
    @IBOutlet weak var title: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageProfile.contentMode = .scaleToFill
        imageProfile.layer.cornerRadius = 25
        imageProfile.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

        
    
}
