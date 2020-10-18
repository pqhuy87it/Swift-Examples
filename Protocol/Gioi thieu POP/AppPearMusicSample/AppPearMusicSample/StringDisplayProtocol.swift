//
//  StringDisplayProtocol.swift
//  AppPearMusicSample
//
//  Created by Pham Quang Huy on 8/7/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import Foundation
import UIKit

protocol StringDisplay {
    var containerSize: CGSize { get }
    var containerFont: UIFont { get }
    func assignString(_ str: String)
}

extension StringDisplay {
    func displayStringValue(obj: StringRepresentable) {
        // Determine the longest string which can fit within the containerSize, then assign it.
        if self.stringWithin(obj.longString) {
            self.assignString(obj.longString)
        } else if self.stringWithin(obj.mediumString) {
            self.assignString(obj.mediumString)
        } else {
            self.assignString(obj.shortString)
        }
    }
    
    // pragma mark - Helper Methods
    
    func sizeWithString(_ str: String) -> CGSize {
        return (str as NSString).boundingRect(with: CGSize(width: self.containerSize.width, height: .greatestFiniteMagnitude),
                                                    options: .usesLineFragmentOrigin,
                                                    attributes:  [NSAttributedString.Key.font: self.containerFont],
                                                    context: nil).size
    }
    
    private func stringWithin(_ str: String) -> Bool {
        return self.sizeWithString(str).height <= self.containerSize.height
    }
}
