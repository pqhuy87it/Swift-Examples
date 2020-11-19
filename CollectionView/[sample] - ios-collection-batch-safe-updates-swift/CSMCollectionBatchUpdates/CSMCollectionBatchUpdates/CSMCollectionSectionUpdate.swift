//
//  CSMCollectionSectionUpdate.swift
//  CSMCollectionBatchUpdates
//
//  Created by Carlos Simon Villas on 11/04/16.
//  Copyright © 2016 Charlisim. All rights reserved.
//

import Foundation


class CSMCollectionSectionUpdate:CSMCollectionUpdate{
    var sectionIndex:Int
    var sectionIndexNew:Int
    override var sectionUpdate:Bool{
        get{
            return true
        }
    }
    static func updateWithType(_ type:CSMCollectionUpdateType, sectionIndex:Int, newSectionIndex:Int, object:AnyObject){
        
    }
    
    private init(withType type: CSMCollectionUpdateType,
                          object: AnyObject,
                           sectionIndex:Int,
                           newSectionIndex:Int) {
        self.sectionIndex = sectionIndex
        self.sectionIndexNew = newSectionIndex
        super.init(withType: type, object: object)
        
    }
    
    
}
