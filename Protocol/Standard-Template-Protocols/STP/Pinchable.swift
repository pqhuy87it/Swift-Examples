//
//  Pinchable.swift
//  Standard Template Protocols
//
//  Created by Chris O'Neil on 10/6/15.
//  Copyright © 2015 Because. All rights reserved.
//

import UIKit

public protocol Pinchable {
    func makePinchable()
    func didStartPinching()
    func didFinishPinching()
    func maximumPinchScale() -> CGFloat
    func minimumPinchScale() -> CGFloat
    func transformWithScale(_ scale:CGFloat, lastScale:CGFloat, velocity:CGFloat) -> CGAffineTransform
    func animateToPinchedTransform(_ transform:CGAffineTransform)
}

public extension Pinchable where Self:UIView {

    func makePinchable() {

        var lastScale:CGFloat = 1.0
        let gestureRecognizer = UIPinchGestureRecognizer { [unowned self] (recognizer) -> Void in
            let pinch = recognizer as! UIPinchGestureRecognizer
            switch pinch.state {
                case .began:
                self.didStartPinching()
                case .ended:
                self.didFinishPinching()
                lastScale = 1.0
                case .changed:
                let scale = pinch.scale
                let velocity = pinch.velocity
                let transform = self.transformWithScale(scale, lastScale: lastScale, velocity:velocity)
                lastScale = scale
                self.animateToPinchedTransform(transform)
            default:
                break
            }
        }
        self.addGestureRecognizer(gestureRecognizer)
    }

    func didStartPinching() {
        return
    }

    func didFinishPinching() {
        return
    }

    func maximumPinchScale() -> CGFloat {
        return 2.0
    }

    func minimumPinchScale() -> CGFloat {
        return 0.1
    }

    func transformWithScale(_ scale: CGFloat, lastScale: CGFloat, velocity: CGFloat) -> CGAffineTransform {
        let updatedScale = 1.0 - (lastScale - scale)
        return self.transform.scaledBy(x: updatedScale, y: updatedScale)
    }

    func animateToPinchedTransform(_ transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.01) { () -> Void in
            self.transform = transform
        }
    }
}
