//
//  StringRepresentableProtocol.swift
//  AppPearMusicSample
//
//  Created by Pham Quang Huy on 8/7/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import Foundation

// Any entity which can be represented as a string of varying lengths.
protocol StringRepresentable {
    var shortString: String { get }
    var mediumString: String { get }
    var longString: String { get }
}

// Bonus: Make sure StringRepresentable adopters are printed descriptively to the console.
extension NSObjectProtocol where Self: StringRepresentable {
    var description: String {
        return self.longString
    }
}

extension StringRepresentable where Self: Artist {
    var shortString: String {
        return self.name
    }
    
    var mediumString: String {
        return String(format: "%@ (%@)", self.name, self.instrument)
    }
    
    var longString: String {
        return String(format: "%@ (%@), %@", self.name, self.instrument, self.bio)
    }
}

