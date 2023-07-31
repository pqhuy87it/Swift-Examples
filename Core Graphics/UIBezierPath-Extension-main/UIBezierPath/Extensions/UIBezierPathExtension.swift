//
//  UIBezierPathExtension.swift
//  UIBezierPath
//
//  Created by vit on 04.06.2023.
//

import Foundation
import SwiftUI

extension UIBezierPath {
    convenience init(rect: CGRect, byCorners corners: UIRectCorner, cornerRadii: CGSize) {
        self.init()
        
        let radius = CGSize(width: min(cornerRadii.width, rect.width / 2),
                            height: min(cornerRadii.height, rect.height / 2))
        
        //top-right corner
        var offset = corners.contains(.topRight) ? radius.width : 0
        self.move(to: CGPoint(x: rect.width - offset, y: 0))
        if corners.contains(.topRight) {
            self.addElipseArc(center: CGPoint(x: rect.width - radius.width, y: radius.height),
                              radius: radius,
                              corner: .topRight)
        }
        
        //bottom-right corner
        offset = corners.contains(.bottomRight) ? radius.height : 0
        self.addLine(to: CGPoint(x: rect.width, y: rect.height - offset))
        if corners.contains(.bottomRight) {
            self.addElipseArc(center: CGPoint(x: rect.width - radius.width, y: rect.height - radius.height),
                              radius: radius,
                              corner: .bottomRight)
        }

        //bottom-left corner
        offset = corners.contains(.bottomLeft) ? radius.width : 0
        self.addLine(to: CGPoint(x: offset, y: rect.height))
        if corners.contains(.bottomLeft) {
            self.addElipseArc(center: CGPoint(x: radius.width, y: rect.height - radius.height),
                              radius: radius,
                              corner: .bottomLeft)
        }

        //top-left corner
        offset = corners.contains(.topLeft) ? radius.height : 0
        self.addLine(to: CGPoint(x: 0, y: offset))
        if corners.contains(.topLeft) {
            self.addElipseArc(center: CGPoint(x: radius.width, y: radius.height),
                              radius: radius,
                              corner: .topLeft)
        }
        
        self.close()
    }
    
    static private let Kappa = 0.552284749831
    
    func addElipseArc(center: CGPoint, radius: CGSize, corner: UIRectCorner) {
        let offset = CGPoint(x: radius.width * Self.Kappa, y: radius.height * Self.Kappa) // control point offset
        
        var endPoint = CGPoint.zero
        var controlPoint1 = CGPoint.zero
        var controlPoint2 = CGPoint.zero
        
        switch corner {
        case .topLeft:
            endPoint = CGPoint(x: center.x, y: center.y - radius.height)
            controlPoint1 = CGPoint(x: center.x - radius.width, y: center.y - offset.y)
            controlPoint2 = CGPoint(x: center.x - offset.x, y: center.y - radius.height)
            
        case .topRight:
            endPoint = CGPoint(x: center.x + radius.width, y: center.y)
            controlPoint1 = CGPoint(x: center.x + offset.x, y: center.y - radius.height)
            controlPoint2 = CGPoint(x: center.x + radius.width, y: center.y - offset.y)
            
        case .bottomRight:
            endPoint = CGPoint(x: center.x, y: center.y + radius.height)
            controlPoint1 = CGPoint(x: center.x + radius.width, y: center.y + offset.y)
            controlPoint2 = CGPoint(x: center.x + offset.x, y: center.y + radius.height)
            
        case .bottomLeft:
            endPoint = CGPoint(x: center.x - radius.width, y: center.y)
            controlPoint1 = CGPoint(x: center.x - offset.x, y: center.y + radius.height)
            controlPoint2 = CGPoint(x: center.x - radius.width, y: center.y + offset.y)
            
        default:
            assert(false)
        }
        
        self.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
    }
}
