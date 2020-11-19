//
//  UIViewExtension.swift
//  PullToRefresh
//
//  Created by Exlinct on 10/4/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import UIKit

public func delay(_ seconds: Double, completion: @escaping ( )-> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

extension UIView {
    class func fromNib() -> UIView? {
        return Bundle(for: self).loadNibNamed(String(describing: self), owner: nil, options: nil)?.first as? UIView
    }
}

