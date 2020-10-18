//
//  ForceTouchGestureRecognizer.swift
//  STP
//
//  Created by Chris O'Neil on 10/18/15.
//  Copyright © 2015 Because. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

@available(iOS 9.0, *)
class ForceTouchGestureRecognizer: UIGestureRecognizer {

    var force:CGFloat = 0.0

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        self.state = .began
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)

        if self.state == .failed {
            return
        }

        let touch = touches.first
        self.force = touch?.force ?? 0.0
        self.state = .changed
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        self.state = .ended
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        self.state = .cancelled
    }
}
