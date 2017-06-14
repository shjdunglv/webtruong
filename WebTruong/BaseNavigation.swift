//
//  BaseNavigation.swift
//  RaoViet
//
//  Created by Chung on 11/28/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit

class BaseNavigation: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBar.barTintColor = UIColor(hex: "#44393D")
        navigationBar.tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white ,  NSFontAttributeName: UIFont(name: "Lora-Bold", size: 15)!]
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        navigationBar.titleTextAttributes = titleDict as? [String : Any]

        
    }
    
}
