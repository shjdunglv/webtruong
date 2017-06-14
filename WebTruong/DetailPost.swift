//
//  DetailPost.swift
//  RaoViet
//
//  Created by ReasonAmu on 12/21/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import DropDown

protocol didBackToDetail {
    func didBack()
}
class DetailPost: BaseScrollView {
    
    
    @IBOutlet weak var btn_Location: UIButton!
    @IBOutlet weak var btn_ZoomOut: UIButton!
    @IBOutlet weak var btn_ZoomIn: UIButton!
    
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDateTime: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbState_City: PaddingLabel!
    @IBOutlet weak var lbPhone: UILabel!
    
    @IBOutlet weak var lbMucLuong: PaddingLabel!
    
    @IBOutlet weak var lbMoney: PaddingLabel!
    @IBOutlet weak var lbSDT: PaddingLabel!
    @IBOutlet weak var lbNoiDung: PaddingLabel!
    @IBOutlet weak var view_Call_Apply: UIView!
    
    @IBOutlet weak var viewForCollection: UIView!
    @IBOutlet weak var my_collection: UICollectionView!
    
    @IBOutlet weak var constrainTopForMap: NSLayoutConstraint!
    
    var delegate: didBackToDetail?
    
    var type: typePost?
    var isMyPost: Bool = false
    @IBOutlet weak var constrainBotForApplyView: NSLayoutConstraint!
    
    var btnMore: UIBarButtonItem!
    
