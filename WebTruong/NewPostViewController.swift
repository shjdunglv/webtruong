//
//  NewPostViewController.swift
//  WebTruong
//
//  Created by HITECH on 1/15/17.
//  Copyright © 2017 shjdunglv. All rights reserved.
//

import UIKit
import SwiftyJSON
class NewPostViewController: BaseViewController, NewPostDetailDelegate, UIScrollViewDelegate {
    func didSelectItem(view: BaseViewController) {
       // self.navigationController?.pushViewController(view, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        var data : [DataPageMenu] = []
//        let tabDetail = NewPostDetailViewController(nibName: "NewPostDetailViewController", bundle: nil)
//        tabDetail.delegate = self
//
//        tabDetail.type = typeNewPost.newest
//       
//        data.append(DataPageMenu(viewControllers: tabDetail, icons: "icon_findjob"))
//        self.addChildViewController(tabDetail)
//        self.view.addSubview(tabDetail.view)
            let detailPost = NewPostDetailViewController(nibName: "NewPostDetailViewController", bundle: nil)

            detailPost.type = typeNewPost.newest
        
            self.addChildViewController(detailPost)
            self.view.addSubview(detailPost.view)


        // tabDetail.my_Table.reloadData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
         self.tabBarController?.navigationItem.title = "BÀI ĐĂNG MỚI NHẤT"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
