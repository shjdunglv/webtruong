
//  MenuViewController.swift
//  Phim24h
//
//  Created by Chung on 9/20/16.
//  Copyright © 2016 techmaster. All rights reserved.
//

import UIKit
import RATreeView
import Kingfisher
enum LeftMenu: Int {
    case newJob = 0
    case myPost
    case comment = 8
    case favorite
    case listRegister
    case payment
    case setup = 5
    case logout
    case job
}
enum TypeMyPost : String{
    case job
    case market
    case rent
    
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class MenuViewController: BaseViewController , LeftMenuProtocol{

    @IBOutlet weak var imAvatar: UIImageView!
    @IBOutlet weak var tfName: UILabel!
    @IBOutlet weak var tfEmail: UILabel!
    
    @IBOutlet weak var ViewForTable: UIView!
    var myTable: RATreeView!
    
    var newPostVC: UIViewController!
    var myPostVC: UIViewController!
    var commentVC: UIViewController!
    var favoriteVC: UIViewController!
    var listRegisterVC: UIViewController!
    var paypalVC: UIViewController!
    var setupVC: UIViewController!
    var logoutVC: UIViewController!
    
    var myJobVC: UIViewController!
    var myMarketVC: UIViewController!
    var myRentVC: UIViewController!
    
    var menus: [DataObject] = []
    
    var countJob = 0
    var countMarket = 0
    var countRent = 0
    var totalCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        addActivity()
        self.automaticallyAdjustsScrollViewInsets = false
        menus = DataObject.defaultTreeRootChildren()
        //        addSubView()
        
        
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        addSubView()
    }
    func addSubView() {
        if myTable == nil {
            myTable = RATreeView(frame: view.bounds)
            myTable.delegate = self
            myTable.dataSource = self
            myTable.allowsSelectionDuringEditing = false
            myTable.register(UINib(nibName: "CellForMenu", bundle: nil),forCellReuseIdentifier:"Cell")
            myTable.translatesAutoresizingMaskIntoConstraints = false
            myTable.backgroundColor = .clear
            ViewForTable.addSubview(myTable)
            
            layoutTop = NSLayoutConstraint(item: myTable, attribute: .top, relatedBy: .equal, toItem: self.ViewForTable, attribute: .top, multiplier: 1.0, constant: 0)
            
            layoutBot = NSLayoutConstraint(item: myTable, attribute: .bottom, relatedBy: .equal, toItem: self.ViewForTable, attribute: .bottom, multiplier: 1.0, constant: 0)
            
            layoutRight = NSLayoutConstraint(item: myTable, attribute: .trailing, relatedBy: .equal, toItem: self.ViewForTable, attribute: .trailing, multiplier: 1.0, constant: 0)
            layoutLeft = NSLayoutConstraint(item: myTable, attribute: .leading, relatedBy: .equal, toItem: self.ViewForTable, attribute: .leading, multiplier: 1.0, constant: 0)
            NSLayoutConstraint.activate([layoutTop, layoutLeft, layoutBot, layoutRight])
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        self.automaticallyAdjustsScrollViewInsets = false
        //        self.view.backgroundColor = UIColor.clear
        //        self.myTable.backgroundColor = UIColor.clear
        countJob = 0
        countMarket = 0
        countRent = 0
        totalCount = 0
        addItemsForMenu()
        if let user = UserData.instance.user {
            self.user = user
            tfName.text = user.display_name
            tfEmail.text = user.email
            if let imgAvt = user.picture_profile
            {
                   let path = ManagerData.instance.baseUrl + user.picture_profile!
          
                    loadImage(url_image: URL(string: path), imageView: imAvatar, key: path)
                
            }
            else {
                imAvatar.image = UIImage(named: "image_intro")
            }
        }
        
        getCountMyPost()
        
        
    }
    func addItemsForMenu(){
        
        let newPost = BaseTabbar(nibName: "BaseTabbar", bundle: nil)
        newPost.title = "Bài đăng mới nhất"
        self.newPostVC = BaseNavigation(rootViewController: newPost)
        
        let setup = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
        setup.title = "Setting"
        self.setupVC = BaseNavigation(rootViewController: setup)
        
        
        let comment = CommentVC(nibName: "CommentVC", bundle: nil)
        comment.title = "Danh sách bình luận"
        self.commentVC = BaseNavigation(rootViewController: comment)
        
        let favorite = FavoriteViewController(nibName: "FavoriteViewController", bundle: nil)
        favorite.title = "Yêu thích"
        self.favoriteVC = favorite
        
        let myPost = MyPost(nibName: "MyPost", bundle: nil)
        myPost.title = "Bài viết của tôi"
        self.myPostVC = myPost
        
        let listRegister = TableDetail(nibName: "TableDetail", bundle: nil)
        listRegister.title = "Danh sách đăng ký"
        listRegister.typeNav = typeNav.nav
        listRegister.type = typePost.apply
        self.listRegisterVC = listRegister
        
        
        let listFavorite = TableDetail(nibName: "TableDetail", bundle: nil)
        listFavorite.title = "YÊU THÍCH"
        listFavorite.typeNav = typeNav.nav
        listFavorite.type = typePost.favorite
        self.favoriteVC = listFavorite
        
        //        let payment = PaymentViewController(nibName: "PaymentViewController", bundle: nil)
        //        self.paymentVC = payment
        
        let myJob = JobViewController(nibName: "JobViewController", bundle: nil)
        myJob.isMyPost = true
        myJob.title = "MY JOBS"
        self.myJobVC = myJob
        
        let myMarket = BusinessViewController(nibName: "BusinessViewController", bundle: nil)
        myMarket.isMyPost = true
        
        myMarket.title = "MY MARKET"
        self.myMarketVC = myMarket
        
        let myRent = RentingViewController(nibName: "RentingViewController", bundle: nil)
        myRent.isMyPost = true
        myRent.title = "MY RENT"
        self.myRentVC = myRent
        
        let paypal = PayPalViewController(nibName: "PayPalViewController", bundle: nil)
        paypal.title = "BUY CREDIT"
        self.paypalVC = paypal
        
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .newJob:
            self.slideMenuController()?.changeMainViewController(self.newPostVC, close: true)
            break
        case .myPost:
            break
        case.comment:
             self.slideMenuController()?.changeMainViewController(self.commentVC, close: true)
            break
        case .favorite:
            self.slideMenuController()?.changeMainViewController(self.favoriteVC, close: true)
        case .listRegister:
            self.slideMenuController()?.changeMainViewController(self.listRegisterVC, close: true)
        case .setup:
            self.slideMenuController()?.changeMainViewController(self.setupVC, close: true)
        case .payment:
            self.slideMenuController()?.changeMainViewController(self.paypalVC, close: true)
        case .logout:
            deleteTokenId(user_id: user.id, device: self.getUDID())
        case .job:
            self.slideMenuController()?.changeMainViewController(self.myJobVC, close: true)
            break
        }
    }
    
