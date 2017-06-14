//
//  UserHasApply.swift
//  RaoViet
//
//  Created by Chung on 12/28/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit

class UserHasApply: BaseViewController {
    var post_id: String = ""
    var data: [UserApply] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
        addActivity()
        my_Table.delegate = self
        my_Table.dataSource = self
        my_Table.register(  UINib(nibName: "CellForUserApply", bundle: nil), forCellReuseIdentifier: "CellForUserApply")
        getUserHasApply(post_id: post_id, page: "1")
        
    }
    func getUserHasApply(post_id: String, page: String) {
        self.showActivity(isShow: true)
        ManagerData.instance.getUserHasApply(id: post_id, page: page, success: {[unowned self] json, msg in
            if (json?.array?.count)! > 0 {
                for item in (json?.array)! {
                    self.data.append(UserApply(from: item))
                }
                self.showActivity(isShow: false)
                DispatchQueue.main.async {
                    self.my_Table.reloadData()
                }
            }else {
                self.showActivity(isShow: false)
                
            }
            }, fail: { msg in
                self.showActivity(isShow: false)
                
        })
    }
 

   


}

 extension UserHasApply: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return data.count
        
        
    }
    
}
extension UserHasApply: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellForUserApply") as! CellForUserApply
        if let item: UserApply = data[indexPath.row] {
            cell.lbName.text = item.username
            cell.lbPhone.text = item.phone
            cell.lbDate.text = item.date
        }
        return cell
    }
    
}
