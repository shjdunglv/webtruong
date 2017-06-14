//
//  Notification.swift
//  RaoViet
//
//  Created by ReasonAmu on 12/2/16.
//  Copyright © 2016 3i. All rights reserved.
//

import Foundation
import SwiftyJSON
//"id": "813",
//"user_id": "466",
//"message": "{\"message\":\"Cong Nguyen đang cần tìm việc\",\"post_id\":\"9926\",\"profile_picture\":\"\",\"type_message\":\"worker\"}",
//"status": "1",
//"date": "2016-12-21 09:01:57"


class Notify {
    var id: String!
    var user_id: String?
    var message: String?
    var status: String?
    var date: String?
    init() {
        
    }
    init(from json: JSON) {
        self.parse(from: json)
    }
    func parse(from json: JSON) {
        if let id: String = json["id"].string {
            self.id = id
        }
        if let user_id: String = json["user_id"].string {
            self.user_id = user_id
        }
        if let message: String = json["message"].string {
            self.message = message
        }
        if let status: String = json["status"].string {
            self.status = status
        }
        if let date: String = json["date"].string {
            self.date = date
        }
        
    }
    
}
    
