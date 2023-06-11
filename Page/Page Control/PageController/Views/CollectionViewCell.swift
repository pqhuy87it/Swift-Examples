//
//  CollectionViewCell.swift
//  PageController
//
//  Created by Summit on 08/11/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        imageView.layer.cornerRadius = 14
    }
}
