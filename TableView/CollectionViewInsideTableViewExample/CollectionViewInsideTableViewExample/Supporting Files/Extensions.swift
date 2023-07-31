//
//  Extensions.swift
//  CollectionViewInsideTableViewExample
//
//  Created by John Codeos on 12/21/19.
//  Copyright © 2019 John Codeos. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static func rgbColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1.0)
    }
    
    static func colorFromHex(_ hex: String) -> UIColor {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        if hexString.count != 6 {
            return UIColor.magenta
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)
        
        return UIColor(red: CGFloat((rgb & 0xFF0000) >> 16) / 255,
                       green: CGFloat((rgb & 0x00FF00) >> 8) / 255,
                       blue: CGFloat(rgb & 0x0000FF) / 255,
                       alpha: 1.0)
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

// MARK: - Response Identifier
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
