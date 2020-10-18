//
//  ViewController.swift
//  AppPearMusicSample
//
//  Created by Pham Quang Huy on 8/7/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let a = Artist()
        a.name = "Bob Marley"
        a.instrument = "Guitar / Vocals"
        a.bio = "Every little thing's gonna be alright."
        
        titleLable.displayStringValue(obj: a)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

