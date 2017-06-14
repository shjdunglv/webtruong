//
//  ContentPost.swift
//  WebTruong
//
//  Created by HITECH on 2/9/17.
//  Copyright © 2017 shjdunglv. All rights reserved.
//

import UIKit

class ContentPost: UIViewController {

    @IBOutlet weak var wkView: UIWebView!
    var html:String!

    var navTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = navTitle
        wkView.loadHTMLString(loadhtml(html: html), baseURL: nil)
    }

    func loadhtml(html:String) ->String
    {
        let doc = "<!DOCTYPE html>"
        + "<html lang=\"ja\">"
        + "<head>"
        + "<meta charset=\"UTF-8\">"
        + "<style type=\"text/css\">"
        + "html{margin:0 10px 0 10px;padding:0;}"
        + "body {"
        + "margin: 0;"
        + "padding: 0;"
        + "color: #363636;"
        + "font-size: 90%;"
        + "line-height: 1.6;"
        + "background: white;"
        + "}"
        + "img{"
        //+ "position: absolute;"
        + "top: 0;"
        + "bottom: 0;"
        + "left: 10px;"
        + "right: 10px;"
        + "margin: auto;"
        + "max-width: 100%;"
        + "max-height: 100%;"
        + "}"
        + "</style>"
        + "</head>"
        + "<body id=\"page\">"
        + "\(html) </body></html>"
        return doc
    }
    override func awakeFromNib() {
        super.awakeFromNib()
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
