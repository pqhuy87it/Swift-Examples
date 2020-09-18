//
//  UITableView+Extension.swift
//  YuuchoBanking
//
//  Created by HuyPQ on 2019/04/19.
//  Copyright © 2019 fujitsu. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func registerCellByNib<T: UITableViewCell>(_ type: T.Type) {
        register(type.nib, forCellReuseIdentifier: type.identifier)
    }
    
    func dequeueCell<T: UITableViewCell>(_ type: T.Type, forIndexPath indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T
    }
    
    func dequeueCell<T: UITableViewCell>(_ type: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier) as? T
    }
    
    func reloadData(withAnimation animation: UITableView.RowAnimation) {
        self.reloadSections(IndexSet(integersIn: 0..<numberOfSections), with: animation)
    }
}
