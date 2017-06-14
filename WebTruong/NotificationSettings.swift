//
//  NotificationSettings.swift
//  RaoViet
//
//  Created by ReasonAmu on 12/2/16.
//  Copyright © 2016 3i. All rights reserved.
//

import Foundation

struct NotificationSettings {
    var titleName: String?
    var switchCheck : Bool?
    
    init(titleName : String , switchCheck : Bool) {
        self.titleName = titleName
        self.switchCheck = switchCheck
    }
}
