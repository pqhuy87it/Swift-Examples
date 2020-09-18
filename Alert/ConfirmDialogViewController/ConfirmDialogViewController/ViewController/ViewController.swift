//
//  ViewController.swift
//  ConfirmDialogViewController
//
//  Created by Pham Quang Huy on 2/6/18.
//  Copyright © 2018 Pham Quang Huy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnShowPressed(_ sender: Any) {
        let confirmDialogViewController = ConfirmDialogViewController(nibName: "ConfirmDialogViewController", bundle: nil)
        self.present(confirmDialogViewController, animated: true, completion: nil)
    }
    
}

