//
//  AutoPostContent.swift
//  WebTruong
//
//  Created by Le Dung on 5/5/17.
//  Copyright © 2017 shjdunglv. All rights reserved.
//

import UIKit
import Kanna
class AutoPostContent: BaseViewController {

    @IBOutlet weak var wkView1: UIWebView!
    var navTitle:String!
    var html:String!
    private var tags:String!
    override func viewDidLoad() {
        //super.viewDidLoad()
                self.navigationItem.title = navTitle
        wkView1.loadRequest(NSURLRequest(url: NSURL(string: html) as! URL) as URLRequest)
        let btnUpdate = UIBarButtonItem(image: UIImage(named: "checked"),style: .plain,target: self, action: #selector(post))
               self.navigationItem.rightBarButtonItem = btnUpdate
        self.addActivity()
        // Do any additional setup after loading the view.
    }
    func post(){
        showActivity(isShow: true)
        do{
        let stringHtml = try String(contentsOf: URL(string: html)!, encoding: String.Encoding.utf8)
            if let doc = HTML(html: stringHtml, encoding: String.Encoding.utf8){
                let content:String?
                    do{
                        let indoc = try doc.css(".block_ads_connect")[0].toHTML
                        content = indoc?.encodeURIComponent()
                    }
                    catch{
                        print("error!")
                    }
                
                do{
                    var listTag = [String]()
                    for indoc in try doc.css(".block_tag .tag_item"){
                        listTag.append(indoc.text!)
                    }
                    self.tags = listTag.joined(separator: ",")

                }
                catch{
                    print("error!")
                }
                
                //Send request post
                
                ManagerData.instance.upPost(title: navTitle, content: content!, tags: tags, subCategory: 9, success: {
                    [unowned self] msg in
                    self.showAlert(msg: "Success")
                    self.showActivity(isShow: false)
                    }, fail: {
                        [unowned self] msg in
                        self.showAlert(msg: msg)
                        self.showActivity(isShow: false)
                    }
                )
            }
        }
        catch{
            
        }
        
        
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
