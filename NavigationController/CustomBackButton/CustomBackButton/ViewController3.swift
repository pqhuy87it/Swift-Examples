//
//  ViewController3.swift
//  CustomBackButton
//
//  Created by HuyPQ22 on 2021/08/20.
//  Copyright © 2021 Pham Quang Huy. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.addNavigationBarButton(imageName: "back-button-blue", direction: .left)
    }
    

    func addNavigationBarButton(imageName:String,direction:direction){
        var image = UIImage(named: imageName)
        image = image?.withRenderingMode(.alwaysOriginal)
        switch direction {
        case .left:
           self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: self, action: #selector(goBack))
        case .right:
           self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: self, action: #selector(goBack))
        }
    }

    @objc func goBack() {
        print("did tap back button")
        navigationController?.popViewController(animated: true)
    }

    enum direction {
        case right
        case left
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