    func deleteTokenId(user_id: String, device: String) {
        self.showActivity(isShow: true)
        ManagerData.instance.deleteTokenId(user_id: user_id, device: device, success: {[unowned self] (msg) in
            if msg == "ok" {
                self.showActivity(isShow: false)
                let userDefault = UserDefaults.standard
                userDefault.set(nil, forKey: LoginViewController.KEY_PHONE_EMAIL)
                userDefault.set(nil, forKey: LoginViewController.KEY_PASSWORD)
                UserData.instance.user = nil
                let loginVc = LoginViewController(nibName: "LoginViewController", bundle: nil)
                self.present(loginVc, animated: true, completion: nil)
            }
            else{
                self.showAlert(msg: msg)
                
            }
        })
    }
    
    func getCountMyPost() {
//        ManagerData.instance.getCountMyPost(type: "7", user_id: user.id, success: { (msg, count) in
//            self.countJob = Int(count)!
//            self.totalCount = self.totalCount + self.countJob
//            DispatchQueue.main.async {
//                self.myTable.reloadData()
//                
//            }
//        })
//        ManagerData.instance.getCountMyPost(type: "8", user_id: self.user.id, success: { (msg, count) in
//            self.countMarket = Int(count)!
//            self.totalCount = self.totalCount + self.countMarket
//            DispatchQueue.main.async {
//                self.myTable.reloadData()
//                
//            }
//        })
//        ManagerData.instance.getCountMyPost(type: "9", user_id: self.user.id, success: { (msg, count) in
//            self.countRent = Int(count)!
//            self.totalCount = self.totalCount + self.countRent
//            DispatchQueue.main.async {
//                self.myTable.reloadData()
//                
//            }
//        })
        
    }
    
}
extension MenuViewController: PayPalPaymentDelegate {
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("dismiss")
        paymentViewController.dismiss(animated: true, completion: nil)
        
    }
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            
        })
    }
}

