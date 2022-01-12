//
//  AppDelegate.swift
//  CRRefresh
//
//  Created by Pham Quang Huy on 2022/01/10.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let VC = ViewController()
        let NAV = NavigationViewController(rootViewController: VC)
        window?.rootViewController = NAV
        
        UITableView.appearance().estimatedSectionHeaderHeight = 0
        UITableView.appearance().estimatedSectionFooterHeight = 0
        
        return true
    }

}

