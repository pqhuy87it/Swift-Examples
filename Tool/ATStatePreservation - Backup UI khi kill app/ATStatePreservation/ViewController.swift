//
//  ViewController.swift
//  ATStatePreservation
//
//  Created by Dejan on 03/11/2018.
//  Copyright © 2018 agostini.tech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textField: UITextField!

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        self.sliderLabel.text = "\(sender.value)"
    }
    
    private enum CodingKey: String {
        case SelectedSegment
        case SliderLabel
        case SliderValue
        case TextFieldValue
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        
        coder.encode(self.segmentedControl.selectedSegmentIndex, forKey: CodingKey.SelectedSegment.rawValue)
        coder.encode(self.sliderLabel.text, forKey: CodingKey.SliderLabel.rawValue)
        coder.encode(self.slider.value, forKey: CodingKey.SliderValue.rawValue)
        coder.encode(self.textField.text, forKey: CodingKey.TextFieldValue.rawValue)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        
        self.segmentedControl.selectedSegmentIndex = coder.decodeInteger(forKey: CodingKey.SelectedSegment.rawValue)
        self.sliderLabel.text = coder.decodeObject(forKey: CodingKey.SliderLabel.rawValue) as? String
        self.slider.value = coder.decodeFloat(forKey: CodingKey.SliderValue.rawValue)
        
        if let value = coder.decodeObject(forKey: CodingKey.TextFieldValue.rawValue) as? String {
            self.textField.text = value
            self.textField.becomeFirstResponder()
        }
    }
    
    override func applicationFinishedRestoringState() {
        super.applicationFinishedRestoringState()
        print("Finished restoring state")
    }
}

