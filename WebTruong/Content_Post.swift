//
//  File.swift
//  WebTruong
//
//  Created by HITECH on 1/20/17.
//  Copyright © 2017 shjdunglv. All rights reserved.
//

import Foundation
import SwiftyJSON
class content_post
{
    var id: Int?
    var title: String?
    var content: String?
    var type: Int?
    var description: String?
    var user_id: Int?
    var datetime: String?
    var cat: Int?
    var image: String?
    var censor: Int?
    var thumb: String?
    var lastmodifi: String?
    var viewed: Int?
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
    if let title = json["title"].string
    {
    self.title = title
    }
    if let content = json["content"].string
    {
        self.content = content
    }
    if let type = Int(json["type"].string!)
    {
        self.type = type
    }
    if let description = json["description"].string
    {
        self.description = description
    }
    if let user_id = Int(json["user_id"].string!)
    {
        self.user_id = user_id
        }
    if let datetime = json["datetime"].string
    {
            self.datetime = datetime
        }
    if let cat = Int(json["cat"].string!)
    {
            self.cat = cat
        }
    if let image = json["image"].string
    {
        self.image = image
        }
    if let censor = Int(json["censor"].string!)
    {
            self.censor = censor
        }
    if let thumb = json["thumb"].string
    {
            self.thumb = thumb
        }
    if let lastmodifi = json["lastmodifi"].string
    {
            self.lastmodifi = lastmodifi
        }
    if let viewed = json["viewed"].string
    {
            let viewed = Int(json["viewed"].string!)
            self.viewed = viewed!
        }
        else
    {
        self.viewed = 0
        }
    }
}
