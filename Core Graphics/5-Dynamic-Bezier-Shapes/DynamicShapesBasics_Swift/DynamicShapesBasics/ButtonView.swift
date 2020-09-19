//
//  ButtonView.swift
//  DynamicShapesBasics
//
//  Created by Matej Duník on 10/10/2018.
//  Copyright © 2018 Matej Duník. All rights reserved.
//

import UIKit

class ButtonView: UIView {

    override func draw(_ rect: CGRect) {
        // Drawing code
        MyStyleKit.drawBubbleButton(frame: self.bounds)
    }

}
