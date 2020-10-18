//: Playground - noun: a place where people can play

import UIKit

protocol ProtocolA {
    func doMethodA()
}

extension ProtocolA {
    func doMethodA() {
        print("do method A ... ")
    }
}

protocol ProtocolB: ProtocolA {
    func doMethodB()
}

extension ProtocolB {
    func doMethodB() {
        print("do method b")
        doMethodA()
    }
}

class SomeClassB: ProtocolB {
    
}

class SomeClassA: ProtocolA {
    
}

extension ProtocolB where Self: SomeClassB {
    func doSomeMethod() {
        doMethodB()
    }
}

let someClass = SomeClassB()
someClass.doSomeMethod()
someClass.doMethodB()
someClass.doMethodA()

let someClassA = SomeClassA()
someClassA.doMethodA()