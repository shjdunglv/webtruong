//
//  User.swift
//  RaoViet
//
//  Created by Chung on 12/5/16.
//  Copyright © 2016 3i. All rights reserved.
//

import Foundation
import SwiftyJSON


//"id": "424",
//"phone": "01699636768",
//"user_email": "chung@gmail.com",
//"display_name": "chung test"
class User {
    var id: String!
    var username: String!
    var display_name: String!
    var picture_profile: String?
    var type: Int!
    var date_time: String!
    var permit: Int!
    var status: String!
    var email: String!
    init() {
        
    }
    init(from json: JSON) {
      self.parse(from: json)
    }
    func parse(from json: JSON) {
        if let id: String = json["id"].string {
            self.id = id
        }
        if let username: String = json["username"].string {
            self.username = username
        }
        if let display_name: String = json["name"].string {
            self.display_name = display_name
        }
        if let picture_profile: String = json["avatar"].string {
            self.picture_profile = picture_profile
        }
        if let type = json["type"].int{
            self.type = type
        }
        if let status = json["status"].string
        {
            self.status = status
        }
        if let permit = json["permit"].int
        {
            self.permit = permit
        }
        if let email = json["email"].string
        {
            self.email = email
        }
        if let date_time = json["datetime"].string
        {
            self.date_time = date_time
        }
    }
    }

