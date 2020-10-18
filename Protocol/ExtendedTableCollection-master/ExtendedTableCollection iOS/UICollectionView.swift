//
//  UICollectionView.swift
//  ExtendedTableCollection
//
//  Created by Basem Emara on 4/23/16.
//  Copyright © 2016 Zamzam Inc. All rights reserved.
//

import UIKit

public extension UICollectionView {

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
            forCellWithReuseIdentifier: cellIdentifier)
    }

    /**
     Gets the reusable cell with default identifier name.

     - parameter indexPath: The index path of the cell from the collection.

     - returns: Returns the collection view cell.
     */
    subscript(indexPath: NSIndexPath) -> UICollectionViewCell {
        return self.dequeueReusableCell(withReuseIdentifier: UICollectionView.defaultCellIdentifier, for: indexPath as IndexPath)
    }

    /**
     Gets the reusable cell with the specified identifier name.

     - parameter indexPath: The index path of the cell from the collection.
     - parameter identifier: Name of the reusable cell identifier.

     - returns: Returns the collection view cell.
     */
    subscript(indexPath: IndexPath, identifier: String) -> UICollectionViewCell {
        return self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }

}
