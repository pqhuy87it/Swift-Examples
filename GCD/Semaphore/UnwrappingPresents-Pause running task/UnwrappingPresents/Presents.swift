//
//  Presents.swift
//  UnwrappingPresents
//
//  Created by Valentin Kalchev on 04/08/2015.
//  Copyright © 2015 TriggertrapLtd. All rights reserved.
//

struct Presents: Unwrappable {
    
    private var unwrappables = [Unwrappable]()
    private var currentUnwrappable = 0
    
    var completionHandler: CompletionHandler = { (success) -> Void in }
    
    init(unwrappables: [Unwrappable]) {
        self.unwrappables = unwrappables
    }
    
    mutating func unwrap(_ completionHandler: @escaping CompletionHandler) -> Void {
        self.completionHandler = completionHandler
        self.currentUnwrappable = 0
        
        print("Will unwrap presents")
        unwrapCurrentUnwrappable()
    } 
    
    private mutating func unwrapCurrentUnwrappable() {
        var result = self
        
        if currentUnwrappable > self.unwrappables.count - 1 {
            print("Did unwrap presents")
            self.completionHandler(true)
        } else {
            unwrappables[currentUnwrappable].unwrap({ (success) -> Void in
                if success {
                    result.nextUnwrappable()
                } else {
                    result.completionHandler(false)
                }
            })
        }
    }
    
    private mutating func nextUnwrappable() {
        self.currentUnwrappable += 1
        
        if Manager.sharedInstance.canUnwrap {
            self.unwrapCurrentUnwrappable()
        } else {
            self.completionHandler(false)
        }
    }
}
