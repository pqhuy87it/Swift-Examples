//
//  DetectTapView.swift
//  DetectTouchEvent
//
//  Created by Exlinct on 4/23/17.
//  Copyright © 2017 Framgia, Inc. All rights reserved.
//

import UIKit

protocol DetectTapViewDelegate: class {
    func handleDoubleTap(view: UIView, touch: UITouch)
    func handleSingleTap(view: UIView, touch: UITouch)
}

class DetectTapView: UIView {
    weak var delegate: DetectTapViewDelegate?
    
    override func touchesEnded(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        guard let delegate = self.delegate else {
            return
        }
        
        switch touch.tapCount {
        case 1:
            delegate.handleSingleTap(view: self, touch: touch)
        case 2:
            delegate.handleDoubleTap(view: self, touch: touch)
        default:
            break
        }
    }
}
