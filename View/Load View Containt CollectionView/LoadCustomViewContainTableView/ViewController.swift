//
//  ViewController.swift
//  LoadCustomViewContainTableView
//
//  Created by Exlinct on 8/21/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    
    private lazy var customeView: CustomView = {
        var customeView = CustomView()
        customeView = UIView.fromNib()
        customeView.handleAction = {
            print("do something")
        }
        
        self.view.insertSubview(customeView, belowSubview: self.bottomView)
        customeView.translatesAutoresizingMaskIntoConstraints = false
        
        let leading = NSLayoutConstraint(item: customeView, attribute: .leading, relatedBy: .equal, toItem: self.bottomView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailing = NSLayoutConstraint(item: customeView, attribute: .trailing, relatedBy: .equal, toItem: self.bottomView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottom = NSLayoutConstraint(item: customeView, attribute: .bottom, relatedBy: .equal, toItem: self.bottomView, attribute: .top, multiplier: 1.0, constant: CustomView.height)
        let height = NSLayoutConstraint(item: customeView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: CustomView.height)
        
        NSLayoutConstraint.activate([leading, trailing, bottom, height])
        self.view.layoutIfNeeded()
        
        customeView.bottomConstraint = bottom
        
        return customeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func showPressed(sender: AnyObject) {
        customeView.show()
    }
    
    @IBAction func hidePressed(sender: AnyObject) {
        customeView.hide()
    }
    
}

