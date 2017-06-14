//
//  BusinessViewController.swift
//  RaoViet
//
//  Created by Chung on 12/1/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit

class BusinessViewController: BaseViewController, DetailPostDelegate {
    internal func didSelectItem(view: BaseViewController) {
        self.navigationController!.pushViewController(view, animated: true)
    }

    var data: [DataPageMenu] = []
var isMyPost: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let tab1 = TableDetail(nibName: "TableDetail", bundle: nil)
        tab1.type = typePost.sell
        tab1.delegate = self
         tab1.title = "Bán"
        tab1.parentNavigation = self.tabBarController?.navigationController
       
        data.append(DataPageMenu(viewControllers: tab1, icons: "icon_sell"))
        
        let tab2 = TableDetail(nibName: "TableDetail", bundle: nil)
         tab2.type = typePost.buy
        tab2.delegate = self
        tab2.title = "Mua"
        tab2.parentNavigation = self.tabBarController?.navigationController
        data.append(DataPageMenu(viewControllers: tab2, icons: "icon_buy"))
        
        if isMyPost == false {
            tab1.isMyPost = false
            tab2.isMyPost = false
            tab2.typeNav = typeNav.tab
            tab1.typeNav = typeNav.tab
        }else {
            tab1.isMyPost = true
            tab2.isMyPost = true
            tab1.typeNav = typeNav.nav
            tab2.typeNav = typeNav.nav
        }

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isMyPost == false {
            self.tabBarController?.navigationItem.title = "TIN RAOVIET MỚI"
        }else {
            self.tabBarController?.navigationItem.title = "MY MARKET"
        }
    }
    
    override func viewDidLayoutSubviews() {
        configPageMenu(data: data)
        if isMyPost == false {
            pageMenu.view.frame = CGRect(x: 0.0,y: 0.0,width: self.view.frame.width,height: self.view.frame.height - 50)
        }else {
            
            pageMenu.view.frame = CGRect(x: 0.0,y: 0.0,width: self.view.frame.width,height: self.view.frame.height)
        }
        
        
    }
    override func search() {
        let searchView = SearchViewController(nibName: "SearchViewController", bundle: nil)
        
        if pageMenu.currentPageIndex == 0 {
            searchView.title = "TÌM KIẾM CÁC THÔNG TIN BÁN"
            searchView.type = typePost.sell
        }else {
            searchView.title = "TÌM KIẾM CÁC THÔNG TIN MUA"
            searchView.type = typePost.buy
        }
        
        
        self.tabBarController?.navigationController?.pushViewController(searchView, animated: true)
    }
    
}



