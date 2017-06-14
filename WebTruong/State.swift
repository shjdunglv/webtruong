//
//  State.swift
//  RaoViet
//
//  Created by Chung on 12/8/16.
//  Copyright © 2016 3i. All rights reserved.
//
import SwiftyJSON
import Foundation

//"id": "8892",
//"post_title": "Alexander City – Alabama",
//"city": " Alexander City",
//"state": "Alabama",
//"zipcode": " 35010",
//"gps": ""

class State  {
    
    var id: String?
    var post_title : String?
    var city: String?
    var state : String?
    var zipcode : String?
    var gps : String?
    
    init() {
        
    }
    init(from json: JSON) {
        self.parse(from: json)
    }
    func parse(from json: JSON) {
        if let id: String = json["id"].string {
            self.id = id
        }
        if let post_title: String = json["post_title"].string {
            self.post_title = post_title
        }
        if let city: String = json["city"].string {
            self.city = city
        }
        if let state: String = json["state"].string {
            self.state = state
        }
        if let zipcode: String = json["zipcode"].string {
            self.zipcode = zipcode
        }
        if let gps: String = json["gps"].string {
            self.gps = gps
        }
    }
    
    
    
    
}
