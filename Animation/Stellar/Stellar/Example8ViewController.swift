//
//  Example8ViewController.swift
//  StellarDemo
//
//  Created by AugustRush on 6/29/16.
//  Copyright © 2016 August. All rights reserved.
//

import UIKit

class Example8ViewController: UIViewController {
    @IBOutlet weak var animateView: Ball!
    
    @IBAction func segment1ValueChanged(_ sender: UISegmentedControl) {
        
        let index = sender.selectedSegmentIndex;
        
        switch index {
        case 0:
            animateView.moveX(200).duration(1.0).easing(.default).reverses().animate()
        case 1:
            animateView.moveX(200).duration(1.0).easing(.easeIn).reverses().animate()
        case 2:
            animateView.moveX(200).duration(1.0).easing(.easeOut).reverses().animate()
        case 3:
            animateView.moveX(200).duration(1.0).easing(.easeInEaseOut).reverses().animate()
        default:
            print("")
        }
        
    }
    @IBAction func segment2ValueChanged(_ sender: UISegmentedControl) {
        animateView.frame = CGRect(x: 20,y: 120,width: 40,height: 40)
        let index = sender.selectedSegmentIndex;
        
        switch index {
        case 0:
            animateView.moveX(200).duration(1.0).easing(.linear).reverses().animate()
        case 1:
            animateView.moveX(200).duration(1.0).easing(.swiftOut).reverses().animate()
        case 2:
            animateView.moveX(200).duration(1.0).easing(.backEaseIn).reverses().animate()
        case 3:
            animateView.moveX(200).duration(1.0).easing(.backEaseOut).reverses().animate()
        default:
            print("")
        }

    }
    @IBAction func segment3ValueChanged(_ sender: UISegmentedControl) {
        animateView.frame = CGRect(x: 20,y: 120,width: 40,height: 40)
        let index = sender.selectedSegmentIndex;
        
        switch index {
        case 0:
            animateView.moveX(200).duration(1.0).easing(.backEaseInOut).reverses().animate()
        case 1:
            animateView.moveX(200).duration(1.0).easing(.bounceOut).reverses().animate()
        case 2:
            animateView.moveX(200).duration(1.0).easing(.sine).reverses().animate()
        case 3:
            animateView.moveX(200).duration(1.0).easing(.circ).reverses().animate()
        default:
            print("")
        }

    }
    
    @IBAction func segment4ValueChanged(_ sender: UISegmentedControl) {
        animateView.frame = CGRect(x: 20,y: 120,width: 40,height: 40)
        let index = sender.selectedSegmentIndex;
        
        switch index {
        case 0:
            animateView.moveX(200).duration(1.0).easing(.exponentialIn).reverses().animate()
        case 1:
            animateView.moveX(200).duration(1.0).easing(.exponentialOut).reverses().animate()
        case 2:
            animateView.moveX(200).duration(1.0).easing(.elasticIn).reverses().animate()
        case 3:
            animateView.moveX(200).duration(1.0).easing(.elasticOut).reverses().animate()
        default:
            print("")
        }
        
    }
    
    @IBAction func segment5ValueChanged(_ sender: UISegmentedControl) {
        animateView.frame = CGRect(x: 20,y: 120,width: 40,height: 40)
        let index = sender.selectedSegmentIndex;
        
        switch index {
        case 0:
            animateView.moveX(200).duration(1.0).easing(.bounceReverse).reverses().animate()
        case 1:
            100.0.animate(to: 200, duration: 1.0, delay: 0.0, type: .swiftOut, autoreverses: false, repeatCount: 0, render: { (d) in
                print("current value is \(d)")
            }, completion: nil)
        case 2:
            100.0.attachment(to: 200, render: { (d) in
                print("current value is \(d)")
            })
            
        case 3:
            fallthrough
        default:
            print("")
        }
        
    }
}
