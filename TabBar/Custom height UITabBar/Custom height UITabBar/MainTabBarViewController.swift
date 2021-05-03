//
//  ViewController.swift
//  Custom height UITabBar
//
//  Created by Pham Quang Huy on 2021/05/01.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    class WeiTabBar: UITabBar {
        
        override func sizeThatFits(_ size: CGSize) -> CGSize {
            
            var sizeThatFits = super.sizeThatFits(size)
            
            sizeThatFits.height = 200
            
            return sizeThatFits
        }
    }
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
        
        object_setClass(self.tabBar, WeiTabBar.self)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var viewControllers: [UIViewController] = []
        
        let firstViewController = FirstViewController()
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.mostRecent, tag: 1)
        viewControllers.append(firstViewController)
        
        let secondViewController = SecondViewController()
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.mostViewed, tag: 2)
        viewControllers.append(secondViewController)
        
        let thirdViewController = ThirdViewController()
        thirdViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.contacts, tag: 3)
        viewControllers.append(thirdViewController)
        
        self.setViewControllers(viewControllers, animated: false)
        
        
        // なぜか0だけだと選択されないので1にしてから0に
        self.selectedIndex = 1
    }


}

