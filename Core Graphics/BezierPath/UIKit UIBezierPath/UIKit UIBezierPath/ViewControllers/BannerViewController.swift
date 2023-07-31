//
//  UIBezierPathViewController.swift
//  UIKit UIBezierPath
//
//  Created by Luiz Pedro Franciscatto Guerra on 20/07/22.
//

import UIKit

class BannerViewController: UIViewController {
    var topShapeLayer: CAShapeLayer?
    var botShapeLayer: CAShapeLayer?
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.textColor = UIColor(cgColor: UIColor.tintColor.cgColor)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topShapeLayer?.removeFromSuperlayer()
        botShapeLayer?.removeFromSuperlayer()
        addTopDrawing()
        addBotDrawing()
    }
    
    func addTopDrawing () {
        // Initialize the layer and defines some of its properties
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.view.frame
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.tintColor.cgColor
        shapeLayer.fillColor = UIColor.tintColor.cgColor
        shapeLayer.lineWidth = 5
        
        // Get the absolute value
        let path = UIBezierPath()
        let rect = UIScreen.main.bounds
        
        // Drawing
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height*0.3125))
        path.addCurve(to: CGPoint(x: 40, y: 75),
                      controlPoint1: CGPoint(x: rect.width-40, y: rect.height*0.15625),
                      controlPoint2: CGPoint(x: rect.width*3/5, y: rect.height*0.09375))
        path.addCurve(to: CGPoint(x: 0, y: 50),
                      controlPoint1: CGPoint(x: 10, y: 75),
                      controlPoint2: CGPoint(x: 0, y: 65))
        path.addLine(to: .zero)
        
        // Closes and saves the new drawing
        path.close()
        shapeLayer.path = path.cgPath
        self.topShapeLayer = shapeLayer
        self.view.layer.addSublayer(shapeLayer)
    }
    
    func addBotDrawing () {
        // Initialize the layer and defines some of its properties
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.view.frame
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.tintColor.cgColor
        shapeLayer.fillColor = UIColor.tintColor.cgColor
        shapeLayer.lineWidth = 5
        
        // Get the absolute value
        let path = UIBezierPath()
        // deppending the team practices, the way you retrieve the full screen view rect can change, and each different way might affet the rendering, so be careful here
        let rect = UIScreen.main.bounds
        let width = rect.width
        let height = rect.height
        
        // Drawing
        path.move(to: CGPoint(x: 0, y: rect.height*0.6875))
        path.addCurve(to: CGPoint(x: width-40, y: height-75),
                      controlPoint1: CGPoint(x: 40, y: height*0.84375),
                      controlPoint2: CGPoint(x: width*2/5, y: height*0.90625))
        
        path.addCurve(to: CGPoint(x: width, y: height-50),
                      controlPoint1: CGPoint(x: width-10, y: height-75),
                      controlPoint2: CGPoint(x: width, y: height-65))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        
        path.addLine(to: CGPoint(x: 0, y: rect.height*0.6875))
        
        // Closes and saves the new drawing
        path.close()
        shapeLayer.path = path.cgPath
        self.botShapeLayer = shapeLayer
        self.view.layer.addSublayer(shapeLayer)
    }
}
