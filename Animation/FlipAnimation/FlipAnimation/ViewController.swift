//
//  ViewController.swift
//  FlipAnimation
//
//  Created by Arun Gupta on 17/02/17.
//  Copyright © 2017 Arun Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontImageView: UIImageView!
    var isFrontVisible = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func flipBtnTapped(_ sender: UIButton) {
        var option: UIView.AnimationOptions = .transitionFlipFromRight
        if(self.isFrontVisible) {
            self.isFrontVisible = false
            self.frontImageView.image = UIImage.init(named: "kiwi1.jpg")
            option = .transitionFlipFromRight
        } else {
            self.isFrontVisible = true
            self.frontImageView.image = UIImage.init(named: "kiwi.jpg")
            option = .transitionFlipFromLeft
        }
        
        UIView.transition(with: self.frontImageView, duration: 0.8, options: option, animations: nil, completion: nil)
    }
}

