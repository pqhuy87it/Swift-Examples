//
//  LineBrush.swift
//  DrawingBoard
//
//  Created by ZhangAo on 15-2-15.
//  Copyright (c) 2015年 zhangao. All rights reserved.
//

import UIKit

class LineBrush: BaseBrush {
    
    override func drawInContext(context: CGContext) {
        context.move(to: CGPoint(x: beginPoint.x, y: beginPoint.y))
        context.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
    }
}
