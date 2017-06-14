//
//  SearchForMarket.swift
//  RaoViet
//
//  Created by Chung on 12/8/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit
import DropDown
class SearchForMarket: BaseViewController {
    
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnCity: UIButton!
    @IBOutlet weak var btnBang: UIButton!
    
    @IBOutlet weak var tfKeywork: CustomTextField!
    
    var dataBang = Set<String>()
    var dataCity = Set<String>()
    
    var ddBang = DropDown()
    var ddCity = DropDown()
    
    
    var bang: String!
    var city: String!
    var keyWord: String!

    var data: [Post] = []
    
    var type: typePost!
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
        tfKeywork.delegate = self

        
        btnBang.layer.cornerRadius = 8.0
        btnBang.layer.borderWidth = 1
        btnBang.layer.borderColor = UIColor.black.cgColor
        
        btnCity.layer.cornerRadius = 8.0
        btnCity.layer.borderWidth = 1
        btnCity.layer.borderColor = UIColor.black.cgColor
        
        btnSearch.layer.cornerRadius = 8.0
        btnSearch.layer.borderWidth = 1
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
        if let keyWord = self.tfKeywork.text {
            self.keyWord = keyWord
        }else {
            self.keyWord = ""
        }
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
        
        ManagerData.instance.searchPost(type: type, state: bang, city: city, keyword: keyWord, success: { (json, msg) in
            for item in (json?.array)! {
                self.data.append(Post(from: item))
            }
            self.showActivity(isShow: false)
            if self.data.count > 0 {
                let tableDetail = TableDetail(nibName: "TableDetail", bundle: nil)
                tableDetail.type = type
                print(type)
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
        //setup dropdown search
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
            button.setTitle(item, for: .normal)
            button.setTitleColor(UIColor.black, for: .selected)
            switch button {
            case self.btnBang:
                self.btnCity.setTitle("Chọn Thành Phố", for: .normal)
                self.bang = item
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
extension SearchForMarket: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKebroad()
    }
    
}
