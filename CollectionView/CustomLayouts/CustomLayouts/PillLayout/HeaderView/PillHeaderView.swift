//
//  PillHeaderView.swift
//  CustomLayouts
//
//  Created by Pramod Manjunath on 17/10/19.
//  Copyright © 2019 Pramod Manjunath. All rights reserved.
//

import UIKit

class PillHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var headerLabel: UILabel!
    
    func setupLabel(_ text: String) {
        self.headerLabel.text = text
    }
}
