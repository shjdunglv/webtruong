//
//  BaseTableViewCell.swift
//  RaoViet
//
//  Created by Chung on 12/26/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit
import Kingfisher
class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func loadImage(url_image: URL?, imageView: UIImageView, key: String?) {
        if KingfisherManager.shared.cache.isImageCached(forKey: key!).cached {
            KingfisherManager.shared.cache.retrieveImage(forKey: key!, options: nil) { (Image, CacheType) -> () in
                if Image != nil {
                    imageView.image = Image
                }
            }
        }else {
            imageView.kf.indicatorType = .activity
            imageView.kf.indicator?.startAnimatingView()
            self.downloadImage(url_image: url_image!, imageView: imageView, key: key! )
        }
        
    }
    
    override func downloadImage(url_image: URL, imageView: UIImageView, key: String?) {
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
