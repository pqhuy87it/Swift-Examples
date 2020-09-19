//
//  ScalingViewController.swift
//  CGAffineTransformDemo
//
//  Created by Arun on 4/27/17.
//  Copyright © 2017 Arun Gupta. All rights reserved.
//

import UIKit

class ScalingViewController: UIViewController {

    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func performScalingAnimation(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0, animations: {
            self.lbl1.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            self.lbl2.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }, completion: { finished in
            UIView.animate(withDuration: 1.0, animations: {
                self.lbl1.transform = CGAffineTransform.identity
                self.lbl2.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: { finished in
                
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
