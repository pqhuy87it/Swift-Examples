//
//  FirstViewController.swift
//  TabBarApp
//
//  Created by Deep Arora on 8/16/18.
//  Copyright © 2018 Deep Arora. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var lable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lable.text = "SomeText Here. It will expalnd the StackView.omeText Here. It will expalnd the StackView.omeText Here. It will expalnd the StackView.omeText Here. It will expalnd the StackView.omeText Here. It will expalnd the StackView.omeText Here. It will expalnd the StackView.omeText Here. It will expalnd the StackView.omeText Here. It will expalnd the StackView."
        lable.sizeToFit()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

