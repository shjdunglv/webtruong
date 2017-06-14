//
//  CellCollectionImage.swift
//  RaoViet
//
//  Created by ReasonAmu on 12/11/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit

class CellCollectionImage: UICollectionViewCell {
    @IBOutlet weak var imageViews: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }

}
