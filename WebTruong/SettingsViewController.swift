//
//  SettingsViewController.swift
//  RaoViet
//
//  Created by ReasonAmu on 12/2/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit
import Kingfisher

class SettingsViewController: BaseViewController, PopupChangePasswordDelegate {
    
    @IBOutlet weak var btnChooseImage: UIButton!
    @IBOutlet weak var imAvatar: UIImageView!
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var switch_worker: UISwitch!
    
    @IBOutlet weak var switch_enterprise: UISwitch!
    
    @IBOutlet weak var switch_buy: UISwitch!
    
    @IBOutlet weak var switch_sell: UISwitch!
    
    @IBOutlet weak var switch_lease: UISwitch!
    
    @IBOutlet weak var switch_rent: UISwitch!
    
    var txtOldPass:String!
    var txtNewPass:String!
    var txtNewPassModifi:String!
    @IBAction func _btnChangePassword(_ sender: UIButton) {
        
        addPopupChangePassword()
    }
    
    //Add delegate Popup Change
    func checkResultPopChangePw(msg: String) {
        self.navigationItem.hidesBackButton = false
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        if !(msg.isEmpty) == true
        {
            showAlert(msg: msg)
        }
    }
    
    //Add popup
    func addPopupChangePassword()
    {
        //Hide left and right bar button in Navigation
        self.navigationItem.hidesBackButton = true
              self.navigationItem.rightBarButtonItem?.isEnabled = false
        //instance View
        let changePassWordVC = ChangePassword(nibName: "ChangePassword", bundle: nil)
        self.addChildViewController(changePassWordVC)
        //        changePassWordVC.preferredContentSize = CGSize(width: changePassWordVC.view.frame.width, height: changePassWordVC.view.frame.height)
        changePassWordVC.view.frame = CGRect(x: self.view.frame.width/2 - changePassWordVC.view.frame.width/2,y: self.view.frame.height/2 - changePassWordVC.view.frame.height/2, width: changePassWordVC.view.frame.width, height: changePassWordVC.view.frame.height)
        changePassWordVC.popUpchang = self
        self.view.addSubview(changePassWordVC.view)
    }
    var imagePicker =  UIImagePickerController()
    static let KEY_AVATAR = "avatar"
    
    var subcribe: String?
    
    var dataSwitch: [Status] = []
    
    //View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        let update = UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(SettingsViewController.update))
        self.navigationItem.rightBarButtonItem = update
        addActivity()
       
    }
    
    //View did appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configView()
         //getUserSubcrice(user_id: (user.id)!)
    }
    

    func configView() {
        imAvatar.layer.cornerRadius = 8.0
        //
        if let user = UserData.instance.user {
            self.user = user
            if let name = user.display_name {
                tfName.text = name
            }
            if let email = user.email {
                tfEmail.text = email
            }
            if let path = user.picture_profile {
                if path != "" {
                    loadImage(url_image: URL(string: path), imageView: imAvatar, key: path)
                }
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        
        self.showActivity(isShow: true)
        if ((tfName.text?.length)! >= 2) && ((tfName.text?.length)! <= 20) {
            if (tfName.text?.contains("  "))! {
                self.showAlert(msg: "Tên người dùng phải khác ký tự '  '")
                tfName.showAndHiddenIconTextField(showAndHidden: true)
                return
            }
            
            ManagerData.instance.editProfile(user_id: (user.id)!, display_name: tfName.text!, success: { (msg) in
                self.showAlert(msg: "Cập nhật thành công")
                UserData.instance.user?.display_name = self.tfName.text
            })
        }else {
            self.showAlert(msg: "Tên người dùng 2-20 ký tự")
        }
        
    }
    
    @IBAction func actionSelectPhoto(_ sender: CustomButton) {
        
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion:nil)
        
        
        
    }
    
    func getUserSubcrice(user_id: String) {
        self.showActivity(isShow: true)
        ManagerData.instance.getUserSubcribe(user_id: user_id, success: {[unowned self] json, msg in
            if (json?.array?.count)! > 0 {
                for item in (json?.array)! {
                    self.dataSwitch.append(Status(from: item))
                }
            }
            self.setDataSwitchForView(data: self.dataSwitch)
            self.showActivity(isShow: false)
            }, fail: { msg in
                self.showAlert(msg: msg)
        })
    }
    
    
    @IBAction func SwitchIsChange(_ sender: UISwitch) {
        switch sender {
        case switch_enterprise:
            subcribeNotify(categories: "enterprise", my_switch: switch_enterprise)
            break
        case switch_worker:
            subcribeNotify(categories: "worker", my_switch: switch_worker)
            break
        case switch_buy:
            subcribeNotify(categories: "buy", my_switch: switch_buy)
            break
        case switch_sell:
            subcribeNotify(categories: "sell", my_switch: switch_sell)
            break
        case switch_rent:
            subcribeNotify(categories: "rent", my_switch: switch_rent)
            break
        case switch_lease:
            subcribeNotify(categories: "lease", my_switch: switch_lease)
            break
        default:
            break
        }
    }
    func setDataSwitchForView(data: [Status])
    {
//        print(data.count)
        for status in data {
            switch status.categories! {
            case "worker":
                if status.subcribe == "0" {
                    switch_worker.isOn = false
                }else {
                    switch_worker.isOn = true
                }
                break
            case "enterprise":
                if status.subcribe == "0" {
                    switch_enterprise.isOn = false
                }else {
                    switch_enterprise.isOn = true
                }
                break
            case "buy":
                if status.subcribe == "0" {
                    switch_buy.isOn = false
                }else {
                    switch_buy.isOn = true
                }
                break
            case "sell":
                if status.subcribe == "0" {
                    switch_sell.isOn = false
                }else {
                    switch_sell.isOn = true
                }
                break
            case "rent":
                if status.subcribe == "0" {
                    switch_rent.isOn = false
                }else {
                    switch_rent.isOn = true
                }
                break
            case "lease":
                if status.subcribe == "0" {
                    switch_lease.isOn = false
                }else {
                    switch_lease.isOn = true
                }
                break
            default:
                break
            }
        }
    }
    func subcribeNotify(categories: String, my_switch: UISwitch ) {
        self.showActivity(isShow: true)
        if my_switch.isOn {
            subcribe = "1"
        }else {
            subcribe = "0"
        }
        ManagerData.instance.subcribeCategory(user_id: (user.id)!, categories: categories, subcribe: subcribe!, success: {[unowned self] (msg) in
            self.showAlert(msg: msg)
            
        })
    }
    
    
}
extension SettingsViewController : UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.showActivity(isShow: true)
            ManagerData.instance.uploadAvatar(image: image, user_id: (user.id)!, success: { (msg) in
                if let url = URL(string: msg) {
                    UserData.instance.user?.picture_profile = msg
                    self.loadImage(url_image: url, imageView: self.imAvatar, key: msg)
                    self.showAlert(msg: "Cập nhật ảnh thành công")
                    
                } else {
                    self.showAlert(msg: "Cập nhật ảnh thất bại")

                }
                
            }, fail: { (msg) in
                self.showAlert(msg: "Cập nhật ảnh thất bại")
            })
            
            
        } else{
            self.showAlert(msg: "không cast được ảnh")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
}


