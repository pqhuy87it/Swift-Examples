//: Playground - noun: a place where people can play

import UIKit

protocol CanAddOne {
    func addOne() -> Self
}
extension Int: CanAddOne {
    func addOne() -> Int {
        return self + 1
    }
}
extension String: CanAddOne {
    func addOne() -> String {
        return self + "1"
    }
}

func incrementBetter<T: CanAddOne>(_ foo: T) -> T {
    return foo.addOne()
}
incrementBetter("foo")
incrementBetter(1)
//incrementBetter(1.0) // <== compile error

protocol Furniture {
    associatedtype M
    func mainMaterial() -> M
    func secondaryMaterial() -> M
}

struct Chair: Furniture {
    func mainMaterial() -> String {
        return "Wood"
    }
    func secondaryMaterial() -> String {
        return "More wood"
    }
}
struct Lamp: Furniture {
    func mainMaterial() -> Bool {
        return true
    }
    
    func secondaryMaterial() -> Bool {
        return true
    }
}

// <<< does not conform to Furniture
/*
struct Stool: Furniture {
    func mainMaterial() -> String {
        return "Wood"
    }
    func secondaryMaterial() -> Bool {
        return false
    }
}
*/

protocol Material {}
struct Wood: Material {}
struct Glass: Material {}
struct Metal: Material {}
struct Cotton: Material {}

protocol Furniture_ {
    associatedtype M: Material
    func mainMaterial() -> M
    func secondaryMaterial() -> M
}

struct Chair_: Furniture_ {
    func mainMaterial() -> Wood {
        return Wood()
    }
    func secondaryMaterial() -> Wood {
        return Wood()
    }
}

protocol Furniture2 {
    associatedtype M: Material
    associatedtype M2: Material
    func mainMaterial() -> M
    func secondaryMaterial() -> M2
}

// <<< does not conform to Furniture
/*
struct Chair2: Furniture2 {
    func mainMaterial() -> Material {
        return Wood()
    }
    func secondaryMaterial() -> Material {
        return Wood()
    }
}
*/

protocol HouseholdThing { }
protocol Furniture3: HouseholdThing {
    associatedtype M: Material
    associatedtype M2: Material
    associatedtype T: HouseholdThing
    func mainMaterial() -> M
    func secondaryMaterial() -> M2
    static func factory() -> T
}

struct Chair3: Furniture3 {
    func mainMaterial() -> Wood {
        return Wood()
    }
    func secondaryMaterial() -> Cotton {
        return Cotton()
    }
    static func factory() -> Chair3 {
        return Chair3()
    }
}

struct Lamp3: Furniture3 {
    func mainMaterial() -> Glass {
        return Glass()
    }
    func secondaryMaterial() -> Glass {
        return Glass()
    }
    static func factory() -> Chair3 {
        return Chair3()
    }
}

protocol Furniture4 {
    associatedtype M: Material
    associatedtype M2: Material
    func mainMaterial() -> M
    func secondaryMaterial() -> M2
    static func factory() -> Self
}
