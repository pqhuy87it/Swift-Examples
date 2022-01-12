import Foundation


/// A bezier curve, often used to calculate timing functions.
public struct UnitBezier: Equatable {
    
    public var first: ControlPoint
    public var second: ControlPoint
    
    /// Creates a new `UnitBezier` instance.
    public init(first: ControlPoint, second: ControlPoint) {
        self.first = first
        self.second = second
    }
    
    public init(firstX: Double, firstY: Double, secondX: Double, secondY: Double) {
        self.first = ControlPoint(x: firstX, y: firstY)
        self.second = ControlPoint(x: secondX, y: secondY)
    }
    
    /// Calculates the resulting `y` for given `x`.
    ///
    /// - parameter x: The value to solve for.
    /// - parameter epsilon: The required precision of the result (where `x * epsilon` is the maximum time segment to be evaluated).
    /// - returns: The solved `y` value.
    public func solve(x: Double, epsilon: Double) -> Double {
        return UnitBezierSolver(p1x: first.x, p1y: first.y, p2x: second.x, p2y: second.y).solve(x: x, eps: epsilon)
    }

}

extension UnitBezier {
    
    /// A control point for a unit bezier.
    public struct ControlPoint: Equatable {
        
        /// The x component
        public var x: Double
        
        /// The y component
        public var y: Double
        
        /// Initializes a new control point.
        public init(x: Double, y: Double) {
            self.x = x
            self.y = y
        }

    }
    
}




// Ported to Swift from WebCore:
// http://opensource.apple.com/source/WebCore/WebCore-955.66/platform/graphics/UnitBezier.h

/*
* Copyright (C) 2008 Apple Inc. All Rights Reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions
* are met:
* 1. Redistributions of source code must retain the above copyright
*    notice, this list of conditions and the following disclaimer.
* 2. Redistributions in binary form must reproduce the above copyright
*    notice, this list of conditions and the following disclaimer in the
*    documentation and/or other materials provided with the distribution.
*
* THIS SOFTWARE IS PROVIDED BY APPLE INC. ``AS IS'' AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
* IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
* PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL APPLE INC. OR
* CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
* EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
* PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
* PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
* OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
* OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/


fileprivate struct UnitBezierSolver {
    
    private let ax: Double
    private let bx: Double
    private let cx: Double
    
    private let ay: Double
    private let by: Double
    private let cy: Double
    
    init(p1x: Double, p1y: Double, p2x: Double, p2y: Double) {
        
        // Calculate the polynomial coefficients, implicit first and last control points are (0,0) and (1,1).
        cx = 3.0 * p1x
        bx = 3.0 * (p2x - p1x) - cx
        ax = 1.0 - cx - bx
        
        cy = 3.0 * p1y
        by = 3.0 * (p2y - p1y) - cy
        ay = 1.0 - cy - by
    }
    
    func solve(x: Double, eps: Double) -> Double {
        return sampleCurveY(t: solveCurveX(x: x, eps: eps))
    }
    
    private func sampleCurveX(t: Double) -> Double {
        return ((ax * t + bx) * t + cx) * t
    }
    
    private func sampleCurveY(t: Double) -> Double {
        return ((ay * t + by) * t + cy) * t
    }
    
    private func sampleCurveDerivativeX(t: Double) -> Double {
        return (3.0 * ax * t + 2.0 * bx) * t + cx
    }
    
    private func solveCurveX(x: Double, eps: Double) -> Double {
        var t0: Double = 0.0
        var t1: Double = 0.0
        var t2: Double = 0.0
        var x2: Double = 0.0
        var d2: Double = 0.0
        
        // First try a few iterations of Newton's method -- normally very fast.
        t2 = x
        for _ in 0..<8 {
            x2 = sampleCurveX(t: t2) - x
            if abs(x2) < eps {
                return t2
            }
            d2 = sampleCurveDerivativeX(t: t2)
            if abs(d2) < 1e-6 {
                break
            }
            t2 = t2 - x2 / d2
        }
        
        // Fall back to the bisection method for reliability.
        t0 = 0.0
        t1 = 1.0
        t2 = x
        
        if t2 < t0 {
            return t0
        }
        if t2 > t1 {
            return t1
        }
        
        while t0 < t1 {
            x2 = sampleCurveX(t: t2)
            if abs(x2-x) < eps {
                return t2
            }
            if x > x2 {
                t0 = t2
            } else {
                t1 = t2
            }
            t2 = (t1-t0) * 0.5 + t0
        }
        
        return t2
    }
    
}
