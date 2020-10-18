//: Playground - noun: a place where people can play

import UIKit

protocol Themeable {
    func applyTheme()
}

extension Themeable where Self: UIViewController {
    func applyTheme() {
        // beautiful!
        navigationItem.leftBarButtonItem?.tintColor = .purpleColor()
    }
}

class ThemedViewController: UIViewController, Themeable {
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
    }
}
