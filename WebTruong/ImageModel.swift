//
//  NetData.swift
//  Me2Be
//
//  Created by DuongNArtist on 5/6/16.
//  Copyright © 2016 SunVNMedia. All rights reserved.
//

import Foundation

enum ImageType: String {
    case ImageJpeg = "image/jpeg"
    case ImagePng = "image/png"
    case ImageGif = "image/gif"
    case Json = "application/json"
    case Unknown = ""
    
    func getString() -> String {
        switch self {
        case .ImagePng:
            fallthrough
        case .ImageJpeg:
            fallthrough
        case .ImageGif:
            fallthrough
        case .Json:
            return self.rawValue
        case .Unknown:
            fallthrough
        default:
            return ""
        }
    }
}

class ImageModel
{
    let imageData: Data
    let imageType: ImageType
    let imageName: String
    
    init(imageData: Data, imageType: ImageType, imageName: String) {
        self.imageData = imageData
        self.imageType = imageType
        self.imageName = imageName
    }
    
//    init(pngImage: UIImage, imageName: String) {
//        imageData = UIImagePNGRepresentation(pngImage)!
//        self.imageType = ImageType.ImagePng
//        self.imageName = imageName
//    }
//    
//    init(jpegImage: UIImage, compressionQuanlity: CGFloat, imageName: String) {
//        imageData = UIImageJPEGRepresentation(jpegImage, compressionQuanlity)!
//        self.imageType = ImageType.ImageJpeg
//        self.imageName = imageName
//    }
}
