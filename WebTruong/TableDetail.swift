//
//  TableDetail.swift
//  RaoViet
//
//  Created by Chung on 12/3/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit
protocol DetailPostDelegate
{
    func didSelectItem(view: BaseViewController)
}
enum typePost: String {
    case enterprise
    case worker
    case sell
    case buy
    case rent
    case lease
    case apply
    case favorite
}
enum typeNav: String {
    case nav
    case tab
}
class TableDetail: BaseViewController { 
    var parentNavigation: UINavigationController?
    let cellID = "CellID"
    var type: typePost!
    var typeNav: typeNav!
    var page = 1
    var data: [Post] = []
    var isMyPost: Bool = false
    var delegate: DetailPostDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
        my_Table.delegate = self
        my_Table.dataSource = self
        my_Table.register(  UINib(nibName: "CellTableview", bundle: nil), forCellReuseIdentifier: cellID)
        addActivity()
        addDataForTable(page: page, type: type)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(doSomethingAfterNotified),
                                               name: NSNotification.Name(rawValue: "test"),
                                               object: nil) }
    
    func doSomethingAfterNotified() {
        print("I've been notified")
    }
   
    func addDataForTable(page: Int,type: typePost) {
        showActivity(isShow: true)
        switch type {
        case .enterprise:
            getData(type: "enterprise", page: String(page))
            break
        case .worker:
            getData(type: "worker", page: String(page))
            break
        case .sell:
            getData(type: "sell", page: String(page))
            break
        case .buy:
            getData(type: "buy", page: String(page))
            break
        case .rent:
            getData(type: "rent", page: String(page))
            break
        case .lease:
            getData(type: "lease", page: String(page))
            break
        case .apply:
            if let user_id = UserData.instance.user?.id {
                getPostHasApply(user_id: user_id, page: String(page))
            }
        case .favorite:
            if let user_id = UserData.instance.user?.id {
                getPostFavorite(user_id: user_id)
            }
        default:
            break
        }
    }
    
    func getData(type: String, page: String) {
        if data.count > 0 {
            self.showActivity(isShow: false)
            DispatchQueue.main.async {
                self.my_Table.reloadData()
            }
        }else {
            if isMyPost == false {
                ManagerData.instance.getAllPost(type: type, page: page, success: {[unowned self] json, msg in
                    if (json?.array?.count)! > 0 {
                        for item in (json?.array)! {
                            self.data.append(Post(from: item))
                        }
                        self.showActivity(isShow: false)
                        DispatchQueue.main.async {
                            self.my_Table.reloadData()
                        }
                    }else{
                        self.showAlert(msg: msg)
                    }
                    
                    }, fail: { msg in
//                        self.showAlert(msg: msg)
                        self.showActivity(isShow: false)

                })
                
            } else {
                if let id = UserData.instance.user?.id {
                    ManagerData.instance.getListMyPost(id: id, type: type, page: page, success: { (json, msg) in
                        if (json?.array?.count)! > 0 {
                            for item in (json?.array)! {
                                self.data.append(Post(from: item))
                            }
                            self.showActivity(isShow: false)
                            DispatchQueue.main.async {
                                self.my_Table.reloadData()
                            }
                            
                        }else{
//                            self.showAlert(msg: msg)
                            self.showActivity(isShow: false)

                        }
                        

                    }, fail: { msg in
//                        self.showAlert(msg: msg)
                        self.showActivity(isShow: false)

                    })
                }
                
            }
        }
    }
    
    func getPostHasApply(user_id: String, page: String) {
        ManagerData.instance.getPostHasApply(user_id: user_id, page: page, success: {[unowned self] json, msg in
            if (json?.array?.count)! > 0 {
                for item in (json?.array)! {
                    self.data.append(Post(from: item))
                }
                self.showActivity(isShow: false)
                DispatchQueue.main.async {
                    self.my_Table.reloadData()
                }
            }else {
                self.showActivity(isShow: false)
//                self.showAlert(msg: msg)
                
            }
            }, fail: { msg in
//                self.showAlert(msg: msg)
                self.showActivity(isShow: false)

        })
    }
    func getPostFavorite(user_id: String) {
        ManagerData.instance.getPostFavorite(id: user_id, success: {[unowned self] json, msg in
            if (json?.array?.count)! > 0 {
                for item in (json?.array)! {
                    self.data.append(Post(from: item))
                }
                self.showActivity(isShow: false)
                DispatchQueue.main.async {
                    self.my_Table.reloadData()
                }
            }
            }, fail: { msg in
                self.showActivity(isShow: false)

//                self.showAlert(msg: msg)
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLayoutSubviews() {
        if (typeNav == .tab)  {
            if (type == .enterprise) || (type == .worker) || (type == .buy) || (type == .sell) || (type == .rent) || (type == .lease) {
                addButtonForActionAdd()
            }
        }
        
    }
    override func createPost() {
        switch type.rawValue {
        case "enterprise", "worker":
            let create = CreateJob(nibName: "CreateJob", bundle : nil)
            create._type = type
            self.parentNavigation?.pushViewController(create, animated: true)
        case "sell", "buy":
            let create = CreateMarket(nibName: "CreateMarket", bundle : nil)
            create._type = type
            self.parentNavigation?.pushViewController(create, animated: true)
        case "rent", "lease":
            let create = CreateRenting(nibName: "CreateRenting", bundle : nil)
            create._type = type
            self.parentNavigation?.pushViewController(create, animated: true)
        default:
            let create = CreateJob(nibName: "CreateJob", bundle : nil)
            create._type = type
            self.parentNavigation?.pushViewController(create, animated: true)
        }
    }
    
    
    func updateFavorite(_ sender: CheckBox!) {
            sender.isChecked = !sender.isChecked
        
            showActivity(isShow: true)
            if let user_id = UserData.instance.user?.id {
                ManagerData.instance.updateFavorite(post_id: String(sender.tag), user_id: user_id, success: { (msg) in
                    if self.type == typePost.favorite {
                        self.data.removeAll()
                        self.getPostFavorite(user_id: user_id)
                    }
                    self.showActivity(isShow: false)
                })
        }
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.isMovingToParentViewController || self.isBeingDismissed {
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillLayoutSubviews() {
    }

    
}


extension TableDetail : UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if data.count >= 15 {
            return 15
        }else{
            return data.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailVc = DetailEnterpriseVC(nibName: "DetailEnterpriseVC", bundle: nil)
//        let detailVc2 = DetailPostVC(nibName: "DetailPostVC", bundle: nil)
        let detailVc = DetailPost(nibName: "DetailPost", bundle: nil)
        let detailVc2 = DetailPost(nibName: "DetailPost", bundle: nil)
        if isMyPost == false {
            if typeNav == .tab {
                if (type == .enterprise || type == .worker) {
                    if let id = Int(data[indexPath.row].id!){
                        detailVc.type_Post = type
                        detailVc.post_Id = id
                        detailVc.title = "Chi tiết"
                    }
                    self.parentNavigation?.pushViewController(detailVc, animated: true)
                } else {
                    // let detailVc = DetailPostVC(nibName: "DetailPostVC", bundle: nil)
                    if let id = Int(data[indexPath.row].id!){
                        detailVc2.type_Post = type
                        detailVc2.post_Id = id
                        detailVc2.title = "Chi tiết"
                    }
                    self.parentNavigation?.pushViewController(detailVc2, animated: true)
                }
            }else if typeNav == .nav {
                
                if (type == .enterprise) || (type == .worker) {
                    let item: Post = data[indexPath.row]
                    print(item)
                    detailVc.type_Post = type
                    detailVc.post_Id = Int(item.id!)!
                    detailVc.title = "Chi tiết"
                    self.navigationController!.pushViewController(detailVc, animated: true)
                    
                    
                } else if (type == .buy) || (type == .sell) || (type == .rent) || (type == .lease){
                    
                    let item: Post = data[indexPath.row]
                    detailVc2.type_Post = type
                    detailVc2.post_Id = Int(item.id!)!
                    detailVc2.title = "Chi tiết"
                    
                    //                self.parentNavigation?.pushViewController(detailVc2, animated: true)asd
                    self.navigationController?.pushViewController(detailVc2, animated: true)
                    
                } else if (type == .apply) || (type == .favorite)  {
                    if let item: Post = data[indexPath.row] {
                        detailVc.post_Id = Int(item.id!)!
                        detailVc.title = "Chi tiết"
                        detailVc.type = type
                        switch item.type! {
                        case "worker":
                            detailVc.type_Post = typePost.worker
                            break
                        case "enterprise":
                            detailVc.type_Post = typePost.enterprise
                            break
                        case "buy":
                            detailVc.type_Post = typePost.buy
                            break
                        case "sell":
                            detailVc.type_Post = typePost.sell
                            break
                        case "rent":
                            detailVc.type_Post = typePost.rent
                            break
                        case "lease":
                            detailVc.type_Post = typePost.lease
                            break
                        default:
                            break
                        }
                        self.navigationController?.pushViewController(detailVc, animated: true)
                        
                    }
                    
                }
                //            self.navigationController?.pushViewController(detailVc, animated: true)
            }
            
        }else {
            if let item: Post = data[indexPath.row] {
//                if (type == .enterprise) || (type == .worker) {
//                    detailVc.type_Post = type
//                    detailVc.post_Id = Int(item.id!)!
//                    detailVc.title = "Chi tiết"
//                    self.delegate?.didSelectItem(view: detailVc)
//                } else if (type == .buy) || (type == .sell) || (type == .rent) || (type == .lease){
//                    detailVc2.type_Post = type
//                    detailVc2.post_Id = Int(item.id!)!
//                    detailVc2.title = "Chi tiết"
//                    self.delegate?.didSelectItem(view: detailVc)
//                }
                detailVc.type_Post = type
                detailVc.post_Id = Int(item.id!)!
                detailVc.title = "Chi tiết"
                detailVc.isMyPost = true
                self.delegate?.didSelectItem(view: detailVc)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}


extension TableDetail : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CellTableview
        cell.selectionStyle = .none
        if let item: Post = data[indexPath.row] {
            cell.post = item
            
            let accessoryView = CheckBox(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            accessoryView.checkedImage = UIImage(named: "star_selected")
            accessoryView.uncheckedImage = UIImage(named: "star")
            if let user_id = UserData.instance.user?.id {
                if (type == typePost.favorite) {
                    accessoryView.isChecked = true
                }else if let favorite = item.favorite {
                    if favorite.contains(find: user_id) {
                        accessoryView.isChecked = true
                    }else {
                        accessoryView.isChecked = false
                    }
                } else {
                    accessoryView.isChecked = false
                }
            }
            accessoryView.tag = Int(item.id!)!
            accessoryView.addTarget(self, action: #selector(TableDetail.updateFavorite(_:)), for: .touchUpInside)
            cell.accessoryView = accessoryView
        }
        
        return cell
    }
    
}

