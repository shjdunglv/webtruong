//
//  CellTableview.swift
//  Test
//
//  Created by ReasonAmu on 12/1/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Kingfisher
class CellTableview: UITableViewCell {
    
    @IBOutlet weak var tfTitle: UILabel!
    @IBOutlet weak var tfContent: UILabel!
    @IBOutlet weak var tfLocation: UILabel!
    @IBOutlet weak var tfViewCount: UILabel!
    @IBOutlet weak var tfDate: UILabel!
    @IBOutlet weak var imgThumb: UIImageView!
    
//    @IBOutlet weak var cbFavorite: CheckBox!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    var post : Post? {
        
        didSet{
            tfTitle.text = post?.post_title
            tfContent.text = post?.post_content
            tfLocation.text = post?.address
            tfViewCount.text = post?.view_count
            //            if let dateTimeUNix =  post?.post_date {
            //                datetimeString.text = convertDateTimeUnix_ToString(datetimeUnix: TimeInterval(dateTimeUNix)!)
            //            }
            tfDate.text = post?.post_date
            
        }
    }
    var content:content_post?
        {
        didSet{
            tfTitle.text = content?.title
            tfContent.text = content?.content
            tfViewCount.text = String(describing: content?.viewed)
            if let imgData = content?.thumb
            {
            let path = imgData
            loadImage(url_image: URL(string: path), imageView: imgThumb, key: path)
            }
        }
    }
    
    func setupViews(){
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.2
        self.layer.cornerRadius = 0
        self.layer.masksToBounds = true
    }
    
  
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


extension UITableViewCell {
    
    
    //-- convert Time
    func convertDateTimeUnix_ToString(datetimeUnix : TimeInterval) -> String{
        
        let dateTimeConvert = TimeInterval(datetimeUnix)
        let date = NSDate(timeIntervalSince1970: dateTimeConvert)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd/MM/yyyy"
        let dateString =  dayTimePeriodFormatter.string(from: date as Date)
        
        return dateString
        
        
    }
    
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
