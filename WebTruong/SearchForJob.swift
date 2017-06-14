//
//  SearchForJob.swift
//  RaoViet
//
//  Created by Chung on 12/8/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit
import DropDown
class SearchForJob: BaseViewController {
    
    @IBOutlet weak var tfKeyWord: CustomTextFieldForSearch!
    @IBOutlet weak var btnBang: UIButton!
    @IBOutlet weak var btnCity: UIButton!
    
    @IBOutlet weak var btnSearch: CustomButton!
    
    var dataBang = Set<String>()
    var dataCity = Set<String>()
    
    var type : typePost!
   
    var ddBang = DropDown()
    var ddCity = DropDown()
    
    var keyword: String!
    var bang: String!
    var city: String!
    var data: [Post] = []
    
    lazy var dropDowns: [DropDown] = {
        return [
            self.ddBang,
            self.ddCity
        ]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configSubView()
        addActivity()
        customDropDown(self, dropDowns: dropDowns)
        getDataState()
        
        
        
    }
    func configSubView() {
        tfKeyWord.delegate = self

        btnBang.layer.borderColor = UIColor.black.cgColor
        
        btnCity.layer.borderColor = UIColor.black.cgColor
       
        btnSearch.layer.borderColor = UIColor.clear.cgColor
        
    }
    func getDataState() {
        showActivity(isShow: true)
        ManagerData.instance.getAllState(success: { (data, msg) in
            self.dataState = data

            for item in data {
                self.dataBang.insert(item.state!)
            }
            self.setUpDropDown()
            self.showActivity(isShow: false)
        }, fail: { msg in
            print(msg)
        })
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tfKeyWord.text = ""

    }
    
    @IBAction func actionButton(_ sender: UIButton) {
        data.removeAll()
        self.hideKebroad()
        switch sender {
        case btnBang:
            ddBang.show()
        case btnCity:
            ddCity.show()
        case btnSearch:
            searchPost(type: type)
        default:
            break
        }
    }
    
    func searchPost(type: typePost) {
        showActivity(isShow: true)
       
        if let bang = self.bang {
            self.bang = bang
        }else {
            self.bang = ""
        }
        if let city = self.city {
            self.city = city
        }else {
            self.city = ""
        }
        
        if let keyword = self.tfKeyWord.text {
            self.keyword = keyword
        }else {
            self.keyword = ""
        }
        
        ManagerData.instance.searchPost(type: type, state: bang, city: city, keyword: keyword, success: { (json, msg) in
            for item in (json?.array)! {
                self.data.append(Post(from: item))
            }
            self.showActivity(isShow: false)
            if self.data.count > 0 {
                let tableDetail = TableDetail(nibName: "TableDetail", bundle: nil)
                tableDetail.type = type
                tableDetail.typeNav = typeNav.nav
                tableDetail.data = self.data
                self.navigationController?.pushViewController(tableDetail, animated: true)
            }else {
                self.showAlert(msg: "data not found")
            }
        }, fail: { (msg) in
            self.showActivity(isShow: false)
            self.showAlert(msg: msg)
        })
        
    }
    
    
    
    
    
    
    func setUpDropDown() {
        if (Array(self.dataBang).count > 0) {
            
            self.configDropDown(data: Array(self.dataBang).sorted(), dropDown: self.ddBang, button: self.btnBang)
            self.configDropDown(data: Array(self.dataCity).sorted(), dropDown: self.ddCity, button: self.btnCity)
            
        }
    }
    
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
            
            case self.btnBang:
                self.bang = item
                self.btnCity.setTitle("Chọn Thành Phố", for: .normal)
                self.dataCity.removeAll()
                self.dataCity = self.getCitys(state: item)
                self.configDropDown(data: Array(self.dataCity).sorted(), dropDown: self.ddCity, button: self.btnCity)
            case self.btnCity:
                self.city = item
            default:
                break
            }
        }
    }
    
    
}
extension SearchForJob: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKebroad()
    }
    
}
