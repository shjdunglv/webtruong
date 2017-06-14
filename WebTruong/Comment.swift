//
//  Comment.swift
//  WebTruong
//
//  Created by Le Dung on 5/28/17.
//  Copyright © 2017 shjdunglv. All rights reserved.
//

import Foundation
import SwiftyJSON
class Comment{
    var id: Int?
    var userId: Int?
    var ref: Int?
    var content: String?
    var status: Int?
    var datetime: String?

    init()
    {
        
    }
    init(from json: JSON)
    {
        parse(json: json)
        
    }
    func parse(json: JSON)
    {
        if let id = Int(json["id"].string!)
        {
            self.id = id
        }
        if let ref = Int(json["ref"].string!)
        {
            self.ref = ref
        }
        if let content = json["content"].string
        {
            self.content = content
        }
        if let user_id = Int(json["user_id"].string!)
        {
            self.userId = user_id
        }
        if let datetime = json["datetime"].string
        {
            self.datetime = datetime
        }
//        if !json["status"].isEmpty
//        {
//            self.status = Int(json["status"].string!)
//        }
        if let status = json["status"].string
        {
            self.status = Int(status)
        }
        else{
            self.status = 0
        }
    }
}
