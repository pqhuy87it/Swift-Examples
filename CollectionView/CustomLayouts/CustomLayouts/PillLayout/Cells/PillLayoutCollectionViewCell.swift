//
//  PillLayoutCollectionViewCell.swift
//  CustomLayouts
//
//  Created by Pramod Manjunath on 17/10/19.
//  Copyright © 2019 Pramod Manjunath. All rights reserved.
//

import UIKit

class PillLayoutCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelText: UILabel!
    
    static let pillHeight: CGFloat = 40.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setLabel(_ text: String?) {
        self.labelText.text = text
    }
}

private extension PillLayoutCollectionViewCell {
    
    func setupView() {
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = PillLayoutCollectionViewCell.pillHeight / 2
    }
}
