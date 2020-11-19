//
//  ViewController.swift
//  ChangeNavigationBarByGradientColor
//
//  Created by Huy Pham on 8/23/17.
//  Copyright © 2017 Huy Pham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let bar = self.navigationController?.navigationBar {
            setInitialBarGradientColor(startColor: .red, endColor: .blue)
            setGradientColorOnNavigationBar(bar: bar)
        }
    }

    private func generateGradientImage(startColor: UIColor, endColor: UIColor) -> UIImage {
        let gradientLayer = CAGradientLayer()
        let sizeLength = UIScreen.main.bounds.size.height * 2
        let navBarFrame = CGRect(x: 0, y: 0, width: sizeLength, height: 64)
        
        gradientLayer.frame = navBarFrame
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.3, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
        
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
    
    public func setInitialBarGradientColor(startColor: UIColor, endColor: UIColor) {
        let image = generateGradientImage(startColor: startColor, endColor: endColor)
        UINavigationBar.appearance().setBackgroundImage(image, for: .default)
    }
    
    func setGradientColorOnNavigationBar(bar: UINavigationBar) {
        let image = generateGradientImage(startColor: UIColor(red:0.2, green:0.03, blue:0.4, alpha:1), endColor: UIColor(red:0.19, green:0.81, blue:0.82, alpha:1))
        bar.setBackgroundImage(image, for: .default)
    }
}

