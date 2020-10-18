//
//  ViewController.swift
//  RoutersWithPoP
//
//  Created by Pham Quang Huy on 8/4/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Alamofire.request(Router.Dog.get(params: "")).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

