//
//  CombinationViewController.swift
//  CGAffineTransformDemo
//
//  Created by Arun on 5/3/17.
//  Copyright © 2017 Arun Gupta. All rights reserved.
//

import UIKit

class CombinationViewController: UIViewController {

    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func performAnimation(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0, animations: {
            var transform = CGAffineTransform.identity
            transform = transform.translatedBy(x: 0, y: 80)
            transform = transform.scaledBy(x: 3, y: 3)
            transform = transform.rotated(by: RotationViewController.degreesToRadians(degree: 180))
            
            self.lbl1.layer.setAffineTransform(transform)
            
            var transform1 = CGAffineTransform.identity
            transform1 = transform1.translatedBy(x: 0, y: -80)
            transform1 = transform1.scaledBy(x: 2, y: 2)
            transform1 = transform1.rotated(by: RotationViewController.degreesToRadians(degree: 180))
            self.lbl2.layer.setAffineTransform(transform1)
        }, completion: { finished in
            UIView.animate(withDuration: 1.0, animations: {
                self.lbl1.transform = CGAffineTransform.identity
                self.lbl2.transform = CGAffineTransform.identity
            })
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
