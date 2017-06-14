//
//  LoginViewController.swift
//  RaoViet
//
//  Created by Chung on 11/28/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import Google
class LoginViewController: BaseViewController {
    static let KEY_PHONE_EMAIL = "key_phone_email"
    static let KEY_PASSWORD = "key_password"
    static let USER_ID = "user_id"
    static let USER_picture = "user_picture"
    static let USER_EMAIL = "user_email"
    static let USER_NAME = "user_name"
    static let USER_DISPLAYNAME = "user_displayname"
    var phone_email: String!
    var password: String!
    
    
    @IBOutlet weak var tfPhone: CustomTextField!
    
    @IBOutlet weak var tfPassword: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSubView()
        addActivity()
        
    }
    func configSubView() {
        tfPhone.addIconForTextView("user")
        tfPhone.addIconTextFieldRight(imageName: "error")
        tfPassword.addIconForTextView("password")
        tfPassword.addIconTextFieldRight(imageName: "error")
        tfPhone.delegate = self
        tfPassword.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tfPhone.text = ""
        tfPassword.text = ""
        tfPassword.showAndHiddenIconTextField(showAndHidden: false)
        tfPhone.showAndHiddenIconTextField(showAndHidden: false)
        if let pass = userDefault.object(forKey: LoginViewController.KEY_PASSWORD) as? String , let email = userDefault.object(forKey:
            LoginViewController.USER_NAME) as? String{
            tfPhone.text = email
            tfPassword.text = pass
            checkLogin(phone_email: email, password: pass)
        }

        
    }
    
    @IBAction func btnRegister(_ sender: UIButton) {
        tfPhone.resignFirstResponder()
        let register = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        self.present(register, animated: true, completion: nil)
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        
        if (tfPhone.text == "") && (tfPassword.text == "") {
            tfPhone.showAndHiddenIconTextField(showAndHidden: true)
            tfPassword.showAndHiddenIconTextField(showAndHidden: true)
            self.showAlert(msg: "Bạn chưa nhập tài khoản và mật khẩu")
            return
            
        }
        
//        if tfPhone.text != "" {
//            if self.validatePhone(value: tfPhone.text!) {
//                self.phone_email = tfPhone.text
//                tfPhone.showAndHiddenIconTextField(showAndHidden: false)
//
//            }else if self.validateEmail(testStr: tfPhone.text!) {
//                self.phone_email = tfPhone.text
//                tfPhone.showAndHiddenIconTextField(showAndHidden: false)
//
//            }else {
//                self.showAlert(msg: "Email hoặc số điện thoại không đúng định dạng")
//                tfPhone.showAndHiddenIconTextField(showAndHidden: true)
//
//                return
//            }
//        }else {
//            self.showAlert(msg: "Bạn chưa nhập Email hoặc số điện thoại")
//            tfPhone.showAndHiddenIconTextField(showAndHidden: true)
//
//            return
//        }
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
        checkLogin(phone_email: tfPhone.text!, password: tfPassword.text!)
    }
    
    func checkLogin(phone_email: String, password: String) {
        showActivity(isShow: true)
//        ManagerData.instance.login(phone_email: phone_email, password: password, device: self.getUDID(), success: {[unowned self] (json, msg) in
//            self.user = User(from: (json?.array?.first)!)
//            self.saveAccount(phone_email, pass: password)
//            UserData.instance.user = self.user
//            self.saveData(user: self.user)
//            self.addNav()
//            self.showActivity(isShow: false)
////            self.registerSubcribeNotify(user_id: self.user.id)
//            }, fail: { msg in
//                self.showAlert(msg: "Đăng nhập thất bại")
//        })
        ManagerData.instance.submitLogin(userid: phone_email, pass: password, success:  {
            [unowned self] (json) in
            self.user = User(from: json[2])
            UserData.instance.user = self.user
            self.saveData(user: self.user)
            self.saveAccount(phone_email, pass: password)
            self.addNav()
            self.showActivity(isShow: false)
            //self.registerSubcribeNotify(user_id: self.user.id)
            }, fail: {[unowned self] msg in
                self.showAlert(msg: msg)
            }
        )
    }
   
    
    
    
    func registerSubcribeNotify(user_id: String) {
        ManagerData.instance.registerSubcribeNotify(user_id: user_id, device: self.getUDID(), token_id: self.getTokenId(), success: {[unowned self] (msg) in
            if msg == "ok" {
                self.showActivity(isShow: false)
                self.addNav()
            }
            else{
                self.showAlert(msg: msg)
                
            }
        })   
    }
    func getTokenId() -> String {
        if let myAppdelegate = UIApplication.shared.delegate as? AppDelegate {
            return  myAppdelegate.registrationToken!
        }else {
            return ""
        }
        
    }
}
extension LoginViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKebroad()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case tfPhone:
            tfPhone.showAndHiddenIconTextField(showAndHidden: false)
        case tfPassword:
            tfPassword.showAndHiddenIconTextField(showAndHidden: false)
        default:
            break
        }
        
    }
}
