import UIKit

var str = "Hello, playground"

func performUsingGroup() {
    let dq1 = DispatchQueue.global(qos: .default)
    let dq2 = DispatchQueue.global(qos: .default)
    let group = DispatchGroup()

    for i in 1...3 {
        group.enter()
        dq1.async {
            print("\(#function) DispatchQueue 1: \(i)")
            group.leave()
        }
    }
    for i in 1...3 {
        group.enter()
        dq2.async {
            print("\(#function) DispatchQueue 2: \(i)")
            group.leave()
        }
    }

    group.notify(queue: DispatchQueue.main) {
        print("done by group")
    }
}

func performUsingSemaphore() {
    let dq1 = DispatchQueue.global(qos: .default)
    let dq2 = DispatchQueue.global(qos: .default)
    let semaphore = DispatchSemaphore(value: 1)

    for i in 1...3 {
        dq1.async {
            _ = semaphore.wait(timeout: DispatchTime.distantFuture)
            print("\(#function) DispatchQueue 1: \(i)")
            semaphore.signal()
        }
    }
    for i in 1...3 {
        dq2.async {
            _ = semaphore.wait(timeout: DispatchTime.distantFuture)
            print("\(#function) DispatchQueue 2: \(i)")
            semaphore.signal()
        }
    }
}

performUsingGroup()
performUsingSemaphore()
