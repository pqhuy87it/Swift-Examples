//
//  ViewController.swift
//  CreateImageTintColor
//
//  Created by Huy Pham on 8/3/17.
//  Copyright © 2017 Huy Pham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "image.png")!
        let redColorImage = image.tintedImage(UIColor.red)
        self.imageView.image = redColorImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIImage {
    
    /**
     Create new image by applying a tint.
     
     - parameter color: New image tint color.
     */
    func tintedImage(_ color: UIColor) -> UIImage {
        let size = self.size
        
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        self.draw(at: CGPoint.zero, blendMode: CGBlendMode.normal, alpha: 1.0)
        
        context?.setFillColor(color.cgColor)
        context?.setBlendMode(CGBlendMode.sourceIn)
        context?.setAlpha(1.0)
        
        let rect = CGRect(
            x: CGPoint.zero.x,
            y: CGPoint.zero.y,
            width: size.width,
            height: size.height)
        UIGraphicsGetCurrentContext()?.fill(rect)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return tintedImage ?? self
    }
    
}

