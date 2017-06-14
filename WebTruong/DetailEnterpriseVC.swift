//
//  DetailEnterpriseVC.swift
//  RaoViet
//
//  Created by ReasonAmu on 12/13/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Kingfisher


class DetailEnterpriseVC: BaseScrollView {
    
    @IBOutlet weak var btn_Location: UIButton!
    @IBOutlet weak var btn_ZoomOut: UIButton!
    @IBOutlet weak var btn_ZoomIn: UIButton!
    
    
    @IBOutlet weak var lb1: UILabel!
    @IBOutlet weak var lb2: UILabel!
    @IBOutlet weak var lb3: UILabel!
    @IBOutlet weak var lb4: UILabel!
    @IBOutlet weak var lb5: UILabel!
    @IBOutlet weak var lb6: UILabel!
    @IBOutlet weak var lb7: UILabel!
    @IBOutlet weak var lb8: UILabel!
    @IBOutlet weak var lb9: UILabel!
    
    @IBOutlet weak var lbDateTime: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    
    
    @IBOutlet weak var iconName: UIImageView!
    @IBOutlet weak var layoutBottom: NSLayoutConstraint!
    
    @IBOutlet weak var layoutTopMapkit: NSLayoutConstraint!
    
    @IBOutlet weak var view_Call_Apply: UIView!

    
    var language_Name = ["Tên công ty", "Tên ứng viên"]
    var language_CompanyScale = "Quy mô công ty"
    var language_AVG_Salary = "Mức lương trung bình"
    var language_Position = "Chức vụ"
    var language_Time = "Thời gian"
    var language_Address = "Địa chỉ"
    var language_Exp = "Kinh nghiệm"
    var language_Gender = "Giới tính"
    var language_Deadline = "Hạn nộp"
    var language_State_Cỉty = "State - City"
    
    
    
    
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
    
    
    func updateViewCount(post_id: Int) {
        ManagerData.instance.updateViewCount(post_id: post_id, success: { (msg) in
            print(msg)
        })
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addActivity()
        getData()
        
        //-- view call apply
        view_Call_Apply.isHidden = true
        
        
        btn_ZoomIn.addTarget(self, action: #selector(handleZoomIn), for: .touchUpInside)
        btn_ZoomOut.addTarget(self, action: #selector(handleZoomOut), for: .touchUpInside)
        btn_Location.addTarget(self, action: #selector(handleLocation), for: .touchUpInside)
        
        mapview.delegate = self
        //-- get Location
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.mapview.showsUserLocation = true
        
    }
    
    
    
    func getData() {
        self.showActivity(isShow: true)
        if let user_Id = UserData.instance.user?.id {
            ManagerData.instance.getPostDetail(type: type_Post, id: post_Id, user_id: user_Id, success: { [unowned self] (json, msg) in
                self.postDetail = PostDetail(from: (json?.array?.first)!)
                self.getDataState()
                DispatchQueue.main.async {
                    self.getDataState()
                    self.setDataForLabel(type: self.type_Post)
                    
                }
                }, fail: { (msg) in
                    self.showAlert(msg: msg)
            })
        }
        
    }
    
    
    
    
    func setDataForLabel(type: typePost){
        
        lbDateTime.text = postDetail.post_date!
        
        if type == .enterprise {
            UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.iconName.image = UIImage(named: "company")
                self.lbName.text = "\(self.language_Name[0]) \(self.postDetail.company_name!)"
                self.lbContent.text = "\(self.postDetail.post_content!)"
                
                self.lb1.text = "- \(self.language_CompanyScale): \(self.postDetail.company_scale!)"
                self.lb2.text = "- \(self.language_AVG_Salary) : \(self.postDetail.salary!)(\(self.postDetail.currency!))"
                self.lb3.text = "- \(self.language_Position): \(self.postDetail.position!)"
                self.lb4.text = "- \(self.language_Time): \(self.postDetail.time!)"
                self.lb5.text = "- \(self.language_Address): \(self.postDetail.address!)"
                self.lb6.text = "- \(self.language_Exp): \(self.postDetail.experience_year!)"
                self.lb7.text = "- \(self.language_Gender): \(self.postDetail.gender!)"
                self.lb8.text = "- \(self.language_Deadline): \(self.postDetail.deadline!)"
                self.lb9.text = "- \(self.language_State_Cỉty): \(self.state) - \(self.city)"
                
                
            }, completion: { finish in
                if let views = self.view_Call_Apply{
                    views.removeFromSuperview()
                }
                self.layoutBottom.constant = 1
                
            })
            
            
        }else if type == .worker {
            
            UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.iconName.image = UIImage(named: "userfill")
                self.lbName.text = "\(self.language_Name[1]): \(self.postDetail.name!)"
                self.lbContent.text = self.postDetail.post_content!
                
                self.lb1.text = "- \(self.language_Gender): \(self.postDetail.gender!)"
                self.lb2.text = "- \(self.language_AVG_Salary): \(self.postDetail.salary_min!) - \(self.postDetail.salary_max!)(\(self.postDetail.currency!))"
                self.lb3.text = "- \(self.language_Position): \(self.postDetail.position!)"
                self.lb4.text = "- \(self.language_Time): \(self.postDetail.time!)"
                self.lb5.text = "- \(self.language_Address): \(self.postDetail.address!)"
                self.lb6.text = "- \(self.language_Exp): \(self.postDetail.experience_year!)"
                self.lb7.text = "- \(self.language_State_Cỉty): \(self.state)- \(self.city)"
                self.layoutTopMapkit.constant = 12
            }, completion: { (finish) in
                if let view1 = self.lb8, let view2 = self.lb9 {
                    view1.removeFromSuperview()
                    view2.removeFromSuperview()
                }
                
                self.view_Call_Apply.isHidden = false
                self.layoutBottom.constant = 84
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
    
    
    
    func getDataState() {
        ManagerData.instance.getAllState(success: { (data, msg) in
            for item in data {
                if self.getStateCity()[0]  == item.id {
                    self.state = item.state!
                    self.city = item.city!
                    DispatchQueue.main.async {
                        self.setDataForLabel(type: self.type_Post)
                        self.convertStringNetWork()
                        self.showActivity(isShow: false)
                    }
                    break
                }
            }
            
            
        }, fail: { msg in
            print(msg)
        })
        
    }
    
    
    
    
    func convertStringNetWork(){
        
        //-- Set Location
        if let listLocation = postDetail.gps?.convertString(type: " ") {
            if listLocation.count == 2 {
                let latitude_gps = listLocation[0].replacingString()
                let longitude_gps = listLocation[1].replacingString()
                
                locationGPS = CLLocationCoordinate2D(latitude: Double(latitude_gps)!, longitude: Double(longitude_gps)!)
                if type_Post == typePost.enterprise {
                    addAnnotaion(coordinate:  locationGPS , title: postDetail.company_name!  , subtitle: postDetail.post_title!, imageName: "map")
                }else{
                    addAnnotaion(coordinate:  locationGPS , title: postDetail.name!  , subtitle: postDetail.post_title!, imageName: "map")
                    
                }
                
            }
            
        }
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        mapview.removeFromSuperview()
        mapview = nil
        super.viewDidDisappear(animated)
        
        
        
    }
    
    
    
    //MARK: HANDLE CALL - APPLY
    
    
    
    
    
    @IBAction func handleCall(_ sender: Any) {
        print("contact")
        UIApplication.shared.openURL(NSURL(string: "tel://\(postDetail.phone!)") as! URL)
        print(postDetail.phone!)
    }
    
    
    @IBAction func handleApply(_ sender: Any) {
        
//        if let user = UserData.instance.user {
//            ManagerData.instance.applyPost(username: user.user_email, user_id: user.id, post_id: postDetail.id!, post_author: postDetail.post_author!, post_title: postDetail.post_title!, phone: postDetail.phone!, success: { (msg) in
//                self.showAlert(msg: msg)
//            })
//        }
    }
}


extension DetailEnterpriseVC {

    
    
    override func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
       super.locationManager(manager, didUpdateLocations: locations)
        self.updateRegion(scale: 2.0)
    }
}
