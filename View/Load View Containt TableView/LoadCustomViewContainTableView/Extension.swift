//
//  Extension.swift
//  LoadCustomViewContainTableView
//
//  Created by Exlinct on 8/21/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import UIKit

protocol Reusable: class {
    
    static var yep_reuseIdentifier: String { get }
}

protocol NibLoadable {
    
    static var yep_nibName: String { get }
}

extension UIView {
    class func fromNib() -> UIView? {
        return Bundle(for: self).loadNibNamed(String(describing: self), owner: nil, options: nil)?.first as? UIView
    }
}

extension UITableView {
    
     func registerCellByNib<T: UITableViewCell>(_ type: T.Type) {
           register(type.nib, forCellReuseIdentifier: type.identifier)
       }

       func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ type: T.Type) {
           register(type.nib, forHeaderFooterViewReuseIdentifier: type.identifier)
       }

       func dequeueCell<T: UITableViewCell>(_ type: T.Type, forIndexPath indexPath: IndexPath) -> T? {
           return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T
       }

       func dequeueCell<T: UITableViewCell>(_ type: T.Type) -> T? {
           return dequeueReusableCell(withIdentifier: type.identifier) as? T
       }

       func dequeueHeaderFooter<T: UITableViewHeaderFooterView>(_ type: T.Type) -> T? {
           return dequeueReusableHeaderFooterView(withIdentifier: type.identifier) as? T
       }

       func reloadData(withAnimation animation: UITableView.RowAnimation) {
           self.reloadSections(IndexSet(integersIn: 0..<numberOfSections), with: animation)
       }
}

extension UITableViewCell {
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    class var identifier: String {
        return String(describing: self)
    }
}

protocol ResponseIdentifier {}

extension ResponseIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}

extension NSObject: ResponseIdentifier {}

extension UITableViewHeaderFooterView {
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

