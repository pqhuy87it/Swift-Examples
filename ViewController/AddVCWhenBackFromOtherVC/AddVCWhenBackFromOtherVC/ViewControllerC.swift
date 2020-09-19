//
//  ViewControllerC.swift
//  AddVCWhenBackFromOtherVC
//
//  Created by Exlinct on 11/22/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import UIKit

protocol ViewControllerCDelegate: class {
    func changeDataViewControllerC(data: String)
}

class ViewControllerC: UIViewController {
    weak var delegate: ViewControllerCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var viewcontrollers = self.navigationController?.viewControllers
        
        let viewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "viewControllerB") as! ViewControllerB
        self.delegate = viewcontroller
        viewcontrollers?.insert(viewcontroller, at: 1)
        navigationController?.setViewControllers(viewcontrollers!, animated: true)
    }

    @IBAction func buttonPressed(sender: AnyObject) {
        delegate?.changeDataViewControllerC(data: "hi")
        navigationController?.popViewController(animated: true)
    }
    
}
