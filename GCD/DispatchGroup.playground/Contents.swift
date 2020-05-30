//: Playground - noun: a place where people can play

import UIKit

func run(after seconds: Int, closure: @escaping () -> Void) {
    let time = DispatchTime.now() + DispatchTimeInterval.seconds(seconds)
    let queue = DispatchQueue(label: "com.example.runqueue")
    queue.asyncAfter(deadline: time, qos: .background, flags: .inheritQoS) {
        closure()
    }
}

let group = DispatchGroup()

group.enter()
run(after: 6) {
    print("Hello after 6 seconds")
    group.leave()
}

group.enter()
run(after: 4) {
    print("Hello after 4 seconds")
    group.leave()
}

group.enter()
run(after: 2) {
    print("Hello after 2 seconds")
    group.leave()
}

group.enter()
run(after: 1) {
    print("Hello after 1 second")
    group.leave()
}

group.notify(queue: DispatchQueue.global(qos: .background)) {
    print("All async calls were run!")
}
