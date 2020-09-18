//
//  ConfirmDialogViewController.swift
//  ConfirmDialogViewController
//
//  Created by Pham Quang Huy on 2/6/18.
//  Copyright © 2018 Pham Quang Huy. All rights reserved.
//

import UIKit

class ConfirmDialogViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var caution: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var checkBoxLabel: UILabel!
    @IBOutlet weak var labelForCancel: UIButton!
    @IBOutlet weak var labelForOk: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func cancelButtonPushed(_ sender: UIButton) {
        self.dismiss(animated: true) {
        }
    }
    
    @IBAction func okButtonPushed(_ sender: UIButton) {
        self.dismiss(animated: true) {
        }
    }
    
    @IBAction func checkBoxButtonPushed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
    }
}
