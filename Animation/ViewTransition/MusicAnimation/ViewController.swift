//
//  ViewController.swift
//  MusicAnimation
//
//  Created by Arun on 3/21/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /*
        Front
            Leading = 20
            Trailing = 20
            Top = 35
            Bottom = 150
        Back
            Leading = 67
            Trailing = 74
            Top = 8
            Bottom = 200
    */
    @IBOutlet weak var frontTrailing: NSLayoutConstraint!
    @IBOutlet weak var frontLeading: NSLayoutConstraint!
    @IBOutlet weak var frontTop: NSLayoutConstraint!
    @IBOutlet weak var frontBottom: NSLayoutConstraint!
    @IBOutlet weak var backLeading: NSLayoutConstraint!
    @IBOutlet weak var backTailing: NSLayoutConstraint!
    @IBOutlet weak var backTop: NSLayoutConstraint!
    @IBOutlet weak var backBottom: NSLayoutConstraint!
    @IBOutlet weak var backview: UIView!
    @IBOutlet weak var frontView: UIView!
    
    var frontVisible = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnClick(_ sender: UIButton) {
        if self.frontVisible {
            self.frontViewVisible()
        } else {
            self.backViewVisible()
        }
    }
    
    func frontViewVisible () {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.frontTop.constant = self.frontTop.constant + 100;
            self.frontBottom.constant = self.frontBottom.constant - 100;
            self.view.layoutIfNeeded()
        }, completion: { finished in
            print("completion")
            self.view .bringSubviewToFront(self.backview)
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                    //Move FrontView To Back
                    self.frontLeading.constant = 67
                    self.frontTrailing.constant = 74
                    self.frontTop.constant = 0
                    self.frontBottom.constant = 200
                    //Bring BackView To Front
                    self.backLeading.constant = 20
                    self.backTailing.constant = 20
                    self.backTop.constant = 35
                    self.backBottom.constant = 150
                    self.view.layoutIfNeeded()
                }, completion: { finished in
                    self.frontVisible = false
                })
        })
    }

    func backViewVisible () {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.backTop.constant = self.backTop.constant + 100;
            self.backBottom.constant = self.backBottom.constant - 100;
            self.view.layoutIfNeeded()
        }, completion: { finished in
            self.view .bringSubviewToFront(self.frontView)
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                    //Move FrontView To Back
                    self.backLeading.constant = 67
                    self.backTailing.constant = 74
                    self.backTop.constant = 0
                    self.backBottom.constant = 200
                    //Bring BackView To Front
                    self.frontLeading.constant = 20
                    self.frontTrailing.constant = 20
                    self.frontTop.constant = 35
                    self.frontBottom.constant = 150
                    self.view.layoutIfNeeded()
                }, completion: { finished in
                        self.frontVisible = true
                })
        })
    }
    
    
}

