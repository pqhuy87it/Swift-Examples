//
//  BannerViewController.swift
//  UIKit CGPath
//
//  Created by Luiz Pedro Franciscatto Guerra on 21/07/22.
//

import UIKit

class BannerViewController: UIViewController {
    @IBOutlet weak var bannerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerLabel.textColor = UIColor.tintColor
    }
}

class BannerView: UIView {
    override func draw(_ rect: CGRect) {
        createTopLayer(rect)
        createBottomLayer(rect)
    }
    
    func createTopLayer(_ rect: CGRect) {
        // Retrieving the core graphics context so you can draw in it
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.saveGState()
        
        // Creates a new empty path in a graphics context
        context.beginPath()
        
        // Drawing stages
        context.move(to: .zero)
        context.addLine(to: CGPoint(x: rect.width, y: 0))
        context.addLine(to: CGPoint(x: rect.width, y: rect.height*0.3125))
        context.addCurve(to: CGPoint(x: 40, y: 75),
                         control1: CGPoint(x: rect.width-40, y: rect.height*0.15625),
                         control2: CGPoint(x: rect.width*3/5, y: rect.height*0.09375))
        context.addCurve(to: CGPoint(x: 0, y: 50),
                         control1: CGPoint(x: 10, y: 75),
                         control2: CGPoint(x: 0, y: 65))
        context.addLine(to: .zero)
        
        // Finishes the path
        // This allows to draw more shapes in the same view
        context.closePath()
        
        // Sets the filling color that the path should be rendered with
        context.setFillColor(UIColor.tintColor.cgColor)
        context.fillPath()
        
        // Relasing the context when finished
        context.restoreGState()
    }
    
    func createBottomLayer(_ rect: CGRect) {
        // Retrieving the core graphics context so you can draw in it
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.saveGState()
        
        // Creates a new empty path in a graphics context
        
        // Drawing stages
        context.beginPath()
        context.move(to: .zero)
        context.move(to: CGPoint(x: 0, y: rect.height*0.6875))
        
        context.addCurve(to: CGPoint(x: rect.width-40, y: rect.height-75),
                         control1: CGPoint(x: 40, y: rect.height*0.84375),
                         control2: CGPoint(x: rect.width*2/5, y: rect.height*0.90625))
        
        context.addCurve(to: CGPoint(x: rect.width, y: rect.height-50),
                         control1: CGPoint(x: rect.width-10, y: rect.height-75),
                         control2: CGPoint(x: rect.width, y: rect.height-65))
        context.addLine(to: CGPoint(x: rect.width, y: rect.height))
        context.addLine(to: CGPoint(x: 0, y: rect.height))
        
        context.addLine(to: CGPoint(x: 0, y: rect.height*0.6875))
        context.addLine(to: .zero)
        context.closePath()
        
        // Finishes the path
        // This allows to draw more shapes in the same view
        
        // Sets the filling color that the path should be rendered with
        context.setFillColor(UIColor.tintColor.cgColor)
        context.fillPath()
        
        // Relasing the context when finished
        context.restoreGState()
    }
    
}

