//
//  BaseViewController.swift
//  RaoViet
//
//  Created by Chung on 11/28/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit
import  DropDown
import Kingfisher
import SwiftyJSON
import MIBadgeButton_Swift
import SlideMenuControllerSwift

class BaseViewController: UIViewController {
    
    //data for dropdown
    let dataPosition = ["Nhân viên","Quản lý","Giám đốc","Nhóm trưởng", "Nhân viên lễ tân"]
    let dataGender = ["Nam", "Nữ"]
    let dataTime = ["Full time", "Part time"]
    let dataMoney = ["USD", "VND"]
    let dataMore = ["Sửa", "Xóa" , "Danh sách đăng ký"]
    
    var dataState: [State] = []
    
    var btnAdd: UIButton!
    var tableDetail: TableDetail!
    var my_Table:UITableView!
    
    var my_CollectionView: UICollectionView!
    
    var layoutTop: NSLayoutConstraint!
    var layoutBot: NSLayoutConstraint!
    var layoutRight: NSLayoutConstraint!
    var layoutLeft: NSLayoutConstraint!
    var layoutHeight: NSLayoutConstraint!
    var layoutWidth: NSLayoutConstraint!
    var layoutCenterX: NSLayoutConstraint!
    var layoutCenterY: NSLayoutConstraint!
    
    let userDefault = UserDefaults.standard

    //add Page Menu
    var pageMenu: CAPSPageMenu!
    
    //add Activity
    var loadingView: UIView!
    var loading: UIActivityIndicatorView!
    var background_acti: UIView!
    
