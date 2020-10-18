//
//  ViewController.swift
//  AppearanceViewController
//
//  Created by Huy Pham on 6/30/17.
//  Copyright © 2017 Huy Pham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "First ViewController"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
}

extension ViewController: AppearanceViewController {
    func navigationControllerAppearance() -> Appearance? {
        var value = Appearance()
        
        value.navigationBar.backgroundColor = UIColor.lightGray
        value.navigationBar.tintColor = UIColor.white
        value.statusBarStyle = .lightContent
        
        return value
    }
}

