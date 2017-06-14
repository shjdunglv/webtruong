//
//  PostDetail.swift
//  RaoViet
//
//  Created by Chung on 12/6/16.
//  Copyright © 2016 3i. All rights reserved.
//

import Foundation
import  SwiftyJSON



//"id": "9523",
//"post_author": "396",
//"post_title": "cần thuê cửa hàng nail3",
//"post_content": "rộng rãi, an ninh tốt",
//"post_date": "2016-12-02 14:21:22",
//"name": "hhhhhh",
//"phone": "0972684107",
//"statecity": "8982|67430",
//"zipcode": "67430",
//"price": "5000000",
//"period": "Tháng",
//"address": "hà nội",
//"currency": "USD",
//"gps": "20,990738 105,810042",
//"favorite": "",
//"view_count": "2",
//"image": ""
class PostDetail: Post{
    //work
    var statecity: String?
    var zipcode: String?
    var gps: String?
    var time: String?
    var salary_min: String?
    var salary_max: String?
    var currency: String?
    var position: String?
    var experience_year: String?
    var phone: String?
    var name: String?
    var gender: String?
    var image: String?
    
    //enterprise
    var company_name: String?
    var salary: String?
    var company_scale: String?
    var deadline: String?
    
    //sell
    var price: String?
    //rent and lease
    var period: String?
    override init() {
        super.init()
    }
    override init(from json: JSON) {
       
        super.init(from: json)
        self.parse(from: json)
    }
    
    override func parse(from json: JSON) {
        super.parse(from: json)
        
        if let statecity: String = json["statecity"].string {
            self.statecity = statecity
        }
        
        if let zipcode: String = json["zipcode"].string {
            self.zipcode = zipcode
        }
        
        if let gps: String = json["gps"].string {
            self.gps = gps
        }
        
        if let time: String = json["time"].string {
            self.time = time
        }
        
        if let salary_min: String = json["salary_min"].string {
            self.salary_min = salary_min
        }
        
        if let salary_max: String = json["salary_max"].string {
            self.salary_max = salary_max
        }
        
        if let currency: String = json["currency"].string {
            self.currency = currency
        }
        
        if let position: String = json["position"].string {
            self.position = position
        }
        
        if let experience_year: String = json["experience_year"].string {
            self.experience_year = experience_year
        }
        
        if let phone: String = json["phone"].string {
            self.phone = phone
        }
        
        if let name: String = json["name"].string {
            self.name = name
        }
        
        if let gender: String = json["gender"].string {
            self.gender = gender
        }
        
        if let image: String = json["image"].string {
            self.image = image
        }
//        var company_name: String?
//        var salary: String?
//        var company_scale: String?
//        var deadline: String?
//        
//        //sell
//        var price: String?
//        //rent and lease
//        var period: String?
        if let company_name: String = json["company_name"].string {
            self.company_name = company_name
        }
        if let salary: String = json["salary"].string {
            self.salary = salary
        }
        if let company_scale: String = json["company_scale"].string {
            self.company_scale = company_scale
        }
        if let deadline: String = json["deadline"].string {
            self.deadline = deadline
        }
        if let price: String = json["price"].string {
            self.price = price
        }
        if let period: String = json["period"].string {
            self.period = period
        }

    }
    
}
