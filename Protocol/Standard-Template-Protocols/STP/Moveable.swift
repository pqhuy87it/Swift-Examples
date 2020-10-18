//
//  Moveable.swift
//  Standard Template Protocols
//
//  Created by Chris O'Neil on 9/20/15.
//  Copyright (c) 2015 Because. All rights reserved.
//

import UIKit

public protocol Moveable {
    func makeMoveable()
    func didStartMoving()
    func didFinishMoving(_ velocity:CGPoint)
    func canMoveToX(_ x:CGFloat) -> Bool
    func canMoveToY(_ y:CGFloat) -> Bool
    func translateCenter(_ translation:CGPoint, velocity:CGPoint, startPoint:CGPoint, currentPoint:CGPoint) -> CGPoint
    func animateToMovedTransform(_ transform:CGAffineTransform)
}

public extension Moveable where Self:UIView {

    func makeMoveable() {

        var startPoint: CGPoint = CGPoint.zero
        var currentPoint: CGPoint = CGPoint.zero

        let gestureRecognizer = UIPanGestureRecognizer { [unowned self] (recognizer) -> Void in
            let pan = recognizer as! UIPanGestureRecognizer
            let velocity = pan.velocity(in: self.superview)
            let translation = pan.translation(in: self.superview)
            switch recognizer.state {
                case .began:
                startPoint = self.center
                currentPoint = self.center
                self.didStartMoving()
                case .ended, .cancelled, .failed:
                self.didFinishMoving(velocity)
            default:
                let point = self.translateCenter(translation, velocity:velocity, startPoint: startPoint, currentPoint: currentPoint)
                self.animateToMovedTransform(self.transformFromCenter(point, currentPoint: currentPoint))
                currentPoint = point
            }
        }
        self.addGestureRecognizer(gestureRecognizer)
    }

    func animateToMovedTransform(_ transform:CGAffineTransform) {
        UIView.animate(withDuration: 0.01) { () -> Void in
            self.transform = transform;
        }
    }

    func translateCenter(_ translation:CGPoint, velocity:CGPoint, startPoint:CGPoint, currentPoint:CGPoint) -> CGPoint {
        var point = startPoint

        if (self.canMoveToX(point.x + translation.x)) {
            point.x += translation.x
        } else {
            point.x = translation.x > 0.0 ? maximumPoint().x : minimumPoint().x
        }

        if (self.canMoveToY(point.y + translation.y)) {
            point.y += translation.y
        } else {
            point.y = translation.y > 0.0 ? maximumPoint().y : minimumPoint().y
        }

        return point
    }

    func transformFromCenter(_ center:CGPoint, currentPoint:CGPoint) -> CGAffineTransform {
        return self.transform.translatedBy(x: center.x - currentPoint.x , y: center.y - currentPoint.y)
    }

    func didStartMoving() {
        return
    }

    func didFinishMoving(_ velocity:CGPoint) {
        return
    }

    func canMoveToX(_ x: CGFloat) -> Bool {
        if let superviewFrame = self.superview?.frame {
            let diameter = self.frame.size.width / 2.0
            if x + diameter > superviewFrame.size.width {
                return false
            }
            if x - diameter < 0.0 {
                return false
            }
        }
        return true
    }

    func canMoveToY(_ y: CGFloat) -> Bool {
        if let superviewFrame = self.superview?.frame {
            let diameter = self.frame.size.height / 2.0
            if y + diameter > superviewFrame.size.height {
                return false
            }
            if y - diameter < 0.0 {
                return false
            }
        }
        return true
    }

    func maximumPoint() -> CGPoint {
        if let superviewFrame = self.superview?.frame {
            let x = superviewFrame.size.width - self.frame.size.width / 2.0
            let y = superviewFrame.size.height - self.frame.size.height / 2.0
            return CGPoint(x: x, y: y)
        } else {
            return CGPoint.zero
        }
    }

    func minimumPoint() -> CGPoint {
        let x = self.frame.size.width / 2.0
        let y = self.frame.size.height / 2.0
        return CGPoint(x: x, y: y)
    }
}
