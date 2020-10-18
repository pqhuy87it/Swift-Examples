//
//  AppearanceViewController.swift
//  AppearanceViewController
//
//  Created by Huy Pham on 6/30/17.
//  Copyright © 2017 Huy Pham. All rights reserved.
//

import Foundation
import UIKit

protocol AppearanceViewController: class {
    func navigationBarHidden() -> Bool
    func navigationControllerAppearance() -> Appearance?
}

extension AppearanceViewController {
    func navigationBarHidden() -> Bool {
        return false
    }
    
    func navigationControllerAppearance() -> Appearance? {
        return nil
    }
}
