//: Playground - noun: a place where people can play

import UIKit

var arrayContainDuplicate = [
    ["a1","b1"],
    ["a1","b2"],
    ["a2","b3"],
    ["a2","b4"],
    ["a1","b5"],
    ["a3","b6"]
]

extension Array where  Element: Hashable {
    func unique() -> [Element] {
        var seen: [Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}

var seen: [String: Bool] = [:]

let uniqueArray = arrayContainDuplicate.filter {
    seen.updateValue(true, forKey: $0[0]) == nil
}

print(uniqueArray)

