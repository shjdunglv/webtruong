//
//  File.swift
//  WebTruong
//
//  Created by Le Dung on 5/7/17.
//  Copyright © 2017 shjdunglv. All rights reserved.
//

import Foundation

extension String
{
    func encodeURIComponent() -> String? {
        let characterSet = NSMutableCharacterSet.urlQueryAllowed
        
        return self.addingPercentEncoding(withAllowedCharacters: characterSet)
    }
}
