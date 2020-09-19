//
//  CustomView.swift
//  LoadViewFromNib
//
//  Created by Exlinct on 8/20/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import UIKit

class CustomView: UIView {
    static let height: CGFloat = 100.0
    weak var bottomConstraint: NSLayoutConstraint?
    
    func show() {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: { [weak self] in
            self?.bottomConstraint?.constant = 0
            self?.superview?.layoutIfNeeded()
            }, completion: { _ in })
    }
    
    func hide() {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: { [weak self] in
            self?.bottomConstraint?.constant = CustomView.height
            self?.superview?.layoutIfNeeded()
            }, completion: { _ in })
    }
}
