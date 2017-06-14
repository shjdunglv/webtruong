//
//  CellProfile.swift
//  RaoViet
//
//  Created by ReasonAmu on 12/1/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit

class CellProfile: UITableViewCell,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    @IBOutlet weak var nameProfile: UITextField!
    var settingsVC : SettingsViewController?
    var imagePicker =  UIImagePickerController()
    
    @IBOutlet weak var imageProfile: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageProfile.addTarget(self, action: #selector(handleChooseImage), for: .touchUpInside)
        
        
    }
    
    
    var setupNameProfile: String?{
        didSet{
            nameProfile.text = setupNameProfile
        }
    }
    
    
    
    func handleChooseImage(){
        
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        settingsVC?.present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageProfile.setImage(image, for: .normal)
            
        } else{
            print("Không cast được ảnh")
        }
        
        self.settingsVC?.dismiss(animated: true, completion: {
            
        })
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.settingsVC?.dismiss(animated: true, completion: {
            
        })
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
