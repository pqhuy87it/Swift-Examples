//
//  NoDataView.swift
//  LoadDataTableView
//
//  Created by Pham Quang Huy on 7/15/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import UIKit

class NoDataView: UIView {
    open var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        self.setConstraints()
    }
    
    override func didMoveToSuperview() {
        
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let uiview = super.hitTest(point, with: event)
        
        if uiview == self {
            return nil
        }
        
        return uiview
    }
    
    func setConstraints() {
        let centerX = NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
        let centerY = NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        NSLayoutConstraint.activate([centerX, centerY])
    }
}
