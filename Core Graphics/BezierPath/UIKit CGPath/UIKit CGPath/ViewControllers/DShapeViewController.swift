//
//  DShapeViewController.swift
//  UIKit CGPath
//
//  Created by Luiz Pedro Franciscatto Guerra on 21/07/22.
//

import UIKit

class DShapeViewController: UIViewController {
    var dShapeView: UIView?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dShapeView?.center = self.view.center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets up the square
        let dShape = DShapeView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        dShape.backgroundColor = .white
        // The sttribute declaration is in another line
        //    so the weak reference doesn't get removed from memory
        self.view.addSubview(dShape)
        self.dShapeView = dShape
    }
}

class DShapeView: UIView {
    final let strokeWidth: CGFloat = 5
    override func draw(_ rect: CGRect) {
        // Retrieving the core graphics context so you can draw in it
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.saveGState()
        // Relasing the context when finished
        // It's not necessary to do like this, you can just add the
        //  ```context.restoreGState()```
        // at the end of the function
        defer {
            context.restoreGState()
        }
        
        // Creates a new empty path in a graphics context
        context.beginPath()
        
        // Drawing stages
        context.move(to: CGPoint(x: strokeWidth, y: strokeWidth))
        context.addCurve(
            to: CGPoint(x: strokeWidth, y: rect.height - strokeWidth),
            control1: CGPoint(x: rect.width * 0.75, y: strokeWidth),
            control2: CGPoint(x: rect.width * 0.75, y: rect.height - strokeWidth))
        context.addLine(to: CGPoint(x: strokeWidth, y: strokeWidth))
        
        // Finishes the path
        // This allows to draw more shapes in the same view
        context.closePath()
        
        // Sets the filling and stroke color that the path should be rendered with
        context.setFillColor(UIColor.white.cgColor)
        context.setStrokeColor(UIColor.tintColor.cgColor)
        context.setLineWidth(5)
        
        // Fill stroke and space
        // It is important to call in this order, otherwise your stroke might "disappear"
        context.strokePath()
        context.fillPath()
    }
}
