//
//  PeriodicService.swift
//  QOS_Multithreading_Timer
//
//  Created by Pham Quang Huy on 2023/04/01.
//

import Foundation

class PeriodicService {
    private var timer: DispatchSourceTimer?
    
    func start() {
        let queue = DispatchQueue(label: Bundle.main.bundleIdentifier! + ".timer.utility", qos: .utility)
        let timer = DispatchSource.makeTimerSource(queue: queue)
        timer.setEventHandler { [weak self] in
            self?.someSlowSynchronousTask()
        }
        timer.schedule(deadline: .now(), repeating: 30)
        timer.resume()
        self.timer = timer
    }
    
    func cancel() {
        timer?.cancel()
        timer = nil
    }
    
    func someSlowSynchronousTask() {
        print("Do something...")
    }
}
