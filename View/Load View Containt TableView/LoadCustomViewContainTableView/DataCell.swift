//
//  DataCell.swift
//  LoadCustomViewContainTableView
//
//  Created by Exlinct on 8/21/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import UIKit

class DataCell: UITableViewCell {

    @IBOutlet weak var dataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
