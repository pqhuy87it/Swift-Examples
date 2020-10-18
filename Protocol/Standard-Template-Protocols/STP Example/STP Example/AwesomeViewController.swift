//
//  AwesomeViewController.swift
//  STP Example
//
//  Created by Chris O'Neil on 10/22/15.
//  Copyright © 2015 Because. All rights reserved.
//

import UIKit
import STP

class MyAwesomeView: UIView, Moveable, Pinchable, Rotatable, Tappable, Forceable {}

class AwesomeViewController: UIViewController {

    let awesomeView = MyAwesomeView()
    var types:[GestureRecognizerType]?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    convenience init(types:[GestureRecognizerType]) {
        self.init(nibName: nil, bundle: nil)
        self.types = types
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "Your Custom View"

        let awesomeView = MyAwesomeView(frame: CGRect(x: 0.0, y: 0.0, width: 150.0, height: 150.0))
        awesomeView.center = self.view.center
        awesomeView.backgroundColor = UIColor.blue
        self.view.addSubview(awesomeView)

        for type in self.types! {
            switch type {
            case .Moveable:
                awesomeView.makeMoveable()
            case .Pinchable:
                awesomeView.makePinchable()
            case .Rotatable:
                awesomeView.makeRotatable()
            case .Tappable:
                awesomeView.makeTappable()
            case .Forceable:
                awesomeView.makeForceable()
            }
        }
    }
}
