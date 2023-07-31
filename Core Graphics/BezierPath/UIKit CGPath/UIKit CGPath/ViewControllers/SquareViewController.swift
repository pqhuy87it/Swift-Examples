//
//  SquareViewController.swift
//  UIKit CGPath
//
//  Created by Luiz Pedro Franciscatto Guerra on 21/07/22.
//

import UIKit

class SquareViewController: UIViewController {
    weak var squareView: UIView?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        squareView?.center = self.view.center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets up the square
        let square = SquareView(frame: CGRect(
            origin: .zero,
            size: CGSize(width: 100, height: 100)))
        // The sttribute declaration is in another line
        //    so the weak reference doesn't get removed from memory
        self.view.addSubview(square)
        self.squareView = square
    }
}

class SquareView: UIView {
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
        context.move(to: .zero)
        context.addLine(to: CGPoint(x: rect.width, y: 0))
        context.addLine(to: CGPoint(x: rect.width, y: rect.height))
        context.addLine(to: CGPoint(x: 0, y: rect.height))
        context.addLine(to: .zero)
        
        // Finishes the path
        // This allows to draw more shapes in the same view
        context.closePath()
        
        // Sets the filling color that the path should be rendered with
        context.setFillColor(UIColor.tintColor.cgColor)
        context.fillPath()
    }
}