    var type_Post: typePost!
    var post_Id: Int = 0 {
        didSet{
            updateViewCount(post_id: post_Id)
        }
    }
    var postDetail = PostDetail()
    var ddMore: DropDown?
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMore = UIBarButtonItem(image: UIImage(named: "more"), style: .plain, target: self, action: #selector(DetailPost.showMore))
        my_collection.delegate = self
        my_collection.dataSource = self
        my_collection.register( UINib(nibName: "CellCollectionImage", bundle: nil), forCellWithReuseIdentifier: cellImage)
        my_collection.layer.cornerRadius = 8.0
        addActivity()
        getData()
        
        btn_ZoomIn.addTarget(self, action: #selector(handleZoomIn), for: .touchUpInside)
        btn_ZoomOut.addTarget(self, action: #selector(handleZoomOut), for: .touchUpInside)
        btn_Location.addTarget(self, action: #selector(handleLocation), for: .touchUpInside)
        
        mapview.delegate = self
        //-- get Location
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.mapview.showsUserLocation = true
        
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "test"), object: self)


    }
    func customLabel() {
        lbTitle.layer.masksToBounds = true
        lbTitle.layer.cornerRadius = 8.0
        
        lbNoiDung.layer.masksToBounds = true
        lbNoiDung.setConeradiusTop()
        
        lbMucLuong.layer.masksToBounds = true
        lbMucLuong.setConeradiusTop()
        lbMoney.layer.masksToBounds = true
        lbMoney.setConeradiusBottom()
        
        lbSDT.layer.masksToBounds = true
        lbSDT.setConeradiusTop()
        
        
        lbState_City.layer.masksToBounds = true
        lbState_City.setConeradiusBottom()
        
    }
    func configDropDown(data: [String], dropDown: DropDown ,button: UIBarButtonItem) {
        dropDown.anchorView = button
        dropDown.dataSource = data
        dropDown.selectionAction = { [unowned self] (index, item) in
            switch index {
            case 0:
                self.editPost(type: self.type_Post)
            case 1:
                self.showAlertWithMess()
            case 2:
                let userApply = UserHasApply(nibName: "UserHasApply", bundle: nil)
                userApply.post_id = self.postDetail.id!
                userApply.title = "LIST APPLY"
                self.navigationController?.pushViewController(userApply, animated: true)
            default:
                break
            }
        }
    }
    func editPost(type: typePost) {
        switch type {
        case .enterprise, .worker:
            let createJob = CreateJob(nibName: "CreateJob", bundle: nil)
            createJob._type = type
            createJob.isEditPost = true
            createJob.postDetail = postDetail
            self.navigationController?.pushViewController(createJob, animated: true)
            break
        case .buy, .sell:
            let createMarket = CreateMarket(nibName: "CreateMarket", bundle: nil)
            createMarket.isEditPost = true
            createMarket._type = type
            
            createMarket.postDetail = postDetail
            self.navigationController?.pushViewController(createMarket, animated: true)
            break
        case .rent, .lease:
            let createRent = CreateRenting(nibName: "CreateRenting", bundle: nil)
            createRent.isEditPost = true
            createRent._type = type
            
            createRent.postDetail = postDetail
            self.navigationController?.pushViewController(createRent, animated: true)
            
            break
        default:
            break
        }
    }
    
    func showAlertWithMess() {
        let alert  = UIAlertController(title: "Thông báo", message: "Bạn có muốn xóa không?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .cancel) { (ok) in
            self.showActivity(isShow: true)
            ManagerData.instance.deletePost(post_id: self.post_Id, success: { (msg) in
                if msg == "ok" {
                    self.showActivity(isShow: false)
                    self.showAlertWithMess(msg: "Xoá bài thành công")
                }
            })
            }
        )
        alert.addAction(UIAlertAction(title: "NO", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }

    func updateViewCount(post_id: Int) {
        ManagerData.instance.updateViewCount(post_id: post_id, success: { (msg) in
            print(msg)
        })
    }
    
    func getData() {
        self.showActivity(isShow: true)
        if let user_Id = UserData.instance.user?.id {
            ManagerData.instance.getPostDetail(type: type_Post, id: post_Id, user_id: user_Id, success: { [unowned self] (json, msg) in
                if msg == "ok" {
                    print(json)
                    self.postDetail = PostDetail(from: (json?.array?.first)!)
                    
                    self.getDataState()
                    self.customLabel()
                    self.setDataForLabel()
                    self.showActivity(isShow: false)
                }else {
                    self.showAlert(msg: "Bài viết không tồn tại")
                }
                
                }, fail: { (msg) in
                    self.showAlert(msg: msg)
            })
        }
    }
    
    
    var dataBang = Set<String>()
    var dataCity = Set<String>()
    
    var state : String = ""
    var city : String = ""
    
    func getStateCity()-> [String]{
        var list:[String] = []
        if let check = postDetail.statecity {
            list  = check.convertString(type: "|")
            
        }
        
        return list
    }
    
    //-- GET STATES
    func getDataState() {
        ManagerData.instance.getAllState(success: { (data, msg) in
            for item in data {
                if self.getStateCity()[0]  == item.id {
                    self.state = item.state!
                    self.city = item.city!
                    break
                }
            }
            
        }, fail: { msg in
            print(msg)
        })
        
    }
    
    
    func setDataForLabel() {
        if isMyPost || (UserData.instance.user?.id == postDetail.post_author) {
           
            view_Call_Apply.isHidden = true
            constrainBotForApplyView.constant = 8
            self.navigationItem.rightBarButtonItem = btnMore
            if ddMore == nil {
                ddMore = DropDown()
            }
            self.customDropDown(self, dropDowns: [ddMore!])
            //
            self.configDropDown(data: dataMore, dropDown: self.ddMore!, button: btnMore)
            
            
        }else {
            view_Call_Apply.isHidden = false
            constrainBotForApplyView.constant = 72
            self.navigationItem.rightBarButtonItem = nil
        }
        
        
        
        lbDateTime.text = postDetail.post_date!
        if let contents = postDetail.post_content {
            lbContent.text = contents
        }
        if let phones = postDetail.phone {
            lbPhone.text = phones
        }
        if let myTitle = postDetail.post_title {
            lbTitle.text = myTitle
            
        }
       
        if let money = postDetail.price {
            lbMoney.text = "$ \(money)"
        }else if let money2  = postDetail.salary {
            lbMoney.text = "$ \(money2)"

        }else {
             lbMoney.text = "$"
        }
        if self.state != nil {
            lbState_City.text = "State-City: \(self.state)- \(self.city)"

        }else {
            lbState_City.text = ""

        }
        
        convertStringNetWork()
        
    }
    func showMore() {
        ddMore?.show()
    }
    
    func convertStringNetWork(){
        
        //-- Set Location
        if let listLocation = postDetail.gps?.convertString(type: " ") {
            if listLocation.count == 2 {
                let latitude_gps = listLocation[0].replacingString()
                let longitude_gps = listLocation[1].replacingString()
                
                locationGPS = CLLocationCoordinate2D(latitude: Double(latitude_gps)!, longitude: Double(longitude_gps)!)
                addAnnotaion(coordinate:  locationGPS , title: postDetail.post_title! , subtitle:postDetail.post_content , imageName: "map")
            }
        }
        //-- Set Image
        if let myImage = postDetail.image {
            viewForCollection.isHidden = false
            constrainTopForMap.constant = 136
            numberImage  = (myImage.convertString(type: "|"))
            if numberImage.last == "" {
                if numberImage.count > 1 {
                    numberImage.remove(at: numberImage.count - 1)
                }else{
                    viewForCollection.isHidden = true
                    constrainTopForMap.constant = 8
                }
            }
            DispatchQueue.main.async {
                self.my_collection.reloadData()
            }
            
        }else{
            viewForCollection.isHidden = true
            constrainTopForMap.constant = 8
        }
        
        
    }
    
    
    
    
    //MARK: HANDLE CALL - APPLY
    
    @IBAction func handelCall(_ sender: Any) {
        
        print("contact")
        UIApplication.shared.openURL(NSURL(string: "tel://\(postDetail.phone!)") as! URL)
        print(postDetail.phone!)
        
    }
    
    
    @IBAction func handleApply(_ sender: Any) {
        self.showActivity(isShow: true)
//        if let user = UserData.instance.user {
//            ManagerData.instance.applyPost(username: user.user_email, user_id: user.id, post_id: postDetail.id!, post_author: postDetail.post_author!, post_title: postDetail.post_title!, phone: postDetail.phone!, success: { (msg) in
//                self.showAlert(msg: "apply thành công")
//            })
//        }
    }
    
    
    
    
}


extension DetailPost {
    
    override func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        super.locationManager(manager, didUpdateLocations: locations)
        self.updateRegion(scale: 2.0)
        
    }
    
}
extension DetailPost : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //        let url = URL(string: numberImage[indexPath.item])
        //        (cell as! CellCollectionImage).imageViews.kf.setImage(with: url, options: [ .transition(.fade(0.2))] )
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as! CellCollectionImage).imageViews.kf.cancelDownloadTask()
    }
}

extension DetailPost : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellImage, for: indexPath) as! CellCollectionImage
        cell.imageViews.kf.indicatorType = .activity
        if let path: String = numberImage[indexPath.item] {
            if path != "" {
                self.loadImage(url_image: URL(string: path), imageView: cell.imageViews, key: path)
                
            }
        }
        
        //        cell.imageViews.kf.setImage(with: url, options: [ .transition(.fade(0.2))] )
        return cell
    }
    
}

