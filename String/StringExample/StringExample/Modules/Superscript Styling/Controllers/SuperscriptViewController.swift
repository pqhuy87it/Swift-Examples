//
//  SuperscriptViewController.swift
//  StringExample
//
//  Created by Pham Quang Huy on 2020/09/07.
//  Copyright © 2020 Pham Quang Huy. All rights reserved.
//

import UIKit

class SuperscriptViewController: UIViewController {

    @IBOutlet weak var exampleLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setup()
    }
    
    func setup() {
        let percentString = "50%"
        let textAttribues = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30.0)]
        let attributedString = NSMutableAttributedString(string: percentString, attributes: textAttribues)
        attributedString.setAttributes([NSAttributedString.Key.baselineOffset: 10], range: NSMakeRange(2, 1))
        exampleLb.attributedText = attributedString
    }

}
