//
//  ViewController.swift
//  DKChainableAnimationKit
//
//  Created by Draveness on 15/5/13.
//  Copyright (c) 2015年 Draveness. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let v: UIView = UIView(frame: CGRect(x: 100, y: 150, width: 50, height: 50))
    let secondView: UIView = UIView(frame: CGRect(x: 300, y: 250, width: 50, height: 50))

    override func viewDidLoad() {
        super.viewDidLoad()

        v.backgroundColor = UIColor.blue
        self.view.addSubview(v)

        secondView.backgroundColor = UIColor.white
        secondView.layer.borderWidth = 1.0
        secondView.layer.borderColor = UIColor.red.cgColor
        self.view.addSubview(secondView)

        UIApplication.shared.isStatusBarHidden = true

        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.frame = CGRect(x: 0, y: self.view.bounds.size.height - 50.0, width: self.view.bounds.size.width, height: 50)
        button.backgroundColor = UIColor.blue
        button.setTitle("Action!", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(ViewController.animateView(_:)), for: .touchUpInside)
        self.view.addSubview(button)
    }

    @objc func animateView(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        _ = UIColor.purple
        let green = UIColor.green
        let black = UIColor.black
        let white = UIColor.white

        secondView.animation.moveY(-200).makeBackground(black).thenAfter(0.5)
            .moveY(200).makeBackground(green).thenAfter(0.5)
            .makeBackground(white).thenAfter(0.2)
            .makeBackground(black).thenAfter(0.2)
            .makeBackground(white).animate(0.2)

        v.animation.moveX(100).thenAfter(1.0).moveWidth(50).bounce.makeBackground(green).easeIn.anchorTopLeft.thenAfter(0.5).rotate(95).easeBack.thenAfter(0.5).moveY(300).easeIn.makeOpacity(0.0).animateWithCompletion(0.4, {
            self.v.layer.transform = CATransform3DMakeRotation(0, 0, 0, 1)
            self.v.frame = CGRect(x: 100, y: 150, width: 50, height: 50)
            self.v.animation.makeOpacity(1.0).makeBackground(UIColor.blue).animate(1.0)
            self.v.layer.cornerRadius = 0


            sender.animation.moveY(-50).easeInOutExpo.animate(1.1).animationCompletion = {
                sender.isUserInteractionEnabled = true
            };
        })

       sender.animation.moveY(50).easeInOutExpo.animate(0.5)

    }
}

