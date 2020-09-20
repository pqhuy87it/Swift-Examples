//
//  ViewController.swift
//  hkPraesidium
//
//  Created by Anderson Santos Gusmao on 06/10/17.
//  Copyright © 2017 Heuristisk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userIdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onChangeSwitch(_ sender: Any) {
        if let switchControl = sender as? UISwitch {
            Api.isSSLPinningEnabled = switchControl.isOn
        }
    }
    
    @IBAction func onPressLogin(_ sender: Any) {
        
        if let userId = userIdTextField.text, let password = passwordTextField.text {
            Api().authenticate(userId: userId, password: password, callback: { (response, hasError) in
                
                if (hasError) {
                    self.alert(message: "Failed to connect", title: "Error")
                }
                
                DispatchQueue.main.async(execute: {
                    self.outputTextView.text = response
                })
            })
        }
    }
}

extension UIViewController {
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
