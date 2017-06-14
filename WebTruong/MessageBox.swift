//
//  MessageBox.swift
//  WebTruong
//
//  Created by Le Dung on 5/28/17.
//  Copyright © 2017 shjdunglv. All rights reserved.
//

import UIKit
import SwiftyJSON
@objc protocol MessageBoxDelegate{
    func checkResult(msg: String)
    func deleteCell(index:UITableViewCell)
}
class MessageBox: BaseViewController {

    var comment:String!
    var id: Int!
    var index:UITableViewCell!
    @IBOutlet weak var content: UITextView!

    @IBAction func del(_ sender: Any) {
        ManagerData.instance.setStatusComment(id: id, success: {
            [unowned self] msg in
            self.delegate?.checkResult(msg: msg[1].string!)
            self.delegate?.deleteCell(index: self.index)
            }, fail:{
                [unowned self] msg in
                self.showAlert(msg: msg)
            }
        )
        removePopup()
    }
    
    @IBAction func approve(_ sender: Any) {
       ManagerData.instance.setStatusComment(id: id, success: {
           [unowned self] msg in
            self.delegate?.checkResult(msg: msg[1].string!)
            self.delegate?.deleteCell(index: self.index)
       }, fail:{
        [unowned self] msg in
            self.showAlert(msg: msg)
            }
        )
        removePopup()
    }

    weak var delegate : MessageBoxDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setData(comment: comment)
        self.showPopup()
        // Do any additional setup after loading the view.
    }
    func setData(comment:String){
         content.text = comment
    }
    override func viewWillAppear(_ animated: Bool) {
        self.view.layer.cornerRadius = 10
        addActivity()
    }
    
    func showPopup()
    {
        
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations:{
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.alpha = 1.0}
        )
    }
    func removePopup()
    {
        UIView.animate(withDuration: 0.15, animations: {
            self.view.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.view.alpha = 0.5
        }, completion: { (finished: Bool) in
            if finished {
                UIView.animate(withDuration: 0.15, animations: {
                    self.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    self.view.alpha = 0.0
                },completion: {(finish: Bool) in if finish {self.view.removeFromSuperview()
                    
                    }}
                )
            }
        }
        )
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
