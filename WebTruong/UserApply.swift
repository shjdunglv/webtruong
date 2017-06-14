//
//  UserApply.swift
//  RaoViet
//
//  Created by Chung on 12/28/16.
//  Copyright © 2016 3i. All rights reserved.
//

import Foundation
import SwiftyJSON



class UserApply {
    var username: String?
    var email: String?
    var phone: String?
    var date: String?
    
    init() {
        
    }
    init(from json: JSON) {
        self.parse(from: json)
    }
    func parse(from json: JSON) {
        if let username: String = json["username"].string {
            self.username = username
        }
        if let email: String = json["email"].string {
            self.email = email
        }
        if let phone: String = json["phone"].string {
            self.phone = phone
        }
        if let date: String = json["date"].string {
            self.date = date
        }
        
    }
    
}

