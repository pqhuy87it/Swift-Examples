//
//  ViewControllerA.swift
//  AddVCWhenBackFromOtherVC
//
//  Created by Exlinct on 11/22/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import UIKit

class ViewControllerA: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func buttonPressed(sender: AnyObject) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "viewControllerC") as! ViewControllerC
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}
