//
//  ChangePassword.swift
//  RaoViet
//
//  Created by HITECH on 1/3/17.
//  Copyright © 2017 3i. All rights reserved.
//

import UIKit
import SwiftyJSON

@objc protocol PopupChangePasswordDelegate{
    func checkResultPopChangePw(msg: String)
}
class ChangePassword: BaseViewController {
    @IBOutlet weak var tfOldPass: UITextField!
    @IBOutlet weak var tfNewPass: UITextField!
    @IBOutlet weak var tfRepeatNewPass: UITextField!
    weak var popUpchang : PopupChangePasswordDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showPopup()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.view.layer.cornerRadius = 10
        addActivity()
    }
    
    func showPopup()
    {
        
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations:{
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.alpha = 1.0}
        )
    }
    func removePopup()
    {
        UIView.animate(withDuration: 0.15, animations: {
            self.view.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.view.alpha = 0.5
        }, completion: { (finished: Bool) in
            if finished {
                UIView.animate(withDuration: 0.15, animations: {
                    self.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    self.view.alpha = 0.0
                },completion: {(finish: Bool) in if finish {self.view.removeFromSuperview()
                    
                    }}
                )
            }
        }
        )
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func _btnSave(_ sender: UIButton) {
        showActivity(isShow: true)
        if !(self.tfOldPass.text?.isEmpty)! || !(self.tfNewPass.text?.isEmpty)! || !(self.tfRepeatNewPass.text?.isEmpty)! {
            if (self.tfOldPass.text?.characters.count)! >= 6 && (self.tfNewPass.text?.characters.count)! >= 6 && (self.tfRepeatNewPass.text?.characters.count)! >= 6 {
                if (self.tfNewPass.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)) != (self.tfRepeatNewPass.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
                {
                    self.showAlert(msg: "Mật khẩu không khớp")
                }
                //                self.password = tfOldPass.text
                //                tfPassword.showAndHiddenIconTextField(showAndHidden: false)
                
            }else {
                self.showAlert(msg: "Mật khẩu phải lớn hơn 6 ký tự")
                //                tfPassword.showAndHiddenIconTextField(showAndHidden: true)
                
                return
            }
        }
        else {
            self.showAlert(msg: "Bạn chưa nhập mật khẩu")
            //            tfPassword.showAndHiddenIconTextField(showAndHidden: true)
            
            return
            
        }
        
        checkChangePassword(userid: userDefault.object(forKey: LoginViewController.USER_ID) as! String, oldPass: tfOldPass.text!, newPass: tfNewPass.text!, modifyPass: tfRepeatNewPass.text!)
        
    }
    
    @IBAction func _btnCancle(_ sender: UIButton) {
        
        self.popUpchang?.checkResultPopChangePw(msg: "")
        self.removePopup()
    }
    
    //Request Change
    func checkChangePassword(userid:String, oldPass: String, newPass: String, modifyPass: String)
    {
        ManagerData.instance.changePassword(userid: userid, oldPass: oldPass, newPass: newPass, modifyPass: modifyPass, success: {[unowned self] msg in
            if msg.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "ok"
            {
                self.removePopup()
                self.popUpchang?.checkResultPopChangePw(msg: msg)
            }
            else
            {
                self.showAlert(msg: msg)
            }
            }
        )
    }
    
}
