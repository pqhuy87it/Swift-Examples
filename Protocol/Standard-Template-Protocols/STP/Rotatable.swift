//
//  Rotatable.swift
//  Standard Template Protocols
//
//  Created by Chris O'Neil on 10/6/15.
//  Copyright © 2015 Because. All rights reserved.
//

import UIKit

public protocol Rotatable {
    func makeRotatable()
    func didStartRotating()
    func didFinishRotating(_ velocity:CGFloat)
    func minimumRotation() -> CGFloat
    func maximumRotation() -> CGFloat
    func transformWithRotation(_ rotation:CGFloat, lastRotation:CGFloat, velocity:CGFloat) -> CGAffineTransform
    func animateToRotatedTransform(_ transform:CGAffineTransform)
}

public extension Rotatable where Self:UIView {

    func makeRotatable() {
        var lastRotation:CGFloat = 0.0
        let gestureRecognizer = UIRotationGestureRecognizer { [unowned self] (recognizer) -> Void in
            let rotation = recognizer as! UIRotationGestureRecognizer
            let velocity = rotation.velocity
            switch rotation.state {
                case .began:
                self.didStartRotating()
                lastRotation = 0.0
                case .ended:
                    self.didFinishRotating(velocity)
                case .changed:
                let transform = self.transformWithRotation(rotation.rotation, lastRotation: lastRotation, velocity:velocity)
                self.animateToRotatedTransform(transform)
                lastRotation = rotation.rotation
            default:
                break
            }
        }
        self.addGestureRecognizer(gestureRecognizer)
    }

    func transformWithRotation(_ rotation:CGFloat, lastRotation:CGFloat, velocity:CGFloat) -> CGAffineTransform {
        let angle = rotation - lastRotation
        return self.transform.rotated(by: angle)
    }

    func animateToRotatedTransform(_ transform:CGAffineTransform) {
        UIView.animate(withDuration: 0.0) { () -> Void in
            self.transform = transform
        }
    }

    func minimumRotation() -> CGFloat {
        return CGFloat.greatestFiniteMagnitude
    }

    func maximumRotation() -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    func didStartRotating() {
        return
    }

    func didFinishRotating(_ velocity:CGFloat) {
        return
    }
}
