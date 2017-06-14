//
//  Credit.swift
//  RaoViet
//
//  Created by Chung on 1/3/17.
//  Copyright © 2017 3i. All rights reserved.
//
//"id": "1",
//"title": "Gold",
//"num_of_credit": "50",
//"num_monney": "10",
//"currency": "usd",
//"create_time": "2016-12-29 11:03:05",
//"update_time": null,
//"delete_time": null,
//"flag": "1"


import Foundation
import SwiftyJSON



class Credit {
    var id: String?
    var title: String?
    var num_of_credit: String?
    var num_monney: String?
    var currency: String?
    var create_time: String?
    var update_time: String?
    var delete_time: String?
    var flag: String?
    init() {
        
    }
    init(from json: JSON) {
        self.parse(from: json)
    }
    func parse(from json: JSON) {
        if let id: String = json["id"].string {
            self.id = id
        }
        if let title: String = json["title"].string {
            self.title = title
        }
        if let num_of_credit: String = json["num_of_credit"].string {
            self.num_of_credit = num_of_credit
        }
        if let num_monney: String = json["num_monney"].string {
            self.num_monney = num_monney
        }
        if let currency: String = json["currency"].string {
            self.currency = currency
        }
        if let create_time: String = json["create_time"].string {
            self.create_time = create_time
        }
        if let update_time: String = json["update_time"].string {
            self.update_time = update_time
        }
        if let delete_time: String = json["delete_time"].string {
            self.delete_time = delete_time
        }
        if let flag: String = json["flag"].string {
            self.flag = flag
        }

    }
    
}
