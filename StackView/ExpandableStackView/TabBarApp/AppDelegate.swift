//
//  AppDelegate.swift
//  TabBarApp
//
//  Created by Deep Arora on 8/16/18.
//  Copyright © 2018 Deep Arora. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    

        
        let tabBarVC = self.window?.rootViewController as! UITabBarController
        tabBarVC.delegate = self
        return true
    }


    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
   
        if  let navVC = tabBarController.selectedViewController as? UINavigationController {
            navVC.popToRootViewController(animated: true)
        }
        return true
    }
}

