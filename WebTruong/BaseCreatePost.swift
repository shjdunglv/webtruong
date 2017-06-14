//
//  BaseCreatePost.swift
//  RaoViet
//
//  Created by ReasonAmu on 12/18/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit
import DropDown

class BaseCreatePost: BaseScrollView {
    
    var _type: typePost!
    var imagePicker =  UIImagePickerController()
    var dataStates = Set<String>()
    var dataCity = Set<String>()
    var dataZipcode = Set<String>()
    
    var ddPosition = DropDown()
    var ddGender = DropDown()
    var ddTime = DropDown()
    var ddMoney = DropDown()
    var ddState = DropDown()
    var ddCity = DropDown()
    var ddZipCode = DropDown()
    var ddChuKi = DropDown()
    
    lazy var dropDowns: [DropDown] = {
        return [
            self.ddPosition,
            self.ddGender,
            self.ddTime,
            self.ddMoney,
            self.ddState,
            self.ddCity,
            self.ddZipCode,
            self.ddChuKi
        ]
    }()
    @IBOutlet weak var btnCity: UIButton!
    @IBOutlet weak var btnState: UIButton!
    @IBOutlet weak var btnZipcode: UIButton!
    
    @IBOutlet weak var scrollViews: UIScrollView!
    
    
    var my_title: String!
    var content: String!
    var state: String!
    var city: String!
    var zipcode: String = ""
    var phone: String = ""
    var image : String = ""
    var categories: String?
    var money: String = ""
    
    
    var IDState: String = ""
    var ZipCodeState : String = ""
    
    let cellID = "CellID"
    
    var postDetail: PostDetail?
    var isEditPost: Bool = false
    var stateForEdit: String?
    var cityForEdit: String?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let user =   UserData.instance.user {
            self.user = user
        }
        setupKeyboardObservers()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleNavigation(type: _type)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapScreen))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    
    func tapScreen(){
        self.hideKebroad()
    }
    
    func setTitleNavigation(type: typePost){
        switch type {
        case .enterprise:
            self.title = "Create Enterprise"
        case .worker:
            self.title = "Create Worker"
        case .buy:
            self.title = "Create Buy"
        case .sell:
            self.title = "Create Sell"
        case .lease:
            self.title = "Create Lease"
        case .rent:
            self.title = "Create Rent"
        default:
            break
        }
    }
    
    
    
    //-- Check ID State - POST
    func checkID_StateCity(str_ZipCode : String!,
                           finish : @escaping (_ id: String , _ zipcode : String ) -> ()){
        var idState : String!
        var zipcodeState: String!
        for item in dataState {
            if  item.zipcode == str_ZipCode {
                idState = item.id
                zipcodeState = item.zipcode
                finish(idState,zipcodeState)
                break
            }
        }
    }
    
    
    // change zipcode - string
    func changeZipCodeToString(str_ZipCode : String!){
        for item in dataState {
            if  item.zipcode == str_ZipCode {
                self.stateForEdit = item.state
                self.cityForEdit = item.city
                break
            }
        }
    }
    
    
    
    //-- Handle touch
    
    @IBAction func ActionDropDown(_ sender: UIButton) {
        self.hideKebroad()
        switch sender {
        case btnState:
            ddState.show()
        case btnCity:
            ddCity.show()
        case btnZipcode:
            ddZipCode.show()
        default:
            break
        }
    }
    
    
    //-- config subview
    
    func configSubView() {
        
        let imageSave  = UIImage(named: "save")?.withRenderingMode(.alwaysOriginal)
        let post = UIBarButtonItem(image: imageSave, style: .plain, target: self, action: #selector(handelPost))
        self.navigationItem.rightBarButtonItem = post
        btnState.layer.borderColor = UIColor.black.cgColor
        btnState.layer.cornerRadius = 8.0
        btnState.layer.borderWidth = 1
        btnCity.layer.borderColor = UIColor.black.cgColor
        btnCity.layer.cornerRadius = 8.0
        btnCity.layer.borderWidth = 1
        btnZipcode.layer.borderColor = UIColor.black.cgColor
        btnZipcode.layer.cornerRadius = 8.0
        btnZipcode.layer.borderWidth = 1
        
        
        
    }
    
    func handelPost() {
    }
    
    
    //-- GET DATA STATES
    func getDataState() {
        showActivity(isShow: true)
        ManagerData.instance.getAllState(success: { (data, msg) in
            self.dataState = data
            for item in data {
                self.dataStates.insert(item.state!)
            }
            self.setUpDropDown()
            self.showActivity(isShow: false)
        }, fail: { msg in
            print(msg)
        })
        
    }
    //-- Set Data
    func setUpDropDown() {
        
        // self.configDropDown(data: self.dataMoney, dropDown: self.ddMoney, button: self.btnMoney)
        if (Array(self.dataStates).count > 0) {
            self.configDropDown(data: Array(self.dataStates).sorted(), dropDown: self.ddState, button: self.btnState)
            self.configDropDown(data: Array(self.dataCity).sorted(), dropDown: self.ddCity, button: self.btnCity)
            configDropDown(data: Array(self.dataZipcode.sorted()), dropDown: ddZipCode, button: self.btnZipcode)
        }
    }
    
    
    
    //-- set layout
    func configDropDown(data: [String], dropDown: DropDown ,button: UIButton) {
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets =  UIEdgeInsetsMake(0, 8, 0, 0)
        button.layer.cornerRadius = 5.0
        dropDown.anchorView = button
        dropDown.bottomOffset = CGPoint(x: 0, y: button.bounds.height)
        dropDown.dataSource = data
        
        if button.titleLabel?.text == nil {
            button.setTitle(data[0], for: .normal)
            
        }
        
        
        dropDown.selectionAction = { [unowned self] (index, item) in
            button.setTitleColor(UIColor.black, for: .selected)
            button.setTitle(item, for: .normal)
            
            switch button {
            case self.btnState:
                self.state = item
                self.dataCity.removeAll()
                self.dataCity = self.getCitys(state: item)
                self.configDropDown(data: Array(self.dataCity).sorted(), dropDown: self.ddCity, button: self.btnCity)
            case self.btnCity:
                self.city = item
                self.dataZipcode.removeAll()
                self.dataZipcode = self.getZipcodes(city: item)
                self.configDropDown(data: Array(self.dataZipcode).sorted(), dropDown: self.ddZipCode, button: self.btnZipcode)
            case self.btnZipcode :
                self.zipcode = item
            default:
                break
            }
        }
        
    }
    
    
    
    
    
    
    
    //push notify
    func pushNotify(type: typePost,user_id: String, message: String, post_id: String, profile_picture: String ) {
        var temp: String!
        switch type {
        case .enterprise:
            self.categories = "enterprise"
            temp = "\(message) đang tìm người làm"
        case .worker:
            self.categories = "worker"
            temp = "\(message) đang tìm việc làm"
        case .buy:
            self.categories = "buy"
            temp = "\(message) đang tìm người mua"
        case .sell:
            self.categories = "sell"
            temp = "\(message) đang tìm người bán"
        case .rent:
            self.categories = "rent"
            temp = "\(message) đang tìm người thuê"
        case .lease:
            self.categories = "lease"
            temp = "\(message) đang tìm người cho thuê"
        default:
            break
        }
        ManagerData.instance.pushNotify(user_id: user_id,categories: categories!,message: temp, post_id: post_id, profile_picture: profile_picture, type_message: categories! , success: {[unowned self] json, msg in
            if msg == "ok" {
                 self.showAlertWithMess(msg: "Tạo bài đăng thành công")
            }
            }, fail: { msg in
                self.showAlert(msg: "Tạo bài đăng thất bại")
        })
        
    }
    
    override func showAlertWithMess(msg: String) {
        let alert  = UIAlertController(title: "Thông báo", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đóng", style: .cancel) { (ok) in
            self.showActivity(isShow: true)
            self.navigationController?.popViewController(animated: true)
            }
        )
       
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
}


