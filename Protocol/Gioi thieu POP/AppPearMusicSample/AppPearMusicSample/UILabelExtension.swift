//
//  UILabelExtension.swift
//  AppPearMusicSample
//
//  Created by Pham Quang Huy on 8/7/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import Foundation
import UIKit

extension UILabel : StringDisplay {
    var containerSize: CGSize {
        return self.frame.size
    }
    
    var containerFont: UIFont {
        return self.font
    }
    
    func assignString(_ str: String) {
        self.text = str
    }
}
