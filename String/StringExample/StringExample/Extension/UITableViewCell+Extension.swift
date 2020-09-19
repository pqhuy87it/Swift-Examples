//
//  UITableViewCell+Extension.swift
//  YuuchoBanking
//
//  Created by HuyPQ on 2019/04/19.
//  Copyright © 2019 fujitsu. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    class var identifier: String {
        return String(describing: self)
    }
}
