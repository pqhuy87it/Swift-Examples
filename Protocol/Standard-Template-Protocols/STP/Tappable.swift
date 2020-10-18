//
//  Tappable.swift
//  STP
//
//  Created by Chris O'Neil on 10/11/15.
//  Copyright © 2015 Because. All rights reserved.
//

import UIKit

public protocol Tappable {
    func makeTappable()
    func didTap()
    func didTouchDown()
    func didTouchUp()
    func minimumPressDuration() -> TimeInterval
    func allowableMovement() -> CGFloat
}

public extension Tappable where Self:UIView {

    func makeTappable() {

        let gestureRecognizer = UILongPressGestureRecognizer { [unowned self] (recognizer) -> Void in
            let tap = recognizer as! UILongPressGestureRecognizer

            func isInFrame() -> Bool {
                return self.frame.insetBy(dx: self.frame.width * -0.5, dy: self.frame.height * -0.5).contains(
                    recognizer.location(in: self)
                )
            }

            switch tap.state {
                case .began:
                self.didTouchDown()
                case .ended:
                self.didTouchUp()
                if isInFrame() {
                    self.didTap()
                }
                case .failed, .cancelled:
                self.didTouchUp()
                case .changed:
                if isInFrame() {
                    self.didTouchDown()
                } else {
                    self.didTouchUp()
                }
                case .possible:
                    break
                @unknown default:
                fatalError()
            }
        }

        gestureRecognizer.minimumPressDuration = self.minimumPressDuration()
        gestureRecognizer.allowableMovement = self.allowableMovement()
        self.addGestureRecognizer(gestureRecognizer)
    }

    func didTap() {
        return
    }

    func didTouchDown() {
        self.alpha = 0.5
    }

    func didTouchUp() {
        self.alpha = 1.0
    }

    func minimumPressDuration() -> TimeInterval {
        return 0.001
    }

    func allowableMovement() -> CGFloat {
        return 10.0
    }
}
