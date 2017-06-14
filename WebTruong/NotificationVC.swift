//
//  NotificationVC.swift
//  RaoViet
//
//  Created by ReasonAmu on 12/2/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit

class NotificationVC: BaseViewController {
    

    let cellNotification = "CellNotification"
    
    var data: [Notify] = []
    var page = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
        addActivity()
        my_Table.delegate = self
        my_Table.dataSource = self
        my_Table.register(UINib(nibName: "CellNotification", bundle: nil), forCellReuseIdentifier: cellNotification)
        getListNotification(page: page)
    }

    func getListNotification(page: Int) {
        self.showActivity(isShow: true)
        if let user_id = UserData.instance.user?.id {
            ManagerData.instance.getListUserSubcribe(user_id: user_id,page: page, success: {[unowned self] json, msg in
                if (json?.array?.count)! > 0 {
                    for item in (json?.array)! {
                        self.data.append(Notify(from: item))
                    }
                    self.showActivity(isShow: false)
                    DispatchQueue.main.async {
                        self.my_Table.reloadData()
                    }
                }
                }, fail: { msg in
                    self.showAlert(msg: msg)
            })
        }
        
    }
    
    
    
}
extension NotificationVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailPost(nibName: "DetailPost", bundle: nil)
        detailVC.title = "Chi tiết"
        if let post_id: String = self.arrID[indexPath.row] {
            detailVC.post_Id = Int(post_id)!
        }else {
            return
        }
        if let type = self.type_message {
            switch type {
            case "worker":
                detailVC.type_Post = typePost.worker
                break
            case "enterprise":
                detailVC.type_Post = typePost.enterprise
                break
            case "buy":
                detailVC.type_Post = typePost.buy
                break
            case "sell":
                detailVC.type_Post = typePost.sell
                break
            case "rent":
                detailVC.type_Post = typePost.rent
                break
            case "lease":
                detailVC.type_Post = typePost.lease
                break
            default:
                break
            }

        }
        self.navigationController?.pushViewController(detailVC, animated: true)
      
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension NotificationVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellNotification, for: indexPath) as! CellNotification
        cell.selectionStyle = .none
        if let item: Notify = data[indexPath.row] {
            self.parseJson(txt: (item.message)!)
            if profile_image != "" {
                self.loadImage(url_image: URL(string: profile_image!), imageView: cell.imageProfile, key: profile_image)
            }else {
                cell.imageProfile.image = UIImage(named: "image_intro")
            }
            
            cell.title.text = message
            cell.datetime.text = item.date
        }
       
        return cell
    }
    
}

