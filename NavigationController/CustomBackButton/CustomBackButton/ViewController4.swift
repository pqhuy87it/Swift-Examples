//
//  ViewController4.swift
//  CustomBackButton
//
//  Created by HuyPQ22 on 2021/08/21.
//  Copyright © 2021 Pham Quang Huy. All rights reserved.
//

import UIKit

class ViewController4: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let view = UIView()
            let button = UIButton(type: .system)
            button.setImage(UIImage(named: "Menu"), for: .normal)
            button.setTitle("Back to workflow", for: .normal)
            button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
            button.sizeToFit()
            view.addSubview(button)
            view.frame = button.bounds
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: view)
    }
    
    @objc func goBack() {
        print("did tap back button")
        navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
