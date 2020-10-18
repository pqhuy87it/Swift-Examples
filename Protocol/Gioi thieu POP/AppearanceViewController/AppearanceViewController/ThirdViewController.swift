//
//  ThirdViewController.swift
//  AppearanceViewController
//
//  Created by Huy Pham on 6/30/17.
//  Copyright © 2017 Huy Pham. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Third ViewController"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ThirdViewController: AppearanceViewController {
    func navigationControllerAppearance() -> Appearance? {
        var value = Appearance()
        
        value.navigationBar.backgroundColor = UIColor.yellow
        value.navigationBar.tintColor = UIColor.blue
        value.statusBarStyle = .lightContent
        
        return value
    }
}
