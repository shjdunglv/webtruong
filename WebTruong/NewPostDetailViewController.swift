//
//  NewPostDetailViewController.swift
//  WebTruong
//
//  Created by HITECH on 1/15/17.
//  Copyright © 2017 shjdunglv. All rights reserved.
//

import UIKit
import SwiftyJSON
protocol NewPostDetailDelegate{
    func didSelectItem(view: BaseViewController)
}
enum typeNewPost: String
{
    case hot
    case newest
    case tag
}
class NewPostDetailViewController: BaseViewController {
    var delegate: NewPostDetailDelegate?
    let cellID = "CellID"
    var type: typeNewPost!
    var pages = 1
    //var fullData:[Int:[content_post]] = []
    var category:[String] = []
    var data: [[content_post]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //Add table view
        addCollectionView()
       my_CollectionView.register(UINib(nibName: "CellForDetailPost", bundle: nil), forCellWithReuseIdentifier: "CellID")
       // my_CollectionView.register(CellForDetailPost.self, forCellWithReuseIdentifier: "CellID")
        //my_Table.register(UINib(nibName: "CellTableview", bundle: nil), forCellReuseIdentifier: "CellID")
        my_CollectionView.delegate = self
        my_CollectionView.dataSource = self
       addForView(page: pages, type: type)
    }
    
    func addForView(page: Int, type: typeNewPost)
    {
        switch type {
        case .newest:
            getData(type: 1, page: 1)
            
        default:
            break;
        }
    }
    func getData(type: Int, page: Int)
    {
        ManagerData.instance.getPost(type: type, page: page, success: {(json) in
            if (json.array?.count)! > 0
            {
                for item:JSON in json[1].array!
                {
                    var dataindex: [content_post] = []
                    self.category.append(item["title"].string!)
                    for post in item["post"].array!
                    {
                        dataindex.append(content_post(from: post))
                    }
                    self.data.append(dataindex)
                    //self.data.append(content_post(from: item))
                    DispatchQueue.main.async{
                        self.my_CollectionView.reloadData()
                    }
                }
            }
        }, fail: {[unowned self] (msg) in print(msg)})
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }

}
extension NewPostDetailViewController: UICollectionViewDelegate
{
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if data.count > 15
//        {
//            return 15
//        }
//        else
//        {
//        return data.count
//        }
//    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        return UITableViewAutomaticDimension
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let hsection = BaseHeaderSectionViewController(nibName: "BaseHeaderSectionViewController", bundle: nil)
//        var hview = UIView(frame: CGRect(x: 0, y: 0, width: hsection.view.frame.width, height: hsection.view.frame.height))
//        hview.addSubview(hsection.view)
//        return hview
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
}
extension NewPostDetailViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CellForDetailPost
        if data.count > 0
        {
            if(data[indexPath.row].count == 4)
            {
                cell.set4Link = data[indexPath.row]
                cell.setLink(obj: cell.lbLink1)
                cell.setLink(obj: cell.lbLink2)
                cell.setLink(obj: cell.lbLink3)
                cell.setLink(obj: cell.tfTitle)
                cell.parentNavigation = self.tabBarController?.navigationController
            }
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//         let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! CellTableview
//        if data.count > 0
//        {
//        cell.content = data[indexPath.row]
//        }
//                return cell
//    }

}
extension NewPostDetailViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: view.frame.width-20,height: 400)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    //Chinh giua
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 10, 0, 10)
    }
}
