//
//  UnwrappableManager
//  UnwrappingPresents
//
//  Created by Valentin Kalchev on 04/08/2015.
//  Copyright © 2015 TriggertrapLtd. All rights reserved.
//

import UIKit

protocol ManagerLifecycle {
    func didFinishUnwrapping()
}

final class Manager {
    static let sharedInstance = Manager()
    
    var unwrappableDelegate: ManagerLifecycle?
    
    private let serialQueue = DispatchQueue.init(label: "Unwrappable Serial Queue", qos: .default)
    private var _canUnwrap: Bool
    
    internal var canUnwrap: Bool {
        return _canUnwrap
    }
    
    internal let semaphore = DispatchSemaphore(value: 3)
    
    private init() {
        _canUnwrap = true
    }
    
    func startUnwrapping(_ unwrappable: Unwrappable) {
        _canUnwrap = true
        var _unwrappable = unwrappable
        
        serialQueue.async {
            _unwrappable.unwrap({ success in
                if success {
                    print("Unwrapped all successfully")
                } else {
                    print("Failed to unwrap all")
                    
                    DispatchQueue.main.async {
                        self.unwrappableDelegate?.didFinishUnwrapping()
                    }
                }
            })
        }
    }
    
    func pauseUnwrapping() {
        _canUnwrap = false
    }
    
    func resumeUnwrapping() {
        // Resume the thread from where it was paused
        _canUnwrap = true
        semaphore.signal()
        semaphore.signal()
        semaphore.signal()
    }
    
    func suspendUnwrapping() {
        _canUnwrap = false
        // Release the semaphore if it is currently blocking a thread, canUnwrapPresent is false therefore it can't accidently continue unwrapping the sequence
        semaphore.signal()
        semaphore.signal()
        semaphore.signal()
    }
}
