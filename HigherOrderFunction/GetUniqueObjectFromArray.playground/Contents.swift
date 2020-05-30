//: Playground - noun: a place where people can play

import UIKit

let text = "Silent Night Holy Night"
let words = text.lowercased().components(separatedBy: " ")
let countedSet = NSCountedSet(array: words)
print(countedSet)
let singleOccurrencies = countedSet.filter { countedSet.count(for: $0) == 1 }.compactMap { $0 as? String }
print(singleOccurrencies)
