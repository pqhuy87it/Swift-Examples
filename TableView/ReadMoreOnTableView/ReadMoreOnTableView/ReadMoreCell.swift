//
//  ReadMoreCell.swift
//  ReadMoreOnTableView
//
//  Created by Huy Pham on 9/8/17.
//  Copyright © 2017 Huy Pham. All rights reserved.
//

import UIKit

class ReadMoreCell: UITableViewCell {

    @IBOutlet weak var messageLabel: TTTAttributedLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
