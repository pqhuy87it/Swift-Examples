//
//  ViewController.swift
//  TestDatePickerView
//
//  Created by Huy Pham Quang on 8/4/18.
//  Copyright © 2018 Huy Pham Quang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!

    private lazy var datePickerView: DatePickerInputView? = {
        return DatePickerInputView.instanceFromNib()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.textField.inputView = datePickerView
        self.datePickerView?.setModeDatePicker(datePickerMode: .yearMonthDayJP)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

