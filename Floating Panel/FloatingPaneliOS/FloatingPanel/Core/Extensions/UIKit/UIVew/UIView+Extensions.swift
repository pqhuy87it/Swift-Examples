//
//  UIView+Extensions.swift
//  FloatingPanel
//
//  Created by Azhar Ragab on 07/02/2023.
//

import Foundation
import UIKit

extension UIView {

    func makeCorner(withRadius radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.isOpaque = false
    }
}
