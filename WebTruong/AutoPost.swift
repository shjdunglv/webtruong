//
//  AutoPost.swift
//  WebTruong
//
//  Created by Le Dung on 5/1/17.
//  Copyright © 2017 shjdunglv. All rights reserved.
//

import UIKit



class AutoPost: BaseViewController {
    func XMLParserError(parser: XMLParser, eroor: String) {
        print(eroor)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getContent(url: "http://vnexpress.net/rss/tin-moi-nhat.rss")
        // Do any additional setup after loading the view.
        let autotv = AutoPostTV(nibName: "AutoPostTV", bundle: nil)
        autotv.parentNav = self.tabBarController?.navigationController
        self.addChildViewController(autotv)
        self.view.addSubview(autotv.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "AutoPost"
    }
    

    /*
    // MARK: - Navigation
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
