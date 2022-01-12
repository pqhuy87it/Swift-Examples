//
//  AppDelegate.swift
//  DGElasticPullToRefresh
//
//  Created by Pham Quang Huy on 2022/01/10.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let viewController = ViewController()
        let navigationController = NavigationController(rootViewController: viewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = navigationController
        window!.backgroundColor = .white
        window!.makeKeyAndVisible()
        
        return true
    }

}

