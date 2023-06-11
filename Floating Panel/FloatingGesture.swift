// by Jeytery
// All right are reserved

import Foundation
import UIKit

public extension UIView {
    func addGesture(_ gesture: Gesture) {
        let gestureRecognizer = UIPanGestureRecognizer(
            target: gesture,
            action: #selector(gesture.getGesture)
        )
        addGestureRecognizer(gestureRecognizer)
    }
}

extension UIView {
    static func animate(duration: CGFloat = 0.5, _ animation: @escaping () -> Void, completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .curveEaseIn,
            animations: {
                animation()
            },
            completion: { _ in completion?() }
        )
    }

    static func animate(_ animation: @escaping () -> Void) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .curveEaseIn,
            animations: animation
        )
    }
}


public class Math {
    public static func mapDiaposons<Type: FloatingPoint>(
        value: Type ,
        from diaposonA: ClosedRange<Type>,
        to diaposonB: ClosedRange<Type>
    ) -> Type {
        return (value - diaposonA.upperBound) / (diaposonA.lowerBound - diaposonA.upperBound) * (diaposonB.lowerBound - diaposonB.upperBound) + diaposonB.upperBound
    }
    
    public static func getRadian(degree: CGFloat) -> CGFloat {
        return degree * CGFloat.pi / 180
    }
}

public class Gesture {
    @objc func getGesture(_ sender: UIPanGestureRecognizer) {
        let view = sender.view!
        switch sender.state {
        case .began:
            gestureDidStart(sender, view: view)
            break
        case .changed:
            gestureDidChange(sender, view: view)
            break
        case .ended:
            gestureDidEnd(sender, view: view)
            break
        case .cancelled:
            gestureDidCanceled(sender, view: view)
            break
        default:
            break
        }
    }
    
    func gestureDidCanceled(_ sender: UIPanGestureRecognizer, view: UIView) {}
    
    func gestureDidChange(_ sender: UIPanGestureRecognizer, view: UIView) {}
    func gestureDidStart (_ sender: UIPanGestureRecognizer, view: UIView) {}
    func gestureDidEnd   (_ sender: UIPanGestureRecognizer, view: UIView) {}
}

public protocol FloatingGestureDelegate: AnyObject {
    func floatingGesture(_ gesture: FloatingGesture, didEndWith card: UIView)
    func floatingGesture(_ gesture: FloatingGesture, didEndWithout card: UIView)
    func floatingGesture(_ gesture: FloatingGesture, didEndAnimation isWithCard: Bool)
    
    func floatingGestureDidStart(_ gesture: FloatingGesture)
    func floatingGestureWillEnd(_ gesture: FloatingGesture)
    
    func floatingGesutre(
        _ gesture: FloatingGesture,
        didChangedWith yOffset: CGFloat,
        with range: ClosedRange<CGFloat>
    )
}

public extension FloatingGestureDelegate {
    func floatingGestureDidStart(_ gesture: FloatingGesture) {}
    func floatingGestureWillEnd(_ gesture: FloatingGesture) {}
    
    func floatingGesutre(
        _ gesture: FloatingGesture,
        didChangedWith yOffset: CGFloat,
        with range: ClosedRange<CGFloat>
    ) {}
    
    func floatingGesture(
        _ gesture: FloatingGesture,
        didEndAnimation isWithCard: Bool
    ) {}
}

public class FloatingGesture: Gesture {
    
    override public init() {}
    
    public weak var delegate: FloatingGestureDelegate?
    
    private var view: UIView!
    private var superview: UIView!
    
    private let rotateDiaposon: ClosedRange<CGFloat> = -30...30
    private let deletePoint: CGFloat = 95
    
    override func gestureDidStart(_ sender: UIPanGestureRecognizer, view: UIView) {
        self.view = view
        self.superview = view.superview
        delegate?.floatingGestureDidStart(self)
    }
    
    override func gestureDidEnd(_ sender: UIPanGestureRecognizer, view: UIView) {
        if view.center.x < deletePoint || view.center.x > UIScreen.main.bounds.width - deletePoint {
            delegate?.floatingGesture(self, didEndWithout: view)
            hide()
        }
        else {
            delegate?.floatingGesture(self, didEndWith: view)
            reset()
        }
    }
    
    override func gestureDidChange(_ sender: UIPanGestureRecognizer, view: UIView) {
        let translation = sender.translation(in: view)
        let newX = view.center.x + translation.x
        let newY = view.center.y + translation.y
        
        view.center = CGPoint(x: newX, y: newY)
        sender.setTranslation(.zero, in: view)
        
        let postionDiaposon = superview.frame.minX ... UIScreen.main.bounds.width
        let degree = Math.mapDiaposons(value: newX, from: postionDiaposon, to: rotateDiaposon)
        rotate(degree: degree)
        
        delegate?.floatingGesutre(self, didChangedWith: degree, with: rotateDiaposon)
    }
    
    override func gestureDidCanceled(_ sender: UIPanGestureRecognizer, view: UIView) {
        delegate?.floatingGesture(self, didEndWith: view)
        reset()
    }
}

//MARK: - gesture parts
extension FloatingGesture {
    private func reset() {
        UIView.animate {
            [unowned self] in
            let center = CGPoint(x: superview.frame.midX,
                                 y: superview.frame.midY)
            view.center = center
            rotate(degree: 0)
            
        }
        completion: {
            [unowned self] in
            delegate?.floatingGesture(self, didEndAnimation: true)
        }
    }
    
    private func hide() {
        UIView.animate {
            [unowned self] in
            view.alpha = 0
            view.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }
        completion: {
            [unowned self] in
            delegate?.floatingGesture(self, didEndAnimation: false)
        }
    }
    
    private func rotate(degree: CGFloat) {
        let radian = Math.getRadian(degree: degree)
        view.transform = CGAffineTransform(rotationAngle: radian)
    }
}
