//
//  CSMCollectionItemUpdate.swift
//  CSMCollectionBatchUpdates
//
//  Created by Carlos Simon Villas on 11/04/16.
//  Copyright © 2016 Charlisim. All rights reserved.
//

import Foundation


class CSMCollectionItemUpdate:CSMCollectionUpdate{
    var indexPath: IndexPath?
    var indexPathNew: IndexPath?
    override var itemUpdate: Bool {
        get{
            return true
        }
    }
    static func updateWithType(_ type:CSMCollectionUpdateType,
                               indexPath: IndexPath?,
                               newIndexPath: IndexPath?,
                               object: Any) -> Self {
        return self.init(withType: type,
                         object: object,
                         indexPath: indexPath,
                         newIndexPath: newIndexPath)
    }
    
    required init(withType type: CSMCollectionUpdateType,
                  object: Any,
                  indexPath: IndexPath?,
                  newIndexPath: IndexPath?) {
        self.indexPath = indexPath
        self.indexPathNew = newIndexPath
        super.init(withType: type, object: object)
        
    }
    
    
    
}
