//
//  BaseTabbar.swift
//  RaoViet
//
//  Created by Chung on 11/28/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit

class BaseTabbar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBar.barTintColor = UIColor(hex: "#249bb3")
        tabBar.tintColor = UIColor.white
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.white ,  NSFontAttributeName: UIFont(name: "OpenSans-SemiBold", size: 15)!], for: .normal)
        
        //NewPost
        let newPost = NewPostViewController(nibName: "NewPostViewController", bundle: nil)
        let newPostNav = BaseNavigation(rootViewController: newPost)
        settingNavForController(viewController: newPost, tab_title: "Bài đăng mới nhất", image: "job", tag: 1, navTitle: "Bài đăng")
        
        
        let autoPost = AutoPost(nibName: "AutoPost", bundle: nil)
        let autoPostNav = BaseNavigation(rootViewController: autoPost)
        settingNavForController(viewController: autoPost, tab_title: "AutoPost", image: "job", tag: 2, navTitle: "AutoPost")
        //
//        let job = JobViewController(nibName: "JobViewController", bundle: nil)
//        let business = BusinessViewController(nibName: "BusinessViewController", bundle: nil)
//        let rentting = RentingViewController(nibName: "RentingViewController", bundle: nil)
        //        let chat = ChatViewController(nibName: "ChatViewController", bundle: nil)
        
//        let jobNav = BaseNavigation(rootViewController: job)
//        let businessNav = BaseNavigation(rootViewController: business)
//        let renttingNav = BaseNavigation(rootViewController: rentting)
        //        let chatNav = BaseNavigation(rootViewController: chat)
        
//        settingNavForController(viewController: job, tab_title: "Công Việc", image: "job", tag: 1, navTitle: "Công Việc")
//        
//        settingNavForController(viewController: business, tab_title: "Mua Bán", image: "market", tag: 2, navTitle: "Mua Bán")
//        
//        settingNavForController(viewController: rentting, tab_title: "Cho Thuê", image: "rent", tag: 3, navTitle: "Cho Thuê")
        
        
        //        settingNavForController(viewController: chat, tab_title: "Chat", image: "chat_g", selectedImage: "chat", tag: 4, navTitle: "Chat")
        
        viewControllers = [newPostNav, autoPostNav]
        
        
        for item in self.tabBar.items as [UITabBarItem]! {
            if let image = item.image {
                item.image = image.imageWithColor(tintColor: UIColor.white).withRenderingMode(.alwaysOriginal)
            }
            UITabBar.appearance().selectionIndicatorImage = UIImage().makeImageWithColorAndSize(color: UIColor(hex: "#046f84"), size: CGSize(width: UIScreen.main.bounds.width/3, height: tabBar.frame.height))
            
        }
        
    }
    func settingNavForController(viewController: BaseViewController, tab_title: String, image: String, tag: Int, navTitle: String) {

        viewController.navigationItem.title = navTitle
          viewController.tabBarItem = UITabBarItem(title: tab_title, image: UIImage(named: image)?.withRenderingMode(.alwaysOriginal), tag: tag)
    }

}


