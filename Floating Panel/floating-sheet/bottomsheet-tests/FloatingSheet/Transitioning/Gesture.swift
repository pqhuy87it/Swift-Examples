//
//  Gesture.swift
//  bottomsheet-tests
//
//  Created by Vladislav Maltsev on 30.06.2022.
//

import UIKit
import simd

struct Gesture {
    var translation: CGPoint
    var velocity: CGPoint

    func projectedStopPoint(for initialPoint: CGPoint) -> CGPoint {
        let position = initialPoint + translation
        let acceleration: CGFloat = -900
        let accelerationVector = CGPoint(
            x: acceleration * sign(velocity.x),
            y: acceleration * sign(velocity.y)
        )

        let projectedPoint = CGPoint(
            x: position.x - 0.5 * velocity.x * velocity.x / accelerationVector.x,
            y: position.y - 0.5 * velocity.y * velocity.y / accelerationVector.y
        )

        return projectedPoint
    }
}
