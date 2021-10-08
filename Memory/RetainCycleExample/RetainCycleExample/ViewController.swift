//
//  ViewController.swift
//  RetainCycleExample
//
//  Created by HuyPQ22 on 2021/09/29.
//

import UIKit

class A {
    var name: String
    var b: B?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("A is deinit")
    }
}

class B {
    var name: String
    // var a: A?
    weak var a: A?
    
    init(name: String) {
        self.name = name
    }
    
    func callA() {
        print("A name is \(a!.name)")
    }
    
    deinit {
        print("B is deinit")
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func testPressed(_ sender: Any) {
        test()
    }
    
    func test() {
        let a = A(name: "A")
        let b = B(name: "B")
        
        a.b = b
        b.a = a
        
        b.callA()
    }

}