//extension BaseCreatePost : UINavigationControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDelegateFlowLayout {
//
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
//
//            self.showActivity(isShow: true)
//            ManagerData.instance.uploadImagePost(image: image, with: randomImageName(with: post_author), success: { (msg) in
//
//                self.linkImage.append(msg)
//                self.listImage.append(image)
//                self.collectionViews.reloadData()
//
//                if self.listImage.count == 3 {
//                    self.isFullListImage(bool: true)
//                }
//                self.showActivity(isShow: false)
//
//            }, failure: { (msg) in
//
//            })
//
//        } else{
//            print("Không cast được ảnh")
//        }
//
//        dismiss(animated: true, completion: nil)
//    }
//
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//
//    }
//
//
//    func isFullListImage(bool : Bool){
//        if  bool == true {
//            leadingCollectionViews.constant = 8
//            btnUpload.isHidden = true
//        }else{
//            leadingCollectionViews.constant = 76
//            btnUpload.isHidden = false
//        }
//
//
//    }
//
//    //-- Collection View
//
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        //        let width = collectionView.frame.width/3 - 1
//        return CGSize(width: 100, height: 100)
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 5.0
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 5.0
//    }
//
//
//}
//
//extension BaseCreatePost : UICollectionViewDataSource,UICollectionViewDelegate{
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CellUpLoadImage
//        cell.delegate = self as CellPickedDelegate!
//        cell.imageUpload.image  = listImage[indexPath.item]
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return listImage.count
//    }
//
//
//
//}
//
//extension BaseCreatePost : CellPickedDelegate  {
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        hideKebroad()
//    }
//
//    func deleteCell(cell: CellUpLoadImage) {
//        collectionViews.performBatchUpdates({
//            let indexPath = self.collectionViews.indexPath(for: cell)
//            self.listImage.remove(at: (indexPath?.item)!)
//            self.collectionViews.deleteItems(at: [indexPath!])
//
//        }, completion: { finish in
//
//            self.isFullListImage(bool: false)
//
//        })
//    }
//}


extension BaseCreatePost {
    
    
    func checkValueDropdown() {
        
        showActivity(isShow: true)
        
        self.checkID_StateCity(str_ZipCode: self.zipcode, finish: { (id, zipcode) in
            self.IDState = id
            self.ZipCodeState = zipcode
            
        })
        
        
    }
    
}




extension BaseCreatePost {
    
    func setupKeyboardObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func removeKeyboardObservers(){
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
    func keyBoardWillShow(_ notification : Notification){
        
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollViews.contentInset = contentInsets
        scrollViews.scrollIndicatorInsets = contentInsets
        
        
    }
    
    func keyBoardWillHide(_ notification: Notification) {
        scrollViews.contentInset = UIEdgeInsets.zero
        scrollViews.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    
}
