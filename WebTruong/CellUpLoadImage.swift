//
//  CellUpLoadImage.swift
//  RaoViet
//
//  Created by ReasonAmu on 12/8/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit

protocol CellPickedDelegate {
    func deleteCell(cell : CellUpLoadImage)
}

class CellUpLoadImage: UICollectionViewCell {
    
    var delegate : CellPickedDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageUpload.layer.cornerRadius = 10
        imageUpload.layer.masksToBounds = true
        
    }
    
    @IBOutlet weak var imageUpload: UIImageView!
    @IBAction func removeImage(_ sender: UIButton) {
        
       delegate.deleteCell(cell: self)
        
    }
    
    
    
}
