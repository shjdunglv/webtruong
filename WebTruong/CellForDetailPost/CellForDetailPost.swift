//
//  CellForDetailPost.swift
//  WebTruong
//
//  Created by HITECH on 1/22/17.
//  Copyright © 2017 shjdunglv. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON
import Kanna
class CellForDetailPost: UICollectionViewCell, UIGestureRecognizerDelegate {
    @IBOutlet weak var viewAll: UIView!
    @IBOutlet weak var viewTag: UIView!

    @IBOutlet weak var imgThumb: UIImageView!
    
    @IBOutlet weak var tfTitle: UILabel!
    @IBOutlet weak var lbLink1: UILabel!
    @IBOutlet weak var lbLink2: UILabel!
    @IBOutlet weak var lbLink3: UILabel!
    @IBOutlet weak var tfViewcount: UILabel!
    
    @IBOutlet weak var tfDate: UILabel!
    
    @IBOutlet weak var tfContent: UILabel!
    @IBOutlet weak var lPrimary: UIView!
    
    
    var htmlcontent:String!
    var parentNavigation: UINavigationController?
    override init(frame: CGRect) {
       // super.viewDidLoad()
        super.init(frame: frame)
        
         //Do any additional setup after loading the view.
     //   let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFunction(sender:)))
      //  lbLink1.isUserInteractionEnabled = true
       // lbLink1.addGestureRecognizer(tap)
       // tap.delegate = self // Remember to extend your class with UIGestureRecognizerDelegate
        
         //Receive action

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       // setupViews()
        self.viewAll.layer.cornerRadius = 5.0
        self.viewTag.layer.cornerRadius = 3.0
        self.viewTag.layer.shadowOpacity = 0.2
        self.viewTag.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    
    var content:content_post?
        {
        didSet{
            tfTitle.text = content?.title
            tfContent.text = content?.content
            tfViewcount.text = String(describing: content?.viewed!)
            if let imgData = content?.thumb
            {
                let path = imgData
                loadImage(url_image: URL(string: path), imageView: imgThumb, key: path)
            }
        }
    }
    var set4Link:[content_post]?
        {
        didSet{
            tfTitle.text = set4Link?[0].title
            tfTitle.tag = (set4Link?[0].id)!
            tfContent.text = set4Link?[0].content
            tfViewcount.text = String(describing: set4Link![0].viewed!)
            lbLink1.text = set4Link?[1].title
            lbLink1.tag = (set4Link?[1].id)!
            lbLink2.text = set4Link?[2].title
            lbLink2.tag = (set4Link?[2].id)!
            lbLink3.text = set4Link?[3].title
            lbLink3.tag = (set4Link?[3].id)!
            if let imgData = set4Link?[0].thumb
            {
                let path = imgData
                loadImage(url_image: URL(string: path), imageView: imgThumb, key: path)
            }
            }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        //You Code here
    }
    
    func setLink(obj: UILabel)
    {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFunction(sender:)))
        //obj.text = "abc"
        obj.becomeFirstResponder()
        obj.isUserInteractionEnabled = true
        obj.addGestureRecognizer(tap)
        tap.delegate = self
    }
    func tapFunction(sender:UITapGestureRecognizer) {
        let lbtext:UILabel = sender.view as! UILabel
         let vc = ContentPost(nibName: "ContentPost", bundle: nil)
        ManagerData.instance.getPostbyID(id: lbtext.tag,
                                         success: {
                                            [unowned self](json) in
            let post:content_post = content_post(from: json[1])
            //let htmlcontent = post.content!
            vc.html = post.content
            vc.navTitle = post.title
            self.parentNavigation?.pushViewController(vc, animated: true)
        }, fail: {[unowned self] msg in
            
            print(msg)})
        
        //self.collectio
        // let doc = HTML(url: url as! URL, encoding: String.Encoding.utf8)
       
       // let htmlcontent = doc?.css(".post-content")[0].text

        //vc.wkView.loadHTMLString(htmlcontent!, baseURL: nil)
        
        
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
extension CellForDetailPost
{
    func loadImage(url_image: URL?, imageView: UIImageView, key: String?) {
        if KingfisherManager.shared.cache.isImageCached(forKey: key!).cached {
            KingfisherManager.shared.cache.retrieveImage(forKey: key!, options: nil) { (Image, CacheType) -> () in
                if Image != nil {
                    imageView.image = Image
                }
            }
        }else {
            imageView.kf.indicatorType = .activity
            imageView.kf.indicator?.startAnimatingView()
            DispatchQueue.main.async {
                self.downloadImage(url_image: url_image!, imageView: imageView, key: key! )
            }
            
        }
        
    }
    
    func downloadImage(url_image: URL, imageView: UIImageView, key: String?) {
        imageView.image = UIImage()
        KingfisherManager.shared.downloader.downloadImage(with: url_image, options: nil, progressBlock: nil, completionHandler: { (image, error, url, data) -> () in
            
            if image != nil {
                if let resizeImage = (image?.kf.resize(to: CGSize(width: imageView.frame.size.width + 50, height: imageView.frame.size.height + 50)))
                {
                    KingfisherManager.shared.cache.store(resizeImage, forKey: key!)
                    imageView.image = resizeImage
                    imageView.kf.indicator?.stopAnimatingView()
                    
                }
            }else {
                //                imageView.image = UIImage(named: "haha")
                imageView.kf.indicator?.stopAnimatingView()
                
            }
        })
    }
}
