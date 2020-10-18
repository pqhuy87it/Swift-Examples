//: Playground - noun: a place where people can play

import UIKit

protocol FlyingCapability {
    func fly()
}

extension FlyingCapability {
    func fly() {
        print("I can fly")
    }
}

class Thor {
    
}

extension Thor : FlyingCapability {
    func fly() {
        //cant say super.fly()
        //super.fly()
    }
}

