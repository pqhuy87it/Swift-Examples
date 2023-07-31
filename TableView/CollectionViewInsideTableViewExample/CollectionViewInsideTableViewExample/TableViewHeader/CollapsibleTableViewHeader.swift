//
//  TableViewHeader.swift
//  CollectionViewInsideTableViewExample
//
//  Created by huy on 2023/05/29.
//  Copyright © 2023 John Codeos. All rights reserved.
//

import UIKit

protocol CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int)
}

class CollapsibleTableViewHeader: UITableViewHeaderFooterView {
    
    var delegate: CollapsibleTableViewHeaderDelegate?
    var section: Int = 0
    
    @IBAction func tableViewHeaderDidTap(_ sender: Any) {
        delegate?.toggleSection(self, section: self.section)
    }
    
}
