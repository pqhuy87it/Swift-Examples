//
//  ViewControllerB.swift
//  AddVCWhenBackFromOtherVC
//
//  Created by Exlinct on 11/22/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import UIKit

class ViewControllerB: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
    func setDelegate(viewControllerC: ViewControllerC) {
//        viewControllerC.delegate = self
        let viewControllerC = self.storyboard?.instantiateViewController(withIdentifier: "") as! ViewControllerC
        viewControllerC.delegate = self
    }
}

extension ViewControllerB: ViewControllerCDelegate {
    func changeDataViewControllerC(data: String) {
        print(data)
    }
}
