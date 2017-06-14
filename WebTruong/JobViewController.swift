//
//  JobViewController.swift
//  RaoViet
//
//  Created by Chung on 12/1/16.
//  Copyright © 2016 3i. All rights reserved.
//
import MIBadgeButton_Swift
import UIKit
class JobViewController: BaseViewController, DetailPostDelegate {
    internal func didSelectItem(view: BaseViewController) {
        self.navigationController!.pushViewController(view, animated: true)
    }
    var tab1: TableDetail!
    var tab2: TableDetail!
    var data: [DataPageMenu] = []
    var isMyPost: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tab1 = TableDetail(nibName: "TableDetail", bundle: nil)
        tab1.type = typePost.enterprise
        tab1.delegate = self
        tab1.title = "Tìm thợ "
        tab1.parentNavigation = self.tabBarController?.navigationController
        data.append(DataPageMenu(viewControllers: tab1, icons: "icon_findjob"))
        
        tab2 = TableDetail(nibName: "TableDetail", bundle: nil)
        tab2.type = typePost.worker
        tab2.delegate = self
        tab2.parentNavigation = self.tabBarController?.navigationController
        data.append(DataPageMenu(viewControllers: tab2, icons: "find_worker"))
        tab2.title = "Tìm việc"
        
        if isMyPost == false {
            tab1.isMyPost = false
            tab2.isMyPost = false
            tab2.typeNav = typeNav.tab
            tab1.typeNav = typeNav.tab
            
        }else {
            tab1.isMyPost = true
            tab2.isMyPost = true
            tab2.typeNav = typeNav.nav
            tab1.typeNav = typeNav.nav
            
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isMyPost == false {
            self.tabBarController?.navigationItem.title = "TIN RAOVIET MỚI"
        }else {
            self.tabBarController?.navigationItem.title = "MY JOBS"
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
            searchView.title = "Cần thợ"
            searchView.type = typePost.enterprise
        }else {
            searchView.title = "Tìm việc"
            searchView.type = typePost.worker
        }
        self.tabBarController?.navigationController?.pushViewController(searchView, animated: true)
    }
    
    
    
    
}


