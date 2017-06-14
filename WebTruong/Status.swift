//
//  Status.swift
//  RaoViet
//
//  Created by Chung on 12/19/16.
//  Copyright © 2016 3i. All rights reserved.
//

import SwiftyJSON
import Foundation

//"categories": "worker",
//"subcribe": "0"

class Status  {
    
    var categories: String?
    var subcribe : String?
    
    
    init() {
        
    }
    init(from json: JSON) {
        self.parse(from: json)
    }
    func parse(from json: JSON) {
        if let categories: String = json["categories"].string {
            self.categories = categories
        }
        if let subcribe: String = json["subcribe"].string {
            self.subcribe = subcribe
        }
    }
    
    
    
    
}

