//: Playground - noun: a place where people can play

import UIKit

extension Array {
    func contains<T>(obj: T) -> Bool where T : Equatable {
        return self.filter({$0 as? T == obj}).count > 0
    }
}

struct Object {
    var id: Int
    var name: String
}

extension Object: Equatable { }

func ==(lhs: Object, rhs: Object) -> Bool {
    return lhs.id == rhs.id && lhs.name == rhs.name
}

let a = Object(id: 1, name: "object a")
let b = Object(id: 2, name: "object b")
let c = Object(id: 1, name: "object a")

a == b
a == c

var objects = [Object]()
objects.append(contentsOf: [a, b, c])

if objects.contains(a) {
    print("contain object a")
}
