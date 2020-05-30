import UIKit
import PlaygroundSupport
import Foundation

var str = "Hello, playground"

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
        let semaphore = DispatchSemaphore(value: 0)
        
        queue.async { [weak self] in
            guard let s = self else { return }
            s.incrementCount()
            print("🔵 Work [\(s.count)]")
            semaphore.signal()
        }
        
        semaphore.wait()
    }
    
}

let worker = Worker()

(0..<100).forEach { _ in
    worker.work()
    print("🔴 Done [\(worker.count)]")
}

PlaygroundPage.current.needsIndefiniteExecution = true
