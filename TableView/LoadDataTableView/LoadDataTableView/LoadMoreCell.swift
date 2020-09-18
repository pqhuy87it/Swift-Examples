//
//  LoadMoreCell.swift
//  LoadDataTableView
//
//  Created by Pham Quang Huy on 7/15/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import UIKit

class LoadMoreCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.hidesWhenStopped = true
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
