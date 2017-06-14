//
//  RegisterViewController.swift
//  RaoViet
//
//  Created by Chung on 11/28/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {
    
    @IBOutlet weak var tfEmailOrphone: CustomTextField!
    @IBOutlet weak var tfName: CustomTextField!
    @IBOutlet weak var tfPassword: CustomTextField!
    var independent = "0"
    
    var email: String?
    var name: String?
    var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSubView()
    }
    func configSubView() {
        tfName.addIconForTextView("user")
        tfName.addIconTextFieldRight(imageName: "error")
        
        tfPassword.addIconForTextView("password")
        tfPassword.addIconTextFieldRight(imageName: "error")
        
        tfEmailOrphone.addIconForTextView("mail")
        tfEmailOrphone.addIconTextFieldRight(imageName: "error")
        
        tfPassword.delegate = self
        tfName.delegate = self
        tfEmailOrphone.delegate = self
    }
    override func viewDidLayoutSubviews() {
        addActivity()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearText()
    }
    func clearText(){
        tfName.text = ""
        tfPassword.text = ""
        tfEmailOrphone.text = ""
        tfEmailOrphone.showAndHiddenIconTextField(showAndHidden: false)
        tfPassword.showAndHiddenIconTextField(showAndHidden: false)
        tfName.showAndHiddenIconTextField(showAndHidden: false)
    }
    
    
    func checkCharacter(str: String) -> Bool {
        print(str[str.characters.index(before: str.characters.index(of: "@")!)])
        if str[str.characters.index(before: str.characters.index(of: "@")!)] == "." {
            return false
        }else {
            return true
        }
    }
    
    //{"first_name":"","last_name":"", "email":"", "phone":""}
    
    @IBAction func ActionRegister(_ sender: Any) {
        hideKebroad()
        
        if (tfEmailOrphone.text == "") && (tfPassword.text == "") && (tfName.text == "") {
            tfEmailOrphone.showAndHiddenIconTextField(showAndHidden: true)
            tfPassword.showAndHiddenIconTextField(showAndHidden: true)
            tfName.showAndHiddenIconTextField(showAndHidden: true)
            self.showAlert(msg: "Bạn chưa nhập thông tin")
            return
            
        }
        if tfEmailOrphone.text != "" {
            if self.validatePhone(value: tfEmailOrphone.text!) {
                tfEmailOrphone.showAndHiddenIconTextField(showAndHidden: false)
                self.email = tfEmailOrphone.text
            }else if (self.validateEmail(testStr: tfEmailOrphone.text!)) && checkCharacter(str: tfEmailOrphone.text!) {
                tfEmailOrphone.showAndHiddenIconTextField(showAndHidden: false)
                self.email = tfEmailOrphone.text
            }else {
                self.showAlert(msg: "Email hoặc số điện thoại không đúng định dạng")
                tfEmailOrphone.showAndHiddenIconTextField(showAndHidden: true)
                return
            }
        }else {
            self.showAlert(msg: "Bạn chưa nhập Email hoặc số điện thoại")
            tfEmailOrphone.showAndHiddenIconTextField(showAndHidden: true)
            return
        }
        
        if tfPassword.text != nil {
            if (tfPassword.text?.characters.count)! >= 6 {
                self.password = tfPassword.text
                tfPassword.showAndHiddenIconTextField(showAndHidden: false)
                
            }else {
                self.showAlert(msg: "Mật khẩu phải lớn hơn 6 ký tự")
                tfPassword.showAndHiddenIconTextField(showAndHidden: true)
                
                return
            }
        }else {
            self.showAlert(msg: "Bạn chưa nhập mật khẩu")
            tfPassword.showAndHiddenIconTextField(showAndHidden: true)
            
            return
            
        }
        
        if tfName.text != "" {
            if ((tfName.text?.length)! >= 2) && ((tfName.text?.length)! <= 20)  {
                if (tfName.text?.contains("  "))! {
                    self.showAlert(msg: "Tên người dùng phải khác ký tự '  '")
                    tfName.showAndHiddenIconTextField(showAndHidden: true)
                    return
                }
                self.name = tfName.text
                tfName.showAndHiddenIconTextField(showAndHidden: false)
                
            }else {
                self.showAlert(msg: "Tên người dùng 2-20 ký tự")
                tfName.showAndHiddenIconTextField(showAndHidden: true)
                return
            }
            
        }else {
            self.showAlert(msg: "Bạn chưa nhập tên người dùng")
            tfName.showAndHiddenIconTextField(showAndHidden: true)
            
            return
        }
        
        
        
        showActivity(isShow: true)
        ManagerData.instance.register(displayName: name!, phone_email: email!, password: password!, device: self.getUDID(), independent: independent, success: {[unowned self] (json, msg) in
            self.user = User(from: (json?.array?.first)!)
            self.showActivity(isShow: false)
            self.showAlert(msg: "Đăng ký tài khoản thành công")
            self.saveAccount(self.email!, pass: self.password!)
            self.dismiss(animated: true, completion: nil)
            }, fail: { msg in
                self.showAlert(msg: msg)
        })
        
        
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        hideKebroad()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func checkBox(_ sender: CheckBox) {
        sender.isChecked = !sender.isChecked
        if sender.isChecked {
            independent = "1"
        }else {
            independent = "0"
        }
        print(independent)
        
    }
    
    
    
    
}
extension RegisterViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKebroad()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case tfEmailOrphone:
            tfEmailOrphone.showAndHiddenIconTextField(showAndHidden: false)
        case tfName:
            tfName.showAndHiddenIconTextField(showAndHidden: false)
        case tfPassword:
            tfPassword.showAndHiddenIconTextField(showAndHidden: false)
        default:
            break
        }
        
    }
    
}
