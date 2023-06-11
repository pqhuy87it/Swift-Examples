//
//  UIKit+Geometry.swift
//  bottomsheet-tests
//
//  Created by Vladislav Maltsev on 28.06.2022.
//

import UIKit

extension CGPoint {
    func distance(to another: CGPoint) -> CGFloat {
        let dx = x - another.x
        let dy = y - another.y
        return sqrt(dx * dx + dy * dy)
    }
}

extension CGRect {
    func center() -> CGPoint {
        .init(
            x: origin.x + 0.5 * size.width,
            y: origin.y + 0.5 * size.height
        )
    }
}

func + (_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
    .init(
        x: lhs.x + rhs.x,
        y: lhs.y + rhs.y
    )
}

func - (_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
    .init(
        x: lhs.x - rhs.x,
        y: lhs.y - rhs.y
    )
}

func * (_ fraction: CGFloat, _ point: CGPoint) -> CGPoint {
    .init(
        x: fraction * point.x,
        y: fraction * point.y
    )
}

func * (_ point: CGPoint, _ fraction: CGFloat) -> CGPoint {
    .init(
        x: fraction * point.x,
        y: fraction * point.y
    )
}

extension UISpringTimingParameters {
    convenience init(damping: CGFloat, response: CGFloat, initialVelocity: CGVector = .zero) {
        let stiffness = pow(2 * .pi / response, 2)
        let damp = 4 * .pi * damping / response
        self.init(mass: 1, stiffness: stiffness, damping: damp, initialVelocity: initialVelocity)
    }
}
