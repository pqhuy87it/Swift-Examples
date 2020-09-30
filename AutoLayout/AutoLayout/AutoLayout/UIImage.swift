//
//   UIImage.swift
//  AutoLayout
//
//  Created by JohnLui on 15/4/19.
//  Copyright (c) 2015年 Miao Tec Inc. All rights reserved.
//

import UIKit

extension UIImage {
    func resizeToSize(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0) // change from UIGraphicsBeginImageContext(size) to suit scale > 1
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
