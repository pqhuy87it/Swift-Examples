//
//  InstantPanGestureRecognizer.swift
//  bottomsheet-tests
//
//  Created by Vladislav Maltsev on 30.06.2022.
//

import UIKit

class InstantPanGestureRecognizer: UIPanGestureRecognizer {
    var shouldInterceptTap: Bool = false

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)

        if shouldInterceptTap {
            self.state = .began
        }
    }
}
