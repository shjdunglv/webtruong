//
//  CreateJob.swift
//  RaoViet
//
//  Created by Chung on 12/15/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit
import DropDown
import CoreLocation

class CreateJob: BaseCreatePost {
    
    @IBOutlet weak var tfTitle: CustomTextFieldForSearch!
    
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var tfphone: CustomTextFieldForSearch!
    
    @IBOutlet weak var tfMoney: CustomTextFieldForSearch!
    
    
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
    }
    
    override func configSubView() {
        super.configSubView()
        self.tvContent.autoResize()
        tfTitle.addIconTextFieldRight(imageName: "error")
        tfTitle.delegate = self
        tfphone.delegate = self
        tvContent.layer.borderColor = UIColor.black.cgColor
        tvContent.layer.cornerRadius = 8.0
        tvContent.layer.borderWidth = 1
        tfMoney.addIconForTextView("money")
        tfphone.addIconTextFieldRight(imageName: "error")
        tfMoney.addIconTextFieldRight(imageName: "error")
        
        
        let fixedWidth = tvContent.frame.size.width
        
        tvContent.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = tvContent.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = tvContent.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        tvContent.frame = newFrame;
        
    }
    
    override  func handelPost() {
        validateText()
    }
    
    
    func validateText(){
        if tfTitle.text != "" {
            self.my_title = tfTitle.text
            tfTitle.showAndHiddenIconTextField(showAndHidden: false)
            
        }else {
            self.showAlert(msg: "Bạn chưa nhập tiêu đề bài đăng")
            tfTitle.showAndHiddenIconTextField(showAndHidden: true)
            return
        }
        if let phone = tfphone.text {
            if let _ = Int(phone) {
                self.phone = phone
                tfphone.showAndHiddenIconTextField(showAndHidden: false)
            }else {
                tfphone.showAndHiddenIconTextField(showAndHidden: true)
            }
            
        }else {
            self.phone = ""
        }
        if let money = tfMoney.text {
            if let _ = Int(money) {
                self.money = money
                tfMoney.showAndHiddenIconTextField(showAndHidden: false)
            }else {
                tfMoney.showAndHiddenIconTextField(showAndHidden: true)
            }
            
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
            editPost(type: _type,my_title: self.my_title, content: self.content, phone: self.phone, price: money)
        }else {
            type_Create(type: _type,my_title: self.my_title, content: self.content, phone: self.phone, price: money)
        }
    }
    
    func type_Create (type : typePost,my_title: String, content: String, phone: String,  price: String){
        self.hideKebroad()
        ManagerData.instance.insertPostNew(type: type ,
                                           post_title: my_title,
                                           post_content:content,
                                           post_author: self.user.id,
                                           phone: phone,
                                           statecity: IDState,
                                           zipcode: ZipCodeState,
                                           gps: post_GPS,
                                           image: "",
                                           price: price,
                                           success: { msg in
                                            //pussh notify
                                            self.pushNotify(type: self._type, user_id: self.user.id, message: self.user.display_name, post_id: msg, profile_picture: self.user.picture_profile!)
                                            
        },fail: { msg in
            self.showAlert(msg: msg)
        })
    }
    func editPost (type : typePost,my_title: String, content: String, phone: String, price: String){
        self.showActivity(isShow: true)
        ManagerData.instance.editPost(type: type ,
                                      post_title: my_title,
                                      post_content:content,
                                      id: self.postDetail?.id,
                                      phone: phone,
                                      statecity: IDState,
                                      zipcode: ZipCodeState,
                                      gps: post_GPS,
                                      image: "",
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
extension CreateJob: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tfTitle {
            textField.showAndHiddenIconTextField(showAndHidden: false)
            
        }
    }
}
