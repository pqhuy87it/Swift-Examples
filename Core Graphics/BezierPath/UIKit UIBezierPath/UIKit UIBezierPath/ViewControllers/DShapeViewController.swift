//
//  DShapeViewController.swift
//  UIKit UIBezierPath
//
//  Created by Luiz Pedro Franciscatto Guerra on 20/07/22.
//

import UIKit

class DShapeViewController: UIViewController {
    var shape: CAShapeLayer?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Delete and update the layer here so whenever the device is rotated, the layer updates accordingly
        // If you wont redraw, only reposition it, just update the position attribute of the layer
        shape?.removeFromSuperlayer()
        drawSquare()
    }
    
    func drawSquare() {
        // Initializes the layer that will be drawn
        let shapeLayer = CAShapeLayer()
        
        // Sets the center point of the layer
        //      This might not be the best way to do this
        //      But its coded this way for simplicity sake
        let center = self.view.center
        let offsetedPosition = CGPoint(x: center.x - 25, y: center.y - 50)
        shapeLayer.position = offsetedPosition
        
        // Start the bezier path object
        let bezierPath = UIBezierPath()
        
        // Drawing stages
        bezierPath.move(to: .zero)
        bezierPath.addCurve(
            to: CGPoint(x: 0, y: 100),
            controlPoint1: CGPoint(x: 75, y: 0),
            controlPoint2: CGPoint(x: 75, y: 100))
        bezierPath.addLine(to: .zero)
        
        // Finishes the path
        bezierPath.close()

        // Uses core graphics to save the path as a snapshot
        //      (as far as I understood)
        shapeLayer.path = bezierPath.cgPath
        
        // Sets the filling and stroke color the path should be rendered with
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.strokeColor = UIColor.tintColor.cgColor
        
        // Adds to the view
        // And save it in an attribute so you can to update/delete it
        self.view.layer.addSublayer(shapeLayer)
        self.shape = shapeLayer
    }
}
