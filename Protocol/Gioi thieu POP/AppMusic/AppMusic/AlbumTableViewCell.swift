//
//  AlbumTableViewCell.swift
//  AppMusic
//
//  Created by Pham Quang Huy on 8/20/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell, BackgroundColor_Blue, FontWeight_H1 {

    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var trackCountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var copyRightLabel: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.updateStyles()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