extension MenuViewController: RATreeViewDelegate {
    func treeView(_ treeView: RATreeView, heightForRowForItem item: Any) -> CGFloat {
        return 50
    }
    func treeView(_ treeView: RATreeView, commit editingStyle: UITableViewCellEditingStyle, forRowForItem item: Any) {
        guard editingStyle == .delete else { return; }
    }
    
    
}
extension MenuViewController: RATreeViewDataSource {
    func treeView(_ treeView: RATreeView, child index: Int, ofItem item: Any?) -> Any {
        if let item = item as? DataObject {
            return item.children![index]
        } else {
            return menus[index] as AnyObject
        }
    }
    func treeView(_ treeView: RATreeView, numberOfChildrenOfItem item: Any?) -> Int {
        if let item = item as? DataObject {
            if let child = item.children {
                return child.count
            }else {
                return 0
            }
        } else {
            return self.menus.count
        }
    }
    
    func treeView(_ treeView: RATreeView, cellForItem item: Any?) -> UITableViewCell {
        let cell = treeView.dequeueReusableCell(withIdentifier: "Cell") as! CellForMenu
        let item = item as! DataObject
        
        cell.selectionStyle = .none
        let level = myTable.levelForCell(forItem: item)
        cell.setData(title: item.name, icon: item.icon!, level: level)
        if item.index == 1 {
            let accessoryView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            accessoryView.image = UIImage(named: "down")
            cell.accessoryView = accessoryView
            //             cell.accessoryType = .disclosureIndicator
        }
        if item.index == 7 {
            cell.lbCount.text = "(\(countJob))"
        }else if item.index == 8 {
            cell.lbCount.text = "(\(countMarket))"
        }else if item.index == 9 {
            cell.lbCount.text = "(\(countRent))"
        }else if item.index == 1 {
            cell.lbCount.text = "(\(totalCount))"
            
        }else {
            cell.lbCount.text = ""
        }
        
        return cell
    }
    
    func treeView(_ treeView: RATreeView, didSelectRowForItem item: Any) {
        let item  = item as! DataObject
        
        if let menu = LeftMenu(rawValue: item.index){
            self.changeViewController(menu)
        }
    }
    func treeView(_ treeView: RATreeView, editingStyleForRowForItem item: Any) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
}



class DataObject {
    let name: String
    let icon: String?
    let index: Int
    var children : [DataObject]?
    
    init(name: String, icon: String, index: Int, children: [DataObject]) {
        self.children = children
        self.name = name
        self.icon = icon
        self.index = index
    }
    init(name: String, icon: String, index: Int) {
        self.icon = icon
        self.name = name
        self.index = index
    }
    
}
extension DataObject {
    
    static func defaultTreeRootChildren() -> [DataObject] {
        let home = DataObject(name: "Home", icon: "home", index: 0)
        let favorite = DataObject(name: "Favorite", icon: "favorite", index: 2)
        let apply = DataObject(name: "Show Apply", icon: "apply", index: 3)
        let payment = DataObject(name: "Buy Credit", icon: "payment", index: 4)
        let setup = DataObject(name: "Settings", icon: "setup", index: 5)
        let logout = DataObject(name: "Logout", icon: "logout", index: 6)
        
        
       // let myPost1 = DataObject(name: "Quản lý bình luận", icon: "job_b", index: 7)
        let myPost2 = DataObject(name: "Bình luận chưa duyệt", icon: "market_b", index: 8)
        let myPost3 = DataObject(name: "Bình luận vi phạm", icon: "rent_b", index: 9)
        let myPosts = DataObject(name: "Quản lý bình luận",icon: "mypost",index: 1, children: [myPost2, myPost3])
        
        return [home,myPosts,setup,logout]
    }
    
}

