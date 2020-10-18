//
//  Associator.swift
//  STP
//
//  Created by Chris O'Neil on 10/11/15.
//  Copyright © 2015 Because. All rights reserved.
//

import ObjectiveC

private final class Wrapper<T> {
    let value: T
    init(_ x: T) {
        value = x
    }
}

class Associator {

    static private func wrap<T>(_ x: T) -> Wrapper<T>  {
        return Wrapper(x)
    }

    static func setAssociatedObject<T>(_ object: AnyObject, value: T, associativeKey: UnsafeRawPointer, policy: objc_AssociationPolicy) {
        if let v = value as AnyObject? {
            objc_setAssociatedObject(object, associativeKey, v,  policy)
        }
        else {
            objc_setAssociatedObject(object, associativeKey, wrap(value),  policy)
        }
    }

    static func getAssociatedObject<T>(_ object: AnyObject, associativeKey: UnsafeRawPointer) -> T? {
        if let v = objc_getAssociatedObject(object, associativeKey) as? T {
            return v
        }
        else if let v = objc_getAssociatedObject(object, associativeKey) as? Wrapper<T> {
            return v.value
        }
        else {
            return nil
        }
    }
}
