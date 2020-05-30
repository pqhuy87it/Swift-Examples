//: Playground - noun: a place where people can play

import UIKit

var str: String?
defer {
    print("In defer block")
    if let s = str {
        print("str is \(s)")
    }
}
str = "Jon"
print("Function finished")