//
//  DataPageMenu.swift
//  RaoViet
//
//  Created by Chung on 12/15/16.
//  Copyright © 2016 3i. All rights reserved.
//

import Foundation
import UIKit
class DataPageMenu {
    var viewControllers: UIViewController?
    var icons: String?
    
    init(viewControllers: UIViewController , icons: String) {
        self.viewControllers = viewControllers
        self.icons = icons
    }
    init() {
        
    }
}
