//
//  Business.swift
//  Test
//
//  Created by ReasonAmu on 12/1/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import Foundation
import SwiftyJSON

//"id": "9595",
//"post_author": "393",
//"post_title": "jfjdjd",
//"post_content": "djdjdbd",
//"post_date": "2016-12-05 16:40:19",
//"view_count": "1",
//"address": "bzbzbzbzbz",
//"type": "worker",
//"favorite": ""


//"id": "9605",
//"post_author": "393",
//"post_title": "ueueuee",
//"post_content": "heheh",
//"post_date": "2016-12-06 09:46:25",
//"statecity": "8906|66006",
//"zipcode": "66006",
//"gps": "20,990723 105,809721",
//"time": "Cả ngày",
//"salary_min": "56",
//"salary_max": "656",
//"address": "sjeje",
//"currency": "USD",
//"position": "Nhân viên",
//"experience_year": "56",
//"phone": "656262565665",
//"name": "jdjd",
//"gender": "Nam",
//"image": "",
//"favorite": "",
//"view_count": "1"

//"address" : "bzbzbsh",
//"zipcode" : "62414",
//"time" : "Cả ngày",
//"position" : "Nhân viên",
//"post_date" : "2016-12-05 16:45:39",
//"experience_year" : "4967",
//"company_name" : "svzbsjsb",
//"image" : "",
//"favorite" : "",
//"currency" : "VND",
//"salary" : "55555",
//"id" : "9596",
//"post_content" : "shdbdh",
//"gender" : "Nam",
//"company_scale" : "hshshsjshzzj",
//"phone" : "976494873",
//"post_title" : "hdjshdhd",
//"view_count" : "9",
//"deadline" : "2016\/12\/05",
//"post_author" : "393",
//"statecity" : "8920|62414",
//"gps" : "20,990756 105,809858"

class Post  {
    
    var id: String?
    var post_author : String?
    var post_title : String?
    var post_content: String?
    var post_date : String?
    var view_count : String?
    var address : String?
    var type : String?
    var favorite : String?
    
    //detail
       
    
    init() {
        
    }
    init(from json: JSON) {
        self.parse(from: json)
    }
    func parse(from json: JSON) {
        if let id: String = json["id"].string {
            self.id = id
        }
        if let post_author: String = json["user_id"].string {
            self.post_author = post_author
        }
        if let post_title: String = json["title"].string {
            self.post_title = post_title
        }
        if let post_content: String = json["content"].string {
            self.post_content = post_content
        }
        if let post_date: String = json["datetime"].string {
            self.post_date = post_date
        }
        if let view_count: String = json["viewed"].string {
            self.view_count = view_count
        }
        if let address: String = json["address"].string {
            self.address = address
        }
        if let type: String = json["type"].string {
            self.type = type
        }
        if let favorite: String = json["favorite"].string {
            self.favorite = favorite
        }   
    }

    
    
    
}
