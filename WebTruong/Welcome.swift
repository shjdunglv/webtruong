//
//  Welcome.swift
//  RaoViet
//
//  Created by Chung on 12/12/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
class Welcome: UIViewController {
      var background_acti: UIView!
    //Layout
    var layoutTop: NSLayoutConstraint!
    var layoutBot: NSLayoutConstraint!
    var layoutRight: NSLayoutConstraint!
    var layoutLeft: NSLayoutConstraint!
    var layoutHeight: NSLayoutConstraint!
    var layoutWidth: NSLayoutConstraint!
    var layoutCenterX: NSLayoutConstraint!
    var layoutCenterY: NSLayoutConstraint!
    
    var loadingView: UIView!
    var loading: UIActivityIndicatorView!
    
    var time = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        addActivity()
        showActivity(isShow: true)
        self.time = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(Welcome.changeView(_:)), userInfo: nil, repeats: false)
        
    }
    func addActivity() {
        if background_acti == nil {
            background_acti = UIView()
            background_acti.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            background_acti.backgroundColor = UIColor.clear
            background_acti.clipsToBounds = true
            background_acti.isHidden = true
            background_acti.layer.cornerRadius = 10
            background_acti.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(background_acti)
            
            layoutTop = NSLayoutConstraint(item: background_acti, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0)
            
            layoutBot = NSLayoutConstraint(item: background_acti, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0)
            
            layoutRight = NSLayoutConstraint(item: background_acti, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0)
            
            
            layoutLeft = NSLayoutConstraint(item: background_acti, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0)
            NSLayoutConstraint.activate([layoutTop, layoutLeft, layoutBot, layoutRight])
            
        }
        if loading == nil {
            loadingView = UIView()
            loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            loadingView.backgroundColor = UIColor(hex: "#444444", alpha: 0.7)
            loadingView.clipsToBounds = true
            loadingView.isHidden = true
            loadingView.layer.cornerRadius = 10
            loadingView.translatesAutoresizingMaskIntoConstraints = false
            self.background_acti.addSubview(loadingView)
            
            layoutCenterX = NSLayoutConstraint(item: loadingView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
            layoutCenterY = NSLayoutConstraint(item: loadingView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
            
            layoutWidth = NSLayoutConstraint(item: loadingView
                , attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80)
            
            layoutHeight = NSLayoutConstraint(item: loadingView
                , attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80)
            NSLayoutConstraint.activate([layoutCenterX, layoutCenterY, layoutWidth, layoutHeight])
        }
        if loading == nil {
            loading = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            loading.hidesWhenStopped = true
            loading.activityIndicatorViewStyle =
                UIActivityIndicatorViewStyle.whiteLarge
            loading.translatesAutoresizingMaskIntoConstraints = false
            self.loadingView.addSubview(loading)
            layoutCenterX = NSLayoutConstraint(item: loading, attribute: .centerX, relatedBy: .equal, toItem: loadingView, attribute: .centerX, multiplier: 1, constant: 0)
            
            layoutCenterY = NSLayoutConstraint(item: loading, attribute: .centerY, relatedBy: .equal, toItem: loadingView, attribute: .centerY, multiplier: 1, constant: 0)
            
            layoutWidth = NSLayoutConstraint(item: loading
                , attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80)
            
            layoutHeight = NSLayoutConstraint(item: loading
                , attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80)
            NSLayoutConstraint.activate([layoutCenterX, layoutCenterY, layoutWidth, layoutHeight])
            
        }
    }
    func showActivity(isShow: Bool) {
        if isShow {
            background_acti.isHidden = false
            loadingView.isHidden = false
            loading.startAnimating()
        }else {
            background_acti.isHidden = true
            loadingView.isHidden = true
            loading.stopAnimating()
        }
    }
    func changeView(_ sender: AnyObject){
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        loading.stopAnimating()
        self.present(loginVC, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
