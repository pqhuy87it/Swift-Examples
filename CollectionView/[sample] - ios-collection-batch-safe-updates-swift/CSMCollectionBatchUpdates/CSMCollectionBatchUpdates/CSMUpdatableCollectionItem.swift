//
//  CSMUpdatableCollectionItem.swift
//  CSMCollectionBatchUpdates
//
//  Created by Carlos Simon Villas on 11/04/16.
//  Copyright © 2016 Charlisim. All rights reserved.
//

import Foundation


public protocol CSMUpdatableCollectionItem {
    var uid:String { get set }
    var userInfo:[String:AnyObject] { get set }
}



public protocol CSMUpdatableCollectionSection:CSMUpdatableCollectionItem{
    var items:[CSMUpdatableCollectionItem] { get set }
}

