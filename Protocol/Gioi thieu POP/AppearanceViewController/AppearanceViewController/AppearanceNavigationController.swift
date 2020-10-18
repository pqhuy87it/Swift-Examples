//
//  AppearanceNavigationController.swift
//  AppearanceViewController
//
//  Created by Huy Pham on 6/30/17.
//  Copyright © 2017 Huy Pham. All rights reserved.
//

import UIKit

class AppearanceNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        delegate = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        delegate = self
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        delegate = self
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let appearanceViewController = viewController as? AppearanceViewController else {
            return
        }
        
        // set navigation bar hidden
        setNavigationBarHidden(appearanceViewController.navigationBarHidden(), animated: animated)
        
        // set navigation controller appearance
        if let appearance = appearanceViewController.navigationControllerAppearance() {
            let navigationBar = navigationController.navigationBar
            
            if !navigationController.isNavigationBarHidden {
                let backgroundImage = renderImageOfColor(color: appearance.navigationBar.backgroundColor)
                navigationBar.setBackgroundImage(backgroundImage, for: .default)
                navigationBar.tintColor = appearance.navigationBar.tintColor
                navigationBar.barTintColor = appearance.navigationBar.barTintColor
                navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: appearance.navigationBar.tintColor]
            }
        }
    }
    
    func renderImageOfColor(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        UIGraphicsBeginImageContext(size);
        let context = UIGraphicsGetCurrentContext()!;
        
        context.setFillColor(color.cgColor);
        context.fill(CGRect(x:0, y:0, width: size.width, height: size.height));
        
        let output = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return output!;
    }
    
}
