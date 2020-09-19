//
//  ViewController.swift
//  CGAffineTranslateDemo
//
//  Created by Arun Gupta on 17/03/17.
//  Copyright © 2017 Arun Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbl1: UILabel!
    
    @IBOutlet weak var lbl2: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func tapEvent(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0, animations: {
            self.lbl1.transform = CGAffineTransform(translationX: 0, y: self.view.center.y - 10)
            self.lbl2.transform = CGAffineTransform(translationX: 0, y: -(self.view.center.y - 15))
        }, completion: { finished in
            UIView.animate(withDuration: 0.7, animations: {
                self.lbl1.transform = CGAffineTransform(translationX: -self.view.frame.width, y: self.view.center.y - 10)
                self.lbl2.transform = CGAffineTransform(translationX: self.view.frame.width, y: -(self.view.center.y - 15))
            }, completion: { finished in
                self.lbl1.transform = CGAffineTransform.identity
                self.lbl2.transform = CGAffineTransform.identity
            })
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

