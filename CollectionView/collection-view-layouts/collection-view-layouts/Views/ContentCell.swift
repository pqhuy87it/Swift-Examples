//
//  ContentCell.swift
//  collection_view_test
//
//  Created by sergey on 2/12/18.
//  Copyright © 2018 rubygarage. All rights reserved.
//

import UIKit

class ContentCell: UICollectionViewCell {
    @IBOutlet private(set) weak var contentLabel: UILabel!
    
    func populate(with item: String) {
        contentLabel.text = item
        
        backgroundColor = UIColor.random().withAlphaComponent(0.5)
    }
}