    var profile_image: String?
    var message: String?
    var arrID: [String] = []
    var type_message: String?
    var notiBtn: UIBarButtonItem?
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configBaseView()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        KingfisherManager.shared.cache.cleanExpiredDiskCache()
        KingfisherManager.shared.cache.clearDiskCache()
        KingfisherManager.shared.cache.clearMemoryCache()
    }
    func addNav() {
        let tabbar = BaseTabbar() //List tab in bottom
        let nav = BaseNavigation(rootViewController: tabbar) //Navigation
        let menuVC = MenuViewController(nibName: "MenuViewController", bundle: nil) //Side Bar
        let slideMenuController = SlideMenuController(mainViewController: nav, leftMenuViewController: menuVC)
        self.present(slideMenuController, animated: true, completion: nil)
    }
    func configBaseView() {
        self.edgesForExtendedLayout = .bottom
        self.automaticallyAdjustsScrollViewInsets = false
        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(BaseViewController.menu))
        notiBtn = UIBarButtonItem(image: UIImage(named: "bell"), style: .plain, target: self, action: #selector(BaseViewController.showNoti))
        let searchBtn = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: #selector(search))
        self.tabBarController?.navigationItem.rightBarButtonItems = [notiBtn!,searchBtn]
        self.tabBarController?.navigationItem.leftBarButtonItem = menuBtn
        //Navigation Item
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(BaseViewController.menu))
        navigationItem.leftBarButtonItem = leftButton
    }
    func search() {
        
    }
    func menu() {
        slideMenuController()?.toggleLeft()
    }
    func saveAccount(_ phone_email: String, pass: String){
        userDefault.set(phone_email, forKey: LoginViewController.USER_NAME)
        userDefault.set(pass, forKey: LoginViewController.KEY_PASSWORD)
        userDefault.synchronize()
    }
    
    func saveData(user: User)
    {
        userDefault.set(user.id, forKey: LoginViewController.USER_ID)
        userDefault.set(user.username, forKey: LoginViewController.USER_NAME)
        userDefault.set(user.picture_profile, forKey: LoginViewController.USER_picture)
        userDefault.set(user.display_name, forKey: LoginViewController.USER_DISPLAYNAME)
        userDefault.synchronize()

    }
    func showNoti() {
        let notifiVC = NotificationVC(nibName: "NotificationVC", bundle: nil)
        notifiVC.title = "Thông báo"
        self.tabBarController?.navigationController?.pushViewController(notifiVC, animated: true)
    }
    func addTableView() {
        if my_Table == nil {
            my_Table = UITableView()
            my_Table.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(my_Table)
            layoutTop = NSLayoutConstraint(item: my_Table, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
            layoutBot = NSLayoutConstraint(item: my_Table, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -50)
            layoutRight = NSLayoutConstraint(item: my_Table, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
            layoutLeft = NSLayoutConstraint(item: my_Table, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
            NSLayoutConstraint.activate([layoutTop, layoutLeft, layoutRight, layoutBot])
            
        }
        
    }
    
    //Add collection view
    func addCollectionView() {
        if my_CollectionView == nil {
            var layoutCollection = UICollectionViewFlowLayout()
            layoutCollection.itemSize = CGSize(width: 100, height: 800)
            my_CollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layoutCollection)
            let bgView = UIImageView()
            //bgView.image = UIImage(named: "bgView.png")
            //bgView.contentMode = .center
                        my_CollectionView.backgroundColor = UIColor.gray
            my_CollectionView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(my_CollectionView)
            layoutTop = NSLayoutConstraint(item: my_CollectionView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
            layoutBot = NSLayoutConstraint(item: my_CollectionView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -50)
            layoutRight = NSLayoutConstraint(item: my_CollectionView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
            layoutLeft = NSLayoutConstraint(item: my_CollectionView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
            NSLayoutConstraint.activate([layoutTop, layoutLeft, layoutRight, layoutBot])
            
        }
        
        
    }
    //add table detail
    func addTableDetail() {
        if tableDetail == nil {
            tableDetail = TableDetail(nibName: "TableDetail", bundle: nil)
            tableDetail.willMove(toParentViewController: self)
            self.view.addSubview(tableDetail.view)
            self.addChildViewController(tableDetail)
            tableDetail.didMove(toParentViewController: self)
            
            tableDetail.view.translatesAutoresizingMaskIntoConstraints = false
            
            layoutTop = NSLayoutConstraint(item: tableDetail.view, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0)
            
            layoutBot = NSLayoutConstraint(item: tableDetail.view, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0)
            
            layoutRight = NSLayoutConstraint(item: tableDetail.view, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0)
            
            
            layoutLeft = NSLayoutConstraint(item: tableDetail.view, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0)
            NSLayoutConstraint.activate([layoutTop, layoutLeft, layoutBot, layoutRight])
        }
        
        
    }
    //add activity indicator
    func addActivity() {
        if background_acti == nil {
            background_acti = UIView()
            background_acti.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            background_acti.backgroundColor = UIColor.clear
            background_acti.clipsToBounds = true
            background_acti.isHidden = true
            background_acti.layer.cornerRadius = 10
            background_acti.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(background_acti)
            
            layoutTop = NSLayoutConstraint(item: background_acti, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0)
            
            layoutBot = NSLayoutConstraint(item: background_acti, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0)
            
            layoutRight = NSLayoutConstraint(item: background_acti, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0)
            
            
            layoutLeft = NSLayoutConstraint(item: background_acti, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0)
            NSLayoutConstraint.activate([layoutTop, layoutLeft, layoutBot, layoutRight])
            
        }
        if loading == nil {
            loadingView = UIView()
            loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            loadingView.backgroundColor = UIColor(hex: "#444444", alpha: 0.7)
            loadingView.clipsToBounds = true
            loadingView.isHidden = true
            loadingView.layer.cornerRadius = 10
            loadingView.translatesAutoresizingMaskIntoConstraints = false
            self.background_acti.addSubview(loadingView)
            
            layoutCenterX = NSLayoutConstraint(item: loadingView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
            layoutCenterY = NSLayoutConstraint(item: loadingView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
            
            layoutWidth = NSLayoutConstraint(item: loadingView
                , attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80)
            
            layoutHeight = NSLayoutConstraint(item: loadingView
                , attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80)
            NSLayoutConstraint.activate([layoutCenterX, layoutCenterY, layoutWidth, layoutHeight])
        }
        if loading == nil {
            loading = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            loading.hidesWhenStopped = true
            loading.activityIndicatorViewStyle =
                UIActivityIndicatorViewStyle.whiteLarge
            loading.translatesAutoresizingMaskIntoConstraints = false
            self.loadingView.addSubview(loading)
            layoutCenterX = NSLayoutConstraint(item: loading, attribute: .centerX, relatedBy: .equal, toItem: loadingView, attribute: .centerX, multiplier: 1, constant: 0)
            
            layoutCenterY = NSLayoutConstraint(item: loading, attribute: .centerY, relatedBy: .equal, toItem: loadingView, attribute: .centerY, multiplier: 1, constant: 0)
            
            layoutWidth = NSLayoutConstraint(item: loading
                , attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80)
            
            layoutHeight = NSLayoutConstraint(item: loading
                , attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80)
            NSLayoutConstraint.activate([layoutCenterX, layoutCenterY, layoutWidth, layoutHeight])
            
        }
    }
    func showActivity(isShow: Bool) {
        if isShow {
            background_acti.isHidden = false
            loadingView.isHidden = false
            loading.startAnimating()
        }else {
            background_acti.isHidden = true
            loadingView.isHidden = true
            loading.stopAnimating()
        }
    }
    
    //add floatButton
    func addButtonForActionAdd() {
        if btnAdd == nil {
            btnAdd = UIButton(type: .custom)
            btnAdd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            btnAdd.layer.cornerRadius = 0.5 * btnAdd.bounds.size.width
            btnAdd.clipsToBounds = true
            btnAdd.setImage(UIImage(named:"add"), for: .normal)
            btnAdd.backgroundColor = UIColor(hex: "#249bb3")
            btnAdd.addTarget(self, action: #selector(BaseViewController.createPost), for: .touchUpInside)
            btnAdd.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(btnAdd)
            layoutBot = NSLayoutConstraint(item: btnAdd, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -8)
            layoutRight = NSLayoutConstraint(item: btnAdd, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -8)
            
            layoutWidth = NSLayoutConstraint(item: btnAdd
                , attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40)
            
            layoutHeight = NSLayoutConstraint(item: btnAdd
                , attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40)
            NSLayoutConstraint.activate([layoutBot, layoutRight, layoutWidth, layoutHeight])
            
        }
    }
    //cusstom for dropdown
    func customDropDown(_ sender: AnyObject, dropDowns: [DropDown]) {
        let appearance = DropDown.appearance()
        appearance.cellHeight = 40
        appearance.backgroundColor = UIColor.white
        appearance.selectionBackgroundColor = UIColor(red: 0.6494, green: 0.8155, blue: 1.0, alpha: 0.2)
        appearance.cornerRadius = 8
        appearance.shadowColor = UIColor(white: 0.6, alpha: 1)
        appearance.shadowOpacity = 0.9
        appearance.shadowRadius = 25
        appearance.animationduration = 0.25
        appearance.textColor = UIColor.black
        dropDowns.forEach {
            $0.dismissMode = .automatic
            $0.direction = .bottom
            
        }
    }
    
    
    func configPageMenu(data: [DataPageMenu]) {
        
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .scrollMenuBackgroundColor(UIColor(hex: "#249bb3")),
            .viewBackgroundColor(UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)),
            .bottomMenuHairlineColor(UIColor(hex: "#249bb3")),
            .selectionIndicatorColor(UIColor.white),
            .menuMargin(20.0),
            .menuHeight(40.0),
            .selectedMenuItemLabelColor(UIColor.white),
            .unselectedMenuItemLabelColor(UIColor.white),
            .menuItemFont(UIFont(name: "OpenSans-SemiBold", size: 15.0)!),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorRoundEdges(true),
            .selectionIndicatorHeight(2.0),
            .menuItemSeparatorPercentageHeight(0.1)
        ]
        pageMenu = CAPSPageMenu(data: data, frame: CGRect(x: 0.0,y: 0.0,width: self.view.frame.width,height: self.view.frame.height), pageMenuOptions: parameters)
        self.view.addSubview(pageMenu!.view)
        pageMenu.delegate = self
    }
    
    
    func createPost() {
        //        let create = CreatePost(nibName: "CreatePost", bundle: nil)
        let create = CreateJob(nibName: "CreateJob", bundle : nil)
        self.tabBarController?.navigationController?.pushViewController(create, animated: true)
    }
    func showAlert(msg: String) {
        let alert = UIAlertController(title: "Thông báo", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Đóng", style: UIAlertActionStyle.default, handler: nil))
        showActivity(isShow: false)
        self.present(alert, animated: true, completion: nil)
    }
    func hideKebroad(){
        self.view.endEditing(true)
    }
   
    
    
    func checkParam(txt: String) -> String {
        var result = ""
        switch txt {
        case "Nam":
            result = "male"
        case "Nữ":
            result = "female"
        case "Cả ngày":
            result = "full time"
        case "Theo thời gian":
            result = "part time"
        case "Nhân viên":
            result = "Staff"
        case "Quản lý":
            result = "Manager"
        case "Giám đốc":
            result = "Director"
        case "Nhóm trưởng":
            result = "Team Leader"
        case "Nhân viên lễ tân":
            result = "Receptionist"
        case "Nhân viên bán hàng":
            result = "Salesperson"
        default:
            result = ""
            break
        }
        return result
    }
    func getCitys(state: String) -> Set<String> {
        var result = Set<String>()
        for item in self.dataState {
            if item.state == state {
                result.insert(item.city!)
            }
        }
        
        return result
        
    }
    
    func getZipcodes (city: String ) -> Set<String> {
        var result = Set<String>()
        for item in self.dataState {
            if item.city == city {
                result.insert(item.zipcode!)
            }
        }
        return result
    }
    
    
    func getUDID() -> String {
        return (UIDevice.current.identifierForVendor?.uuidString)!
    }
    func validateEmail(testStr:String) -> Bool {

        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    func validatePhone(value: String) -> Bool {
        if (value.length >= 8) && (value.length <= 20) {
            if let result = Int(value) {
                return true
            }else {
                return false
            }
        }else {
            return false
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        NSNotificationCenter.defaultCenter().removeObserver(self)
//        (UIApplication.sharedApplication().delegate as! AppDelegate).apnsDelegate = self
        NotificationCenter.default.removeObserver(self)
//        UIApplication.shared.delegate = s
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.tabBarController?.navigationItem.backBarButtonItem = backItem
        if let user = UserData.instance.user {
            self.user = user
        }
        
        
        
    }
    
    
    func loadImage(url_image: URL?, imageView: UIImageView, key: String?) {
        if KingfisherManager.shared.cache.isImageCached(forKey: key!).cached {
            KingfisherManager.shared.cache.retrieveImage(forKey: key!, options: nil) { (Image, CacheType) -> () in
                if Image != nil {
                    imageView.image = Image
                }
            }
        }else {
            imageView.kf.indicatorType = .activity
            imageView.kf.indicator?.startAnimatingView()
            DispatchQueue.main.async {
              self.downloadImage(url_image: url_image!, imageView: imageView, key: key! )
            }
          
        }
        
    }
    
    func downloadImage(url_image: URL, imageView: UIImageView, key: String?) {
        imageView.image = UIImage()
        KingfisherManager.shared.downloader.downloadImage(with: url_image, options: nil, progressBlock: nil, completionHandler: { (image, error, url, data) -> () in
            
            if image != nil {
                if let resizeImage = (image?.kf.resize(to: CGSize(width: imageView.frame.size.width + 50, height: imageView.frame.size.height + 50)))
                {
                    KingfisherManager.shared.cache.store(resizeImage, forKey: key!)
                    imageView.image = resizeImage
                    imageView.kf.indicator?.stopAnimatingView()
                    
                }
            }else {
                //                imageView.image = UIImage(named: "haha")
                imageView.kf.indicator?.stopAnimatingView()
                
            }
        })
    }
    func parseJson(txt: String) {
        let dataString: Data = txt.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let json = JSON(data: dataString)
        if let message = json["message"].string {
            self.message = message
        }
        if let profile_image = json["profile_picture"].string {
            self.profile_image = profile_image
        }
        if let post_id = json["post_id"].string{
            self.arrID.append(post_id)
        }
        if let type_message = json["type_message"].string{
            self.type_message = type_message
        }
        
    }
    func showAlertWithMess(msg: String) {
        let alert  = UIAlertController(title: "Thông báo", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đóng", style: .cancel) { (ok) in
            self.showActivity(isShow: true)
            self.navigationController?.popViewController(animated: true)
            }
        )
        
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
extension BaseViewController: CAPSPageMenuDelegate {
    func willMoveToPage(_ controller: UIViewController, index: Int) {
    }
    
    func didMoveToPage(_ controller: UIViewController, index: Int){
        
        
    }
    
}
