//
//  SQLiteDataStore.swift
//  TestSqliteSwiftV2
//
//  Created by Jon Hoffman on 7/28/15.
//  Copyright © 2015 Jon Hoffman. All rights reserved.
//

import Foundation
import SQLite


enum DataAccessError: ErrorType {
    case Datastore_Connection_Error
    case Insert_Error
    case Delete_Error
    case Search_Error
    case Nil_In_Data
}



class SQLiteDataStore {
    static let sharedInstance = SQLiteDataStore()
    let BBDB: Connection?
    
    private init() {
        
        var path = "BaseballDB.sqlite"
        
        if let dirs: [NSString] =
            NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,
            NSSearchPathDomainMask.AllDomainsMask, true) as [NSString] {
                
             let dir = dirs[0]
             path = dir.stringByAppendingPathComponent("BaseballDB.sqlite");
             print(path)
        }
        
        do {
            BBDB = try Connection(path)
        } catch _ {
            BBDB = nil 
        }
    }
    
    func createTables() throws{
        do {
            try TeamDataHelper.createTable()
            try PlayerDataHelper.createTable()
        } catch {
            throw DataAccessError.Datastore_Connection_Error
        }
        
    } 
}

