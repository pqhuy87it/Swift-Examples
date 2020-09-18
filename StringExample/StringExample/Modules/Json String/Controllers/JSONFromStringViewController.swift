//
//  JSONFromStringViewController.swift
//  StringExample
//
//  Created by iMac07 on 2020/09/13.
//  Copyright © 2020 Pham Quang Huy. All rights reserved.
//

import UIKit

class JSONFromStringViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		if let str = self.createJsonString() {
			print(str)
		}
    }
    
	func createJsonString() -> String? {
		do {
			let obj = ["name" : "moke", "age" : 2] as [String : Any]
			
			let jsonData = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
			
			let jsonString = String(data: jsonData, encoding: .utf8)!
			
			return jsonString
		} catch {
			print(error)
		}
		
		return nil
	}

}
