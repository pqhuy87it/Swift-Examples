//
//  UniqueProtocol.swift
//  AppPearMusicSample
//
//  Created by Pham Quang Huy on 8/7/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import Foundation
import UIKit

protocol Unique {
    var id: String! { get set }
}

extension Unique where Self: NSObject {
    // Built-in init method from a protocol!
    init(id: String?) {
        self.init()
        if let identifier = id {
            self.id = identifier
        } else {
            self.id = NSUUID().uuidString
        }
    }
}

// Bonus: Make sure Unique adopters are comparable.
func ==(lhs: Unique, rhs: Unique) -> Bool {
    return lhs.id == rhs.id
}
extension NSObjectProtocol where Self: Unique {
    func isEqual(object: AnyObject?) -> Bool {
        if let o = object as? Unique {
            return o.id == self.id
        }
        return false
    }
}
