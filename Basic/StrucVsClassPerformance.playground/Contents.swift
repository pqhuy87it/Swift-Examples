import UIKit

var str = "Hello, playground"

// 1 field
class IntClass {
    var value: Int
    init(_ val: Int) { self.value = val }
}

struct IntStruct {
    var value: Int
    init(_ val: Int) { self.value = val }
}

func + (x: IntClass, y: IntClass) -> IntClass {
    return IntClass(x.value + y.value)
}

func + (x: IntStruct, y: IntStruct) -> IntStruct {
    return IntStruct(x.value + y.value)
}

// 10 fields
class Int10Class {
    var value1, value2, value3, value4, value5, value6, value7, value8, value9, value10: Int

    init(_ val: Int) {
        self.value1 = val
        self.value2 = val
        self.value3 = val
        self.value4 = val
        self.value5 = val
        self.value6 = val
        self.value7 = val
        self.value8 = val
        self.value9 = val
        self.value10 = val
    }
}

struct Int10Struct {
    var value1, value2, value3, value4, value5, value6, value7, value8, value9, value10: Int

    init(_ val: Int) {
        self.value1 = val
        self.value2 = val
        self.value3 = val
        self.value4 = val
        self.value5 = val
        self.value6 = val
        self.value7 = val
        self.value8 = val
        self.value9 = val
        self.value10 = val
    }
}

func + (x: Int10Struct, y: Int10Struct) -> Int10Struct {
    return Int10Struct(x.value1 + y.value1)
}

func + (x: Int10Class, y: Int10Class) -> Int10Class {
    return Int10Class(x.value1 + y.value1)
}

class Tests {
    static func runTests() {
        measure(name: "class (1 field)") {
            var x = IntClass(0)
            for _ in 1...10000 {
                x = x + IntClass(1)
            }
        }

        measure(name: "struct (1 field)") {
            var x = IntStruct(0)
            for _ in 1...10000 {
                x = x + IntStruct(1)
            }
        }

        measure(name: "class (10 fields)") {
            var x = Int10Class(0)
            for _ in 1...10000 {
                x = x + Int10Class(1)
            }
        }

        measure(name: "struct (10 fields)") {
            var x = Int10Struct(0)
            for _ in 1...10000 {
                x = x + Int10Struct(1)
            }
        }
    }

    static private func measure(name: String, block: () -> ()) {
        let t0 = CACurrentMediaTime()

        block()

        let dt = CACurrentMediaTime() - t0
        print("\(name) -> \(dt)")
    }
}

Tests.runTests()
