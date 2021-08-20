//
//  ViewController1.swift
//  CustomBackButton
//
//  Created by Pham Quang Huy on 8/22/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let backImage = UIImage(named: "back-button")?.withRenderingMode(.alwaysOriginal)
        
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        
        /*** If needed Assign Title Here ***/
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "ViewContnroller1",
                                                                style: .plain,
                                                                target: nil,
                                                                action: nil)
        self.navigationItem.backBarButtonItem?.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.orange
        ], for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
