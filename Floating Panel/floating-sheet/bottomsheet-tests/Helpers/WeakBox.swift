//
//  WeakBox.swift
//  bottomsheet-tests
//
//  Created by Vladislav Maltsev on 04.07.2022.
//

import Foundation

struct WeakBox<T: AnyObject> {
    weak var value: T?

    init(value: T) {
        self.value = value
    }
}
