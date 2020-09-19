//
//  UIView.swift
//  LoadViewFromNib
//
//  Created by Exlinct on 8/20/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import UIKit

extension UIView {
    class func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T()), owner: nil, options: nil)?[0] as! T
    }
}
