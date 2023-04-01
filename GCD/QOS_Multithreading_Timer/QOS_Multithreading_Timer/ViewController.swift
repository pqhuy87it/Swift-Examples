//
//  ViewController.swift
//  QOS_Multithreading_Timer
//
//  Created by Pham Quang Huy on 2023/04/01.
//

import UIKit

class ViewController: UIViewController {
    
    let pServices = PeriodicService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnRunDidTap(_ sender: Any) {
        pServices.start()
    }
    
    @IBAction func btnStopDidTap(_ sender: Any) {
        pServices.cancel()
    }
}

