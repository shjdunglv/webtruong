//
//  AddInformations.swift
//  RaoViet
//
//  Created by ReasonAmu on 12/2/16.
//  Copyright © 2016 3i. All rights reserved.
//

import Foundation

struct AddInformations {
    
    var gender: String?
    var salary: String?
    var position : String?
    var time: String?
    var address: String?
    var experience : String?
    var map:String?
    
    
    init(gender: String,salary: String,position : String,time :String,address: String,  experience: String,map: String) {
        
        self.gender = gender
        self.salary = salary
        self.position = position
        self.time = time
        self.address = address
        self.experience = experience
        self.map = map
    }
    
  
    
}
