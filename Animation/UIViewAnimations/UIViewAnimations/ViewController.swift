//
//  ViewController.swift
//  UIViewAnimations
//
//  Created by Anupam Chugh on 18/07/18.
//  Copyright © 2018 JournalDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

var animationRunning = false

@IBOutlet weak var myView: UIView!

@IBAction func animateColor(_ sender: Any) {
    UIView.animate(withDuration: 1, animations: {
        self.myView.backgroundColor = UIColor.black
    }, completion: nil)
}

@IBAction func animateMovement(_ sender: Any) {
    UIView.animate(withDuration: 1, animations: {
        self.myView.frame.origin.x -= 40
    }, completion: nil)
    
}
@IBAction func animateSize(_ sender: Any) {
    UIView.animate(withDuration: 1, animations: {
        self.myView.frame.size.width += 40
        self.myView.frame.size.height += 10
    }){ finished in
        UIView.animate(withDuration: 1, animations: {
            self.myView.frame.size.width -= 40
            self.myView.frame.size.height -= 10
        })
    }
}

@IBAction func animateAllTogether(_ sender: Any) {
    
    if(animationRunning){
        self.myView.layer.removeAllAnimations()
        animationRunning = !animationRunning
    }
    else{
        animationRunning = !animationRunning
    UIView.animate(withDuration: 1, animations: {
        self.myView.backgroundColor = UIColor.green
        self.myView.frame.size.width += 50
        self.myView.frame.size.height += 20
        self.myView.center.x += 20
    }) { _ in
        UIView.animate(withDuration: 1, delay: 0.25, options: [.autoreverse, .repeat], animations: {
            self.myView.frame.origin.y -= 20
        })
    }
    }
    
    
    
}
    @IBOutlet weak var optionsView: UIView!
    @IBAction func transformAnimationWithOptions(_ sender: UIButton!) {
        
        if(sender.tag == 1)
        {
            self.optionsView.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseIn], animations: {
                self.optionsView.transform  = .identity
            })
        }
        else if(sender.tag == 2)
        {
            self.optionsView.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseOut], animations: {
                self.optionsView.transform  = .identity
            })
        }
        else if(sender.tag == 3)
        {
            self.optionsView.transform = CGAffineTransform(scaleX: 0, y: 0)
            
            UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut], animations: {
                self.optionsView.transform  = .identity
            })
        }
        else if(sender.tag == 4)
        {
            self.optionsView.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveLinear], animations: {
                self.optionsView.transform  = .identity
            })
        }
    }
    
    
    @IBAction func springAnimationWithOptions(_ sender: UIButton!) {
        
        if(sender.tag == 1)
        {
            self.optionsView.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.optionsView.transform = .identity
            }, completion: nil)
        }
        else if(sender.tag == 2)
        {
            self.optionsView.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.optionsView.transform = .identity
            }, completion: nil)
        }
        else if(sender.tag == 3)
        {
            self.optionsView.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.optionsView.transform = .identity
            }, completion: nil)
        }
        else if(sender.tag == 4)
        {
            self.optionsView.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
                self.optionsView.transform = .identity
            }, completion: nil)
        }
    }
    
    
    @IBAction func STRAnimationWithOptions(_ sender: UIButton!) {
        
        if(sender.tag == 1)
        {
            //scale
            let scale = CGAffineTransform(scaleX: 2, y: 2)
            self.optionsView.transform = scale
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                self.optionsView.transform = .identity
            }, completion: nil)
        }
        else if(sender.tag == 2)
        {
            //translate
            let translate = CGAffineTransform(translationX: -120, y: -120)
            self.optionsView.transform = translate
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                self.optionsView.transform = .identity
            }, completion: nil)
        }
        else if(sender.tag == 3)
        {
            //rotate
            let rotate = CGAffineTransform(rotationAngle: 360)
            self.optionsView.transform = rotate
            UIView.animate(withDuration: 3, delay: 0, options: .curveEaseInOut, animations: {
                self.optionsView.transform = .identity
            }, completion: nil)
        }
        else if(sender.tag == 4)
        {
            let rotate = CGAffineTransform(rotationAngle: 360)
            let translate = CGAffineTransform(translationX: -120, y: -120)
            let scale = CGAffineTransform(scaleX: 2, y: 2)
            self.optionsView.transform = rotate.concatenating(translate).concatenating(scale)
            UIView.animate(withDuration: 3, delay: 0,usingSpringWithDamping: 0.8,initialSpringVelocity: 0.5, options: [.autoreverse,.curveEaseInOut], animations: {
                self.optionsView.transform = .identity
            }, completion: nil)
        }
    }
    
    
    @IBAction func transitionAnimationWithOptions(_ sender: UIButton!) {
        
        if(sender.tag == 1)
        {
            UIView .transition(with: self.myTextField, duration: 4, options: .transitionCrossDissolve,
                               animations: {
                                self.myTextField.textColor = UIColor.red
            }){finished in
                self.myTextField.textColor = UIColor.white
            }
        }
        else if(sender.tag == 2)
        {
            UIView .transition(with: self.myTextField, duration: 4, options: .transitionFlipFromRight,
                               animations: {
                                self.myTextField.textColor = UIColor.red
            }){finished in
                self.myTextField.textColor = UIColor.white
            }
        }
        else if(sender.tag == 3)
        {
            UIView .transition(with: self.myTextField, duration: 4, options: .transitionCurlUp,
                               animations: {
                                self.myTextField.textColor = UIColor.red
            })
        }
    }
    
    @IBOutlet weak var myTextField: UITextField!
    
override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


}

