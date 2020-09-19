//
//  RotationViewController.swift
//  CGAffineTransformDemo
//
//  Created by Arun on 5/3/17.
//  Copyright © 2017 Arun Gupta. All rights reserved.
//

import UIKit

class RotationViewController: UIViewController {

    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func performRotationAnimation(_ sender: UIButton) {
        UIView.animate(withDuration: 0.7, animations: {
                self.lbl1.transform = CGAffineTransform(rotationAngle: RotationViewController.degreesToRadians(degree: -90))
                self.lbl2.transform = CGAffineTransform(rotationAngle: RotationViewController.degreesToRadians(degree: 270))
        }, completion: { finished in
            UIView.animate(withDuration: 0.5, animations: {
                self.lbl1.transform = CGAffineTransform.identity
                self.lbl2.transform = CGAffineTransform.identity
            })
        })
    }
    
    static func degreesToRadians(degree: CGFloat) -> CGFloat {
        return degree * CGFloat(Double.pi)/180
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
