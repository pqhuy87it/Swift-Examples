//
//  ViewController.swift
//  DetectTouchEvent
//
//  Created by Exlinct on 4/23/17.
//  Copyright © 2017 Framgia, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let detectTapView = DetectTapView(frame: view.bounds)
        detectTapView.delegate = self
        self.view.addSubview(detectTapView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: DetectTapViewDelegate {
    func handleSingleTap(view: UIView, touch: UITouch) {
        print("single tap")
    }
    
    func handleDoubleTap(view: UIView, touch: UITouch) {
        print("double tap")
    }
}