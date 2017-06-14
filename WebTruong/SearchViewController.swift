//
//  SearchViewController.swift
//  RaoViet
//
//  Created by Chung on 12/2/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit



class SearchViewController: BaseViewController {
    
    
    var type: typePost!
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview(type: type)
        
    }
    
    func addSubview(type: typePost) {
        switch type {
        case .worker, .enterprise:
            addSearchForJob()
            break
        case .buy,.sell,.rent,.lease:
            addSearchForMarket()
            break
        default:
            break
        }
    }
    
    func addSearchForJob() {
        let searchForJob = SearchForJob(nibName: "SearchForJob", bundle: nil)
        searchForJob.type = type
        searchForJob.willMove(toParentViewController: self)
        self.view.addSubview(searchForJob.view)
        self.addChildViewController(searchForJob)
        searchForJob.didMove(toParentViewController: self)
        searchForJob.view.translatesAutoresizingMaskIntoConstraints = false
        
        layoutTop = NSLayoutConstraint(item: searchForJob.view, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0)
        
        layoutBot = NSLayoutConstraint(item: searchForJob.view, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        layoutRight = NSLayoutConstraint(item: searchForJob.view, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0)
        
        
        layoutLeft = NSLayoutConstraint(item: searchForJob.view, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([layoutTop, layoutLeft, layoutBot, layoutRight])
    }
    
    func addSearchForMarket() {
        let searchForMarket = SearchForMarket(nibName: "SearchForMarket", bundle: nil)
        searchForMarket.type = type
        searchForMarket.willMove(toParentViewController: self)
        self.view.addSubview(searchForMarket.view)
        self.addChildViewController(searchForMarket)
        searchForMarket.didMove(toParentViewController: self)
        searchForMarket.view.translatesAutoresizingMaskIntoConstraints = false
        
        layoutTop = NSLayoutConstraint(item: searchForMarket.view, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0)
        
        layoutBot = NSLayoutConstraint(item: searchForMarket.view, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        layoutRight = NSLayoutConstraint(item: searchForMarket.view, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0)
        
        
        layoutLeft = NSLayoutConstraint(item: searchForMarket.view, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([layoutTop, layoutLeft, layoutBot, layoutRight])
    }
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationItem.title = ""
        
    }
    
    
    
    
}
