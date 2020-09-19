//
//  CollectionViewCell.swift
//  LoadCustomViewContainTableView
//
//  Created by Exlinct on 8/25/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCellWithData(_ data: String) {
        self.dataLabel.text = data
    }
}
