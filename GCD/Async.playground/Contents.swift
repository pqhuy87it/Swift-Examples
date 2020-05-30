import UIKit
import Foundation
import PlaygroundSupport

var str = "Hello, playground"

PlaygroundPage.current.needsIndefiniteExecution = true

class Worker {
    
    private let queue = DispatchQueue.global(qos: .background)
    private let serialQueue = DispatchQueue(label: "com.acme.serial")
    public private(set) var count = 0
    
    func incrementCount() {
        serialQueue.sync {
            count += 1
        }
    }
    
    func work() {
        queue.async { [weak self] in
            guard let s = self else { return }
            s.incrementCount()
            print("🔵 Work [\(s.count)]")
        }
    }
    
}

let worker = Worker()

(0..<100).forEach { _ in
    worker.work()
    print("🔴 Done [\(worker.count)]")
}

let queue1 = DispatchQueue(label: "com.acme.queue1", attributes: .concurrent)
let queue2 = DispatchQueue(label: "com.acme.queue2", attributes: .concurrent)
let queue3 = DispatchQueue(label: "com.acme.queue3", attributes: .concurrent)
let range = 0..<5

queue1.async {
    range.forEach { _ in
        worker.work()
        print("🔴 Done [\(worker.count)]")
    }
}

queue2.async {
    range.forEach { _ in
        worker.work()
        print("🔴 Done [\(worker.count)]")
    }
}

queue3.async {
    range.forEach { _ in
        worker.work()
        print("🔴 Done [\(worker.count)]")
    }
}
