//
//  MWSFontDetailVC.swift
//  MWSFonts
//
//  Created by Eric Turner on 2/5/15.
//  Copyright (c) 2015 MagicWave Software. All rights reserved.
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit


class MWSFontDetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet var lblPointSize: UILabel!
    @IBOutlet var slider:       UISlider!
    @IBOutlet var tableView:    UITableView!
    @IBOutlet var textfield:    UITextField!
    
    var fontFamily: MWSFontFamily?
    fileprivate var fonts:[String]! = [String]()
    
    fileprivate let cellId = "FontCell_ID"
    fileprivate let kTextLoremIpsum = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor " + 
    "incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco " +
    "laboris nisi ut aliquip ex ea commodo consequat."
   
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
        
        tableView.estimatedRowHeight = 200.0 //44.0
        tableView.rowHeight = UITableView.automaticDimension

        updatePlaceholderText()
        textfield.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        if let fontFam = fontFamily {
            fonts = fontFamily!.fontNames
            self.title = "\(fontFam.familyName) (\(fonts.count))"
            updateFontSizeLabel()
        } else {
            /// On iPad, at launch, part of the detailVC view is displayed
            /// before a font family is selected from the masterVC
            self.title = "Font Family Not Selected"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// On iPhone, when a font family is selected from the masterVC,
        /// the tableView automatic row heights are set so that the cell
        /// labels are squashed a bit, i.e., there isn't a nice separation
        /// between the text at the bottom of the cell label and the 
        /// section title of the cell below.
        ///
        /// A call to update the cells, which also reloads the table, with
        /// a very short delay, lays out the cells properly.
        ///
        /// This issue does not occur on the iPad. Moreover, on the iPad,
        /// because the detailVC loads immediately before the fontFamily
        /// datasource var is set, without the check for fonts.isEmpty, the 
        /// app will crash in the configureCellAtIndexPath() method.
        let delay = Int64(0.05 * Double(NSEC_PER_SEC))
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)) { 
            if (!self.fonts.isEmpty) {
                self.updateVisibleCells()
                self.updatePlaceholderText()
            }
        }
    }
    
    //MARK: Document this 
    func hasFonts() -> Bool {
        return !fonts.isEmpty
    }

    
    //MARK: Textfield Methods
    
    /// Listen for a "clear button", i.e. empty text change to update cells.
    /// Otherwise, we only update in shouldReturn - not for every char entered.
    @objc func textFieldDidChange(_ textfield: UITextField) {
        //LOG
//        println("textfield.text changed to \(textfield.text)")
        if textfield.text == nil || (textfield.text?.isEmpty)! {
            updateVisibleCells()
        }
    }
    
    // Keyboard Done key handler
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfield.resignFirstResponder()
        updateVisibleCells()
        return true
    }
    
    func updatePlaceholderText() {
        if !fonts.isEmpty {
            let fWord = (fonts.count > 1) ? "fonts" : "font"
            // Reduce length of text for iPhone
            if (traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.compact) {
                textfield.placeholder = "Enter text, then update with Done key."
            } else {
                textfield.placeholder = "Enter text for display in \(fWord). Update with Done key."
            }
        } else {
            textfield.placeholder = "No font family selected."
        }
        
    }
    
    
    //MARK: Font Size Slider Methods
    
    @IBAction func handleSliderValueChanged() {
        if fonts.isEmpty {
            return
        }
        updateVisibleCells()
        updateFontSizeLabel()
    }
    
    func updateFontSizeLabel() {
        if !fonts.isEmpty {
//            println(NSString(format: "%.01f", slider.value))
            lblPointSize.text = (NSString(format: "%.01f", slider.value) as String)
        }
    }
    
    
    //MARK: Cell Utilites
    
    func configureCellAtIndexPath(_ cell: inout UITableViewCell, ip: IndexPath) {
        cell.textLabel!.text = cellTextForIndexPath(ip)
        cell.textLabel!.numberOfLines = 0
        cell.textLabel!.font = UIFont(name: fonts[(ip as NSIndexPath).section], size: CGFloat(slider.value))
    }
    
    func updateVisibleCells() {
        let visibleCells = tableView.visibleCells
        for idx in 0..<visibleCells.count {
            var cell = visibleCells[idx] 
            if let ip = tableView.indexPath(for: cell) {
                configureCellAtIndexPath(&cell, ip: ip)
            }
        }
        tableView.reloadData()
    }

    func cellTextForIndexPath(_ indexPath: IndexPath) -> String {
        if textfield.text != nil && !textfield.text!.isEmpty { 
            return textfield.text!
        }
        return kTextLoremIpsum
    }

    func cellForEmptyTable() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)!
        cell.textLabel?.text = "No font selection..."
        cell.textLabel?.textColor = UIColor.lightGray
        return cell
    }
    
    
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let count = fonts.count
        return (count > 0) ? count : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (fonts.isEmpty) ? nil : fonts[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if fonts.isEmpty {
            return cellForEmptyTable()
        }
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) 
        configureCellAtIndexPath(&cell, ip: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    //MARK: UIViewController
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        updatePlaceholderText()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

