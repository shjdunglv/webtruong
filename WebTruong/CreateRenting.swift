//
//  CreateMarket.swift
//  RaoViet
//
//  Created by ReasonAmu on 12/15/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit
import DropDown
import CoreLocation

class CreateRenting: BaseCreatePost {
    
    @IBOutlet weak var tfMoney: CustomTextFieldForSearch!
    @IBOutlet weak var tfTitle: CustomTextFieldForSearch!
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var tfphone: CustomTextFieldForSearch!
    @IBOutlet weak var my_collection: UICollectionView!
    @IBOutlet weak var contrainLeading: NSLayoutConstraint!
    
    @IBOutlet weak var btnUpload: CustomButton!
    var linkImage = [String]()
    var listImage = [UIImage]()
    var string_Image = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        addActivity()
        configSubView()
        getDataState()
        customDropDown(self, dropDowns: dropDowns)
        if isEditPost {
            setValueForEdit()
        }else {
            getLocationUser()
            
        }
    }
    func setValueForEdit() {
        if let zipcode = postDetail?.zipcode {
            changeZipCodeToString(str_ZipCode: zipcode)
            self.btnState.setTitle(self.stateForEdit, for: .normal)
            self.btnCity.setTitle(self.cityForEdit, for: .normal)
            self.btnZipcode.setTitle(zipcode, for: .normal)
        }else {
            self.btnState.setTitle("Chọn", for: .normal)
            self.btnCity.setTitle("Chọn", for: .normal)
            self.btnZipcode.setTitle("Chọn", for: .normal)
        }
        
        tfTitle.text = postDetail?.post_title
        tvContent.text = postDetail?.post_content
        if let phone = postDetail?.phone {
            tfphone.text = phone
        }
        if let gps = postDetail?.gps {
            self.post_GPS = gps
        }
        if let money = postDetail?.price {
            tfMoney.text = money
        }else if let money2 = postDetail?.salary {
            tfMoney.text = money2
        }
        if let myImage = postDetail?.image {
            linkImage  = (myImage.convertString(type: "|"))
            if linkImage.last == "" {
                if linkImage.count > 1 {
                    linkImage.remove(at: numberImage.count - 1)
                }
            }else if linkImage.count == 3 {
                contrainLeading.constant = 8
                btnUpload.isHidden = true
            }else {
                contrainLeading.constant = 76
                btnUpload.isHidden = false
            }
            DispatchQueue.main.async {
                self.my_collection.reloadData()
            }
            
        }    }

    
    override func configSubView() {
        super.configSubView()
        tfTitle.addIconTextFieldRight(imageName: "error")
        my_collection.dataSource = self
        my_collection.delegate = self
        my_collection.register(UINib(nibName: "CellUpLoadImage", bundle: nil), forCellWithReuseIdentifier: cellID)
        tfTitle.delegate = self
        tfphone.delegate = self
        tvContent.layer.borderColor = UIColor.black.cgColor
        tvContent.layer.cornerRadius = 8.0
        tvContent.layer.borderWidth = 1
        tfMoney.addIconForTextView("money")

        
    }

    override  func handelPost() {
        validateText()
    }
    
   
    
    func validateText(){
       
        for (index, _) in linkImage.enumerated() {
            if linkImage.count == 1 {
                string_Image = linkImage[index]
                break
            }
            if index == linkImage.count - 1 {
                string_Image += linkImage[index]
                break
            }
            string_Image += linkImage[index] + "|"
        }
        if tfTitle.text != "" {
            self.my_title = tfTitle.text
            tfTitle.showAndHiddenIconTextField(showAndHidden: false)

        }else {
            self.showAlert(msg: "Bạn chưa nhập tiêu đề bài đăng")
            tfTitle.showAndHiddenIconTextField(showAndHidden: true)

            return
        }
        if let phone = tfphone.text {
            self.phone = phone
        }else {
            self.phone = ""
        }
        if let money = tfMoney.text {
            self.money = money
        }else {
            self.money = ""
        }
        if tvContent.text != "" {
            self.content = tvContent.text
        }else {
            self.showAlert(msg: "Bạn chưa nhập nội dung bài đăng")
            return
        }
        checkValueDropdown()
        if isEditPost {
            editPost(type: _type,my_title: self.my_title, content: self.content, phone: self.phone,image: string_Image,price: money)
        }else {
            type_Create(type: _type,my_title: self.my_title, content: self.content, phone: self.phone,image: string_Image, price: money)
        }
    }
   
    
    
    @IBAction func actionUpload(_ sender: CustomButton) {
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion:nil)
    }
    func type_Create (type : typePost,my_title: String, content: String, phone: String,image : String, price: String){
        ManagerData.instance.insertPostNew(type: type ,
                                           post_title: my_title,
                                           post_content:content,
                                           post_author: self.user.id,           
                                           phone: phone,
                                           statecity: IDState,
                                           zipcode: ZipCodeState,
                                           gps: post_GPS,
                                           image: image,
                                           price: price,
                                           success: { msg in
                                            self.pushNotify(type: self._type, user_id: self.user.id, message: self.user.display_name, post_id: msg, profile_picture: self.user.picture_profile!)
        },fail: { msg in
            self.showAlert(msg: msg)
        })
    }
    
    func editPost (type : typePost,my_title: String, content: String, phone: String,image : String,price: String){
        self.showActivity(isShow: true)
        ManagerData.instance.editPost(type: type ,
                                      post_title: my_title,
                                      post_content:content,
                                      id: self.postDetail?.id,
                                      phone: phone,
                                      statecity: IDState,
                                      zipcode: ZipCodeState,
                                      gps: post_GPS,
                                      image: image,
                                      price: price,
                                      success: { msg in
                                        self.showAlertWithMess(msg: "Cập nhật thành công")
        })
    }
    
    func cleanText(){
        tfphone.text = ""
        tfTitle.text = ""
        tvContent.text = ""
    }
    
    
    
    
}
extension CreateRenting: UITextFieldDelegate  {

//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        textField.addTarget(self, action: #selector(checkCharacterInput), for: .editingChanged)
//        return true
//    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tfTitle {
            textField.showAndHiddenIconTextField(showAndHidden: false)
            
        }
    }

}
extension CreateRenting : UINavigationControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDelegateFlowLayout {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.showActivity(isShow: true)
            ManagerData.instance.uploadImagePost(image: image, with: randomImageName(with: self.user.id), success: { (msg) in
                self.linkImage.append(msg)
                self.listImage.append(image)
                DispatchQueue.main.async {
                    self.my_collection.reloadData()
                }
                if self.listImage.count == 3 {
                    self.isFullListImage(bool: true)
                }
                self.showActivity(isShow: false)
                
            }, failure: { (msg) in
                
            })
            
        } else{
            print("Không cast được ảnh")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func isFullListImage(bool : Bool){
        if  bool == true {
            contrainLeading.constant = 8
            btnUpload.isHidden = true
        }else{
            contrainLeading.constant = 76
            btnUpload.isHidden = false
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let width = collectionView.frame.width/3 - 1
        return CGSize(width: 100, height: 100)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    
}

extension CreateRenting : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CellUpLoadImage
        cell.delegate = self as CellPickedDelegate!

        if isEditPost {
            if let item: String = linkImage[indexPath.item] {
                if item != "" {
                    self.loadImage(url_image: URL(string: item), imageView: cell.imageUpload, key: item)
                }
                
            }
            
        }else if let item2: UIImage = listImage[indexPath.item] {
            cell.imageUpload.image  = item2
            
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isEditPost {
            return linkImage.count
        }else {
            return listImage.count
        }    }
}

extension CreateRenting : CellPickedDelegate  {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKebroad()
    }
    
    func deleteCell(cell: CellUpLoadImage) {
        my_collection.performBatchUpdates({
            let indexPath = self.my_collection.indexPath(for: cell)
            self.listImage.remove(at: (indexPath?.item)!)
            self.my_collection.deleteItems(at: [indexPath!])
            
        }, completion: { finish in
            
            self.isFullListImage(bool: false)
            
        })
    }
}
