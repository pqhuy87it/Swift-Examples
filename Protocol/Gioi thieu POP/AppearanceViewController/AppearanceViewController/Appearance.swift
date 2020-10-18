//
//  Appearance.swift
//  AppearanceViewController
//
//  Created by Huy Pham on 6/30/17.
//  Copyright © 2017 Huy Pham. All rights reserved.
//

import Foundation
import UIKit

struct Appearance {
    struct Bar {
        var style: UIBarStyle = .default
        var backgroundColor = UIColor(red: 234/255, green: 46/255, blue: 73/255, alpha: 1.0)
        var tintColor = UIColor.white
        var barTintColor: UIColor?
    }
    
    var statusBarStyle: UIStatusBarStyle = .default
    var navigationBar = Bar()
}
