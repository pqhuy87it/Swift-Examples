//
//  ViewController.swift
//  test certificate pinning
//
//  Created by Antonio Chiappetta on 21/02/2018.
//  Copyright © 2018 Antonio Chiappetta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var provaButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        NetworkManager.sharedInstance.connectToApple()
    }
}
