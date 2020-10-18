//
//  Styled.swift
//  AppMusic
//
//  Created by Pham Quang Huy on 8/20/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import Foundation
import UIKit

protocol Styled {
    func updateStyles()
}

protocol BackgroundColor: Styled {
    var color: UIColor { get }
}

protocol FontWeight: Styled {
    var size: CGFloat { get }
    var bold: Bool { get }
}

protocol BackgroundColor_Blue: BackgroundColor {
    
}

extension BackgroundColor_Blue {
    var color: UIColor {
        return UIColor.blue
    }
}

protocol FontWeight_H1: FontWeight {
    
}

extension FontWeight_H1 {
    var size: CGFloat {
        return 18.0
    }
    
    var bold: Bool {
        return true
    }
}

extension UITableViewCell: Styled {
    func updateStyles() {
        if let backgroundColor = self as? BackgroundColor {
            self.backgroundColor = backgroundColor.color
        }
        
        if let fontWeight = self as? FontWeight {
            self.textLabel?.font = fontWeight.bold ? UIFont.boldSystemFont(ofSize: fontWeight.size) : UIFont.systemFont(ofSize: fontWeight.size)
        }
        
        if let cell = self as? AlbumTableViewCell {
            cell.albumNameLabel.font = cell.bold ? UIFont.boldSystemFont(ofSize: cell.size) : UIFont.systemFont(ofSize: cell.size)
        }
    }
}

