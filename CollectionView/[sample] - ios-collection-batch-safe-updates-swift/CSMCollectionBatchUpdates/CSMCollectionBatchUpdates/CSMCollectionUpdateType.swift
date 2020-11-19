//
//  CSMCollectionUpdateType.swift
//  CSMCollectionBatchUpdates
//
//  Created by Carlos Simon Villas on 11/04/16.
//  Copyright © 2016 Charlisim. All rights reserved.
//

import Foundation


public enum CSMCollectionUpdateType:Int{
    case Insert=0,
    Delete=1,
    Move=2,
    Reload=3
    
    public static func getString(type:CSMCollectionUpdateType)->String{
        switch type {
        case .Insert:
            return "insert"
        case .Delete:
            return "delete"
        case .Move:
            return "move"
        case .Reload:
            return "reload"
        }
    }
}