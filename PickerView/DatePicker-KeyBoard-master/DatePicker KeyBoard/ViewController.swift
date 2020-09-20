//
//  ViewController.swift
//  DatePicker KeyBoard
//
//  Created by Sai Sandeep on 28/08/17.
//  Copyright © 2017 iosRevisited. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var textField = UITextField()
    var datePicker = UIDatePicker()
    var toolBar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createDatePicker()
        createToolBar()
        addTextField()
    }
    
    func addTextField() {
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40.0).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40.0).isActive = true
        textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 40.0).isActive = true
        textField.placeholder = "Select date"
        textField.borderStyle = .roundedRect
        
        textField.inputView = datePicker
        
        textField.inputAccessoryView = toolBar
    }
    
    func createDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(datePicker:)), for: .valueChanged)
    }
    
    func createToolBar() {
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        
        let todayButton = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(todayButtonPressed(sender:)))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed(sender:)))
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width/3, height: 40))
        label.text = "Choose your Date"
        let labelButton = UIBarButtonItem(customView:label)
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolBar.setItems([todayButton,flexibleSpace,labelButton,flexibleSpace,doneButton], animated: true)
    }
    
    @objc func todayButtonPressed(sender: UIBarButtonItem) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        textField.text = dateFormatter.string(from: Date())
        
        textField.resignFirstResponder()
    }
    
    @objc func doneButtonPressed(sender: UIBarButtonItem) {
        textField.resignFirstResponder()
    }
    
    @objc func datePickerValueChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        textField.text = dateFormatter.string(from: datePicker.date)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}








