//
//  UITableView.swift
//  ExtendedTableCollection
//
//  Created by Basem Emara on 4/23/16.
//  Copyright © 2016 Zamzam Inc. All rights reserved.
//

import UIKit

public extension UITableView {

    static var defaultCellIdentifier: String {
        return "Cell"
    }
    
    /**
     Register NIB to table view. NIB name and cell reuse identifier can match for convenience.

     - parameter nibName: Name of the NIB.
     - parameter cellIdentifier: Name of the reusable cell identifier.
     - parameter bundleIdentifier: Name of the bundle identifier if not local.
     */
    func registerNib(nibName: String, cellIdentifier: String = defaultCellIdentifier, bundleIdentifier: String? = nil) {
        self.register(UINib(nibName: nibName,
                               bundle: bundleIdentifier != nil ? Bundle(identifier: bundleIdentifier!) : nil),
            forCellReuseIdentifier: cellIdentifier)
    }

    /**
     Gets the reusable cell with default identifier name.

     - parameter indexPath: The index path of the cell from the table.

     - returns: Returns the table view cell.
     */
    subscript(indexPath: IndexPath) -> UITableViewCell {
        return self.dequeueReusableCell(withIdentifier: UITableView.defaultCellIdentifier, for: indexPath)
    }

    /**
     Gets the reusable cell with the specified identifier name.

     - parameter indexPath: The index path of the cell from the table.
     - parameter identifier: Name of the reusable cell identifier.

     - returns: Returns the table view cell.
     */
    subscript(indexPath: IndexPath, identifier: String) -> UITableViewCell {
        return self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }

}
