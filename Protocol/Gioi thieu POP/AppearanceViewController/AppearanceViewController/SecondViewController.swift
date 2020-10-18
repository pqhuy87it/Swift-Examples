//
//  SecondViewController.swift
//  AppearanceViewController
//
//  Created by Huy Pham on 6/30/17.
//  Copyright © 2017 Huy Pham. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Second ViewController"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
}

extension SecondViewController: AppearanceViewController {
//    func navigationControllerAppearance(navigationController: UINavigationController) -> Appearance? {
    func navigationControllerAppearance() -> Appearance? {
        var value = Appearance()
        
        value.navigationBar.backgroundColor = UIColor.red
        value.navigationBar.tintColor = UIColor.white
        value.statusBarStyle = .lightContent
        
        return value
    }
}
