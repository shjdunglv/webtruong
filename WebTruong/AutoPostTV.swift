//
//  AutoPostTV.swift
//  WebTruong
//
//  Created by Le Dung on 5/2/17.
//  Copyright © 2017 shjdunglv. All rights reserved.
//
import Kanna
import UIKit
class AutoPostTV: BaseViewController,XMLMParserDelegate {
    enum server: String {
        case vnexpress
        case dantri
        case _24h
    }
    func XMLMParserError(parser: XMLParser, eroor: String) {
        print(eroor)
    }
        let cellID = "CellId"
    var parentNav:UINavigationController!
       var dict = [Dictionary<String,String>]()
    override func viewDidLoad() {
        super.viewDidLoad()

        addTableView()
        my_Table.delegate = self
        my_Table.dataSource = self
        my_Table.register(UINib(nibName: "CellAutoPost", bundle: nil), forCellReuseIdentifier: cellID)
        // Do any additional setup after loading the view.
        let parse = XMLParse(url: getLinkServer(svr: server.vnexpress))
        parse.delegate = self
        addActivity()
        showActivity(isShow: true)
        parse.parse {
            self.dict = parse.objects
            self.my_Table.reloadData()
            self.showActivity(isShow: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getLinkServer(svr: server)->NSURL
    {
        switch svr {
        case .vnexpress:
            return NSURL(string: "http://vnexpress.net/rss/tin-moi-nhat.rss")!
        default:
            return NSURL(string: "http://vnexpress.net/rss/tin-moi-nhat.rss")!
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func detectThumb(desc: String) -> String
    {
        var path = ""
        if let doc = HTML(html: desc, encoding: String.Encoding.utf8)
        {
        for link in doc.xpath("//img")
        {
            path = link["src"]!
        }
        }
        return path
    }
}
extension AutoPostTV: UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dict.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
extension AutoPostTV: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! CellAutoPost
        cell.lblTitle.text = dict[indexPath.row]["title"]
        cell.lblTime.text = dict[indexPath.row]["pubDate"]
        let path = detectThumb(desc: dict[indexPath.row]["description"]! as String)
        loadImage(url_image: URL(string: path), imageView: cell.imgThumb, key: path)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AutoPostContent(nibName: "AutoPostContent", bundle: nil)
        vc.html = (dict[indexPath.row]["link"])?.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: "\n", with: "")
        vc.navTitle = dict[indexPath.row]["title"]
        //self.navigationController?.pushViewController(vc, animated: true)
        self.parentNav.pushViewController(vc, animated: true)
        //self.parentNav.popToViewController(vc, animated: true)
    }
    
}
