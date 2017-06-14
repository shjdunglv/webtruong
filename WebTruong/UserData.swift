//
//  UserData.swift
//  RaoViet
//
//  Created by Chung on 12/6/16.
//  Copyright © 2016 3i. All rights reserved.
//

import Foundation
class UserData {
    static let instance = UserData()
    var user: User?
    
    private init() {
        
    }
}
