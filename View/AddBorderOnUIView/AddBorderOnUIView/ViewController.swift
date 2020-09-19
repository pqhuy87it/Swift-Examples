//
//  ViewController.swift
//  AddBorderOnUIView
//
//  Created by Pham Quang Huy on 4/13/18.
//  Copyright © 2018 Pham Quang Huy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myView.addBorders(edges: [.top, .bottom], color: UIColor.gray, thickness: 0.5)
    }

}

