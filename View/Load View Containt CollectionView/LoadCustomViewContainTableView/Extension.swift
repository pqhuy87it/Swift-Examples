//
//  Extension.swift
//  LoadCustomViewContainTableView
//
//  Created by Exlinct on 8/21/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import UIKit

extension UIView {
    class func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)?[0] as! T
    }
}

protocol Reusable: AnyObject {
    
    static var defaultReuseIdentifier: String { get }
}

protocol NibLoadable {
    
    static var nibName: String { get }
}


extension UITableViewCell: Reusable {
    
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: NibLoadable {
    
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView: Reusable {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}


extension UITableView {
    
    func registerClassOf<T: UITableViewCell>(_: T.Type) {
        
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func registerNibOf<T: UITableViewCell>(_: T.Type) {
        
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func registerHeaderFooterClassOf<T: UITableViewHeaderFooterView>(_: T.Type) {
        
        register(T.self, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
    
    func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView>() -> T {
        
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.defaultReuseIdentifier) as? T else {
            fatalError("Could not dequeue HeaderFooter with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return view
    }
}

extension UICollectionViewCell: Reusable {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: NibLoadable {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    func registerClassOf<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func registerNibOf<T: UICollectionViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
}
