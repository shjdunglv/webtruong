//
//  CommentVC.swift
//  WebTruong
//
//  Created by Le Dung on 5/28/17.
//  Copyright © 2017 shjdunglv. All rights reserved.
//

import UIKit

class CommentVC: BaseViewController,MessageBoxDelegate {
    func checkResult(msg: String){
        self.showAlert(msg: msg)
    }
    func deleteCell(index: UITableViewCell) {
        if let deleteIndex = my_Table.indexPath(for: index){
        data.remove(at: deleteIndex.row)
        my_Table.deleteRows(at: [deleteIndex], with: UITableViewRowAnimation.automatic)
        }
    }
    var comment = [Comment]()
    struct instance {
        let comment:Comment
        let post: Post
        let user: User
    }
    var data = [instance]()
    var imgData = [String:UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        addActivity()
        comment.removeAll(keepingCapacity: true)
        getData()
        addTableView()
        //self.my_Table.register(UINib(nibName: "CellforComment", bundle: nil), forCellReuseIdentifier: "CellId")
        self.my_Table.register(CellforComment.self, forCellReuseIdentifier: "CellId")
        self.my_Table.delegate = self
        self.my_Table.dataSource = self
        self.my_Table.separatorStyle = UITableViewCellSeparatorStyle.singleLineEtched
        self.my_Table.separatorColor = UIColor.green

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData(){
        ManagerData.instance.getNewComment(success: {
        [unowned self] json in
            for item in json[1].array!{
                let tmp = instance(comment: Comment(from: item), post: Post(from: item["post"]), user: User(from: item["user"]))
                self.data.append(tmp)
            }
            self.my_Table.reloadData()
            }, fail: {
                [unowned self] msg in
                self.showAlert(msg: msg)
        }
        )
    }
    func addPopup(id: Int, msg: String,index: UITableViewCell)
    {
        //Hide left and right bar button in Navigation
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        //instance View
        let msgbox = MessageBox(nibName: "MessageBox", bundle: nil)
        msgbox.comment = msg
        msgbox.id = id
        msgbox.index = index
        self.addChildViewController(msgbox)
        //        changePassWordVC.preferredContentSize = CGSize(width: changePassWordVC.view.frame.width, height: changePassWordVC.view.frame.height)
        msgbox.view.frame = CGRect(x: self.view.frame.width/2 - msgbox.view.frame.width/2,y: self.view.frame.height/2 - msgbox.view.frame.height/2, width: msgbox.view.frame.width, height: msgbox.view.frame.height)
        msgbox.delegate = self
        self.view.addSubview(msgbox.view)
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
extension CommentVC:UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let statusText = data[indexPath.row].post.post_title{
            let contentStr = data[indexPath.row].user.display_name + " đã bình luận trong bài viết: " + data[indexPath.row].post.post_title!
            let rect = NSString(string: contentStr).boundingRect(with: CGSize(width: view.frame.width-8, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 13)], context: nil)
            let knownHeight:CGFloat = 20 + 20
            return knownHeight + rect.height
        }
        return 100
    }

}
extension CommentVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId") as! CellforComment
        let atribute:UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            let attribute = NSMutableAttributedString(string: data[indexPath.row].user.display_name!, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12)])
            attribute.append(NSMutableAttributedString(string: " đã bình luận trong bài viết: ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 11),NSForegroundColorAttributeName: UIColor.gray]))
            
            attribute.append(NSMutableAttributedString(string: data[indexPath.row].post.post_title!, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12),NSForegroundColorAttributeName: UIColor.black]))
            let paragraph = NSMutableParagraphStyle()
            paragraph.lineSpacing = 5
            attribute.addAttribute(NSParagraphStyleAttributeName, value: paragraph, range: NSRange(location: 0, length: attribute.string.characters.count))
            
//            let attachment = NSTextAttachment()
//            attachment.image = UIImage(named: "globe_small")
//            attachment.bounds = CGRect(x: 0, y: -2, width: 11, height: 11)
//            attribute.append(NSAttributedString(attachment: attachment))
            label.translatesAutoresizingMaskIntoConstraints = false
            label.attributedText = attribute
            
            
            return label
        }()
        cell.content.text = nil
        cell.content = atribute
        cell.setupView()
        self.loadImage(url_image: URL(string:ManagerData.instance.baseUrl + data[indexPath.row].user.picture_profile!), imageView: cell.imgAvt, key: ManagerData.instance.baseUrl + data[indexPath.row].user.picture_profile!)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = data[indexPath.row].comment.id!
        addPopup(id: id ,msg: data[indexPath.row].comment.content!,index: my_Table.cellForRow(at: indexPath)!)
    }
}
class CellforComment:UITableViewCell{
    let imgAvt:UIImageView = {
    let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = UIColor.gray
        return img
    }()
    var content:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//    let userName:UILabel = {
//        let label = UILabel()
//        label.text = "Tai khoan"
//        label.tintColor = UIColor.blue
//        label.font = UIFont.boldSystemFont(ofSize: 12)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    let type:UILabel = {
//        let label = UILabel()
//        label.text = "kieu binh luan"
//        label.font = UIFont.systemFont(ofSize: 12)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    let viewLabel:UIView = {
//        let vl = UIView()
//        vl.backgroundColor = UIColor.red
//        vl.translatesAutoresizingMaskIntoConstraints = false
//        return vl
//    }()
    required init?(coder aDecoder: NSCoder) {
        //super.init(coder: aDecoder)
        fatalError("Error with required init!")
        }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
        
    }

    func setupView()
    {
        addSubview(imgAvt)
        //viewLabel.addSubview(content)
//        viewLabel.addSubview(userName)
//        viewLabel.addSubview(type)
        addSubview(content)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0(80)]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":imgAvt]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":content]))
//        viewLabel.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v1]-[v2]-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":content,"v1":userName,"v2":type]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0(80)]-10-[v1]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":imgAvt,"v1":content]))
    }
}
