//
//  ViewController.swift
//  BoldAndUnboldTextOnUILabel
//
//  Created by Pham Quang Huy on 5/2/18.
//  Copyright © 2018 Pham Quang Huy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbUser: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let targetString = "Updated 2012/10/14 21:59 PM"
        let range = NSMakeRange(7, 12)
        
        lbUser.backgroundColor = UIColor.white
        lbUser.attributedText = attributedString(from: targetString, nonBoldRange: range)
        lbUser.sizeToFit()
    }

    func attributedString(from string: String, nonBoldRange: NSRange?) -> NSAttributedString {
        let fontSize = UIFont.systemFontSize
        let attrs = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        let nonBoldAttribute = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
            ]
        let attrStr = NSMutableAttributedString(string: string, attributes: attrs)
        if let range = nonBoldRange {
            attrStr.setAttributes(nonBoldAttribute, range: range)
        }
        return attrStr
    }
}

