//
//  AppDelegate.swift
//  FloatingViewController
//
//  Created by yusuf demirkoparan on 4.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let viewController = ViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: viewController)
        let vc2 = ViewController2.instantiate()
        viewController.showFloatingViewController(with: vc2, with: viewController)
        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

