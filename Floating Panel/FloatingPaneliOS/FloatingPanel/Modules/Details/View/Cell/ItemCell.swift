//
//  ItemCell.swift
//  FloatingPanel
//
//  Created by Azhar Ragab on 06/02/2023.
//

import Foundation
import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var itemName: UILabel!

    func configure(with item: ItemEntity) {
        itemName.text = item.name
        itemName.layer.borderWidth = 0.8
        itemName.layer.borderColor = UIColor.lightGray.cgColor
        itemName.layer.cornerRadius = 8

    }
}
