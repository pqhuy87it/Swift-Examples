//
//  Present.swift
//  UnwrappingPresents
//
//  Created by Valentin Kalchev on 04/08/2015.
//  Copyright © 2015 TriggertrapLtd. All rights reserved.
//
import UIKit

struct Present: Unwrappable  {
    internal var completionHandler: CompletionHandler = { (success) -> Void in }
    
    mutating func unwrap(_ completionHandler: @escaping CompletionHandler) -> Void {
        self.completionHandler = completionHandler
        
        print("Will unwrap present")
        
        let checkQueue = DispatchQueue.init(label: "Check Serial Queue", qos: .default)
        
        // Check the presents for 1 seconds
        checkQueue.async {
            sleep(1)
            
            if Manager.sharedInstance.canUnwrap {
                Manager.sharedInstance.semaphore.signal()
            }
        }
        
        print("stuck")
        
        let _ = Manager.sharedInstance.semaphore.wait(timeout: .distantFuture)
        
        print("no stuck")
        
        self.completionHandler(true)
    }
}
