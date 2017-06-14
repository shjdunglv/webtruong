//
//  DetailPostVC.swift
//  RaoViet
//
//  Created by ReasonAmu on 12/13/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Kingfisher

class DetailPostVC: BaseScrollView {
    
    
    @IBOutlet weak var scrollViews: UIScrollView!
//    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var collectionViews: UICollectionView!
    
    @IBOutlet weak var btn_Location: UIButton!
    @IBOutlet weak var btn_ZoomOut: UIButton!
    @IBOutlet weak var btn_ZoomIn: UIButton!
    
    
    
    @IBOutlet weak var lb1: UILabel!
    @IBOutlet weak var lb2: UILabel!
    @IBOutlet weak var lb3: UILabel!
    @IBOutlet weak var lb4: UILabel!
    
    
    @IBOutlet weak var lbDateTime: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    
    @IBOutlet weak var iconName: UIImageView!
    
    @IBOutlet weak var view_Call_Apply: UIView!
    @IBOutlet weak var layoutTopViewApply: NSLayoutConstraint!
    
    @IBOutlet weak var height_CollectionView: NSLayoutConstraint!
    
    
    var language_Address = "Địa chỉ"
    var language_State_Cỉty = "State - Cỉty"
    var language_Phone = "Số điện thoại"
    var language_Price = "Giá"
    
    
//    var numberImage : [String] = []
//    let cellImage = "CellDetailImage"
//    var annotation:CustomAnnotation?
//    var fromLocation: CLLocation?
//    let locationManager = CLLocationManager()
//    var overlay : MKOverlay?
//    var locationGPS: CLLocationCoordinate2D!
    
    
    var type_Post: typePost!
    var post_Id: Int = 0 {
        didSet{
            updateViewCount(post_id: post_Id)
        }
    }
    var postDetail = PostDetail() {
        didSet{
            //   setDataForLabel()
        }
    }
    
    
    
 

    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        //--view call Apply
        
        view_Call_Apply.isHidden = true
        
        //-- imageview
        self.height_CollectionView.constant = 0
        self.layoutTopViewApply.constant = 8
        collectionViews.backgroundColor = UIColor.white
        collectionViews.isPagingEnabled = true
        collectionViews.delegate = self
        collectionViews.dataSource = self
        collectionViews.register( UINib(nibName: "CellCollectionImage", bundle: nil), forCellWithReuseIdentifier: cellImage)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                self.postDetail = PostDetail(from: (json?.array?.first)!)
                print(json)
                
                DispatchQueue.main.async {
                    self.getDataState()
                    self.showActivity(isShow: false)
        
                }
                }, fail: { (msg) in
                    self.showAlert(msg: msg)
            })
        }
    }
    
    func setDataForLabel(type: typePost) {
        lbDateTime.text = postDetail.post_date!
        lbContent.text = postDetail.post_content!
        lb1.text = "- \(language_Price): \(postDetail.price!) (\(postDetail.currency!))"
        lb2.text = "- \(language_Address): \(postDetail.address!)"
        lb3.text = "- \(language_Phone): \(postDetail.phone!)"
        self.lb4.text = "- \(self.language_State_Cỉty): \(self.state)- \(self.city)"
        convertStringNetWork()
        switch type {
        case .buy:
            view_Call_Apply.isHidden = false
        case .sell:
            view_Call_Apply.isHidden = false
        case .rent :
            view_Call_Apply.isHidden = false
        case .lease :
            view_Call_Apply.isHidden = false
        default:
            view_Call_Apply.isHidden = false
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
                    self.setDataForLabel(type:self.type_Post)
                    break
                }
            }
            
            
        }, fail: { msg in
            print(msg)
        })
        
    }
    
    
    
    //-- CHECK IMAGE
    
    
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
        if let imageString = postDetail.image {
            numberImage  = imageString.convertString(type: "|")
            print(postDetail.image as Any)
            print("Convert \(numberImage)" )
            
            
            
            if numberImage.last != "" {
                
                DispatchQueue.main.async {
                    self.height_CollectionView.constant = 200
                    self.layoutTopViewApply.constant = 210
                    self.collectionViews.reloadData()
                }
                
                
            }else {
                
                UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.layoutTopViewApply.constant = 8
                }, completion: { (finish) in
                    if self.collectionViews != nil {
                        self.collectionViews.removeFromSuperview()
                    }
                    
                })
                
            }
        }
        
    }
    
    //MARK: HANDLE CALL - APPLY
    
    @IBAction func handelCall(_ sender: Any) {
        
        print("contact")
        UIApplication.shared.openURL(NSURL(string: "tel://\(postDetail.phone!)") as! URL)
        print(postDetail.phone!)
        
    }
    
    
    @IBAction func handleApply(_ sender: Any) {
        
        if let user = UserData.instance.user {
            ManagerData.instance.applyPost(username: user.email, user_id: user.id, post_id: postDetail.id!, post_author: postDetail.post_author!, post_title: postDetail.post_title!, phone: postDetail.phone!, success: { (msg) in
                self.showAlert(msg: msg)
            })
        }
    }
    
    
}


extension DetailPostVC {
    

    
    
    override func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
        super.locationManager(manager, didUpdateLocations: locations)
            self.updateRegion(scale: 2.0)
        
    }
    
}





extension DetailPostVC : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if numberImage.last == "" {
            
            return numberImage.count - 1
        }
        
        return numberImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height:  collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let url = URL(string: numberImage[indexPath.item])
        (cell as! CellCollectionImage).imageViews.kf.setImage(with: url, options: [ .transition(.fade(0.2))] )
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as! CellCollectionImage).imageViews.kf.cancelDownloadTask()
    }
    
    
    
}

extension DetailPostVC : UICollectionViewDataSource {
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellImage, for: indexPath) as! CellCollectionImage
        cell.imageViews.kf.indicatorType = .activity
        return cell
    }
    
}

