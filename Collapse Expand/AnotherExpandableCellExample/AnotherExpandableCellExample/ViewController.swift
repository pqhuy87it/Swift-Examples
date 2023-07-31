//
//  ViewController.swift
//  AnotherExpandableCellExample
//
//  Created by Don Mag on 5/21/20.
//  Copyright © 2020 Don Mag. All rights reserved.
//

import UIKit

class MaxExpandableCell: UITableViewCell {
	
	@IBOutlet var myImageView: UIImageView!
	@IBOutlet var myTitleView: UIView!
	@IBOutlet var myDescView: UIView!
	@IBOutlet var myTitleLabel: UILabel!
	@IBOutlet var myDescLabel: UILabel!
	
	@IBOutlet var collapsedConstraint: NSLayoutConstraint!
	@IBOutlet var expandedConstraint: NSLayoutConstraint!
	
	var isExpanded: Bool = false {
		didSet {
			expandedConstraint.priority = isExpanded ? .defaultHigh : .defaultLow
			collapsedConstraint.priority = isExpanded ? .defaultLow : .defaultHigh
		}
	}
	
}

class TestTableViewController: UITableViewController {
	
	let myData: [[String]] = [
		["Label", "A label can contain an arbitrary amount of text, but UILabel may shrink, wrap, or truncate the text, depending on the size of the bounding rectangle and properties you set. You can control the font, text color, alignment, highlighting, and shadowing of the text in the label."],
		["Button", "You can set the title, image, and other appearance properties of a button. In addition, you can specify a different appearance for each button state."],
		["Segmented Control", "The segments can represent single or multiple selection, or a list of commands.\n\nEach segment can display text or an image, but not both."],
		["Text Field", "Displays a rounded rectangle that can contain editable text. When a user taps a text field, a keyboard appears; when a user taps Return in the keyboard, the keyboard disappears and the text field can handle the input in an application-specific way. UITextField supports overlay views to display additional information, such as a bookmarks icon. UITextField also provides a clear text control a user taps to erase the contents of the text field."],
		["Slider", "UISlider displays a horizontal bar, called a track, that represents a range of values. The current value is shown by the position of an indicator, or thumb. A user selects a value by sliding the thumb along the track. You can customize the appearance of both the track and the thumb."],
		["This cell has a TItle that will wrap onto multiple lines.", "Just to demonstrate that auto-layout is handling text wrapping in the title view."],
	]
	
	var rowState: [Bool] = [Bool]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// initialize rowState array to all False (not expanded
		rowState = Array(repeating: false, count: myData.count)
		
		tableView.register(UINib(nibName: "MaxExpandableCell", bundle: nil), forCellReuseIdentifier: "nibCell")
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return myData.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let nibCell = tableView.dequeueReusableCell(withIdentifier: "nibCell", for: indexPath) as! MaxExpandableCell
		
		nibCell.myImageView.image = UIImage(systemName: "\(indexPath.row).circle")
		nibCell.myTitleLabel.text = myData[indexPath.row][0]
		nibCell.myDescLabel.text = myData[indexPath.row][1]
		nibCell.isExpanded = rowState[indexPath.row]
		
		nibCell.selectionStyle = .none
		
		return nibCell
		
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		guard let c = tableView.cellForRow(at: indexPath) as? MaxExpandableCell else {
			return
		}
		rowState[indexPath.row].toggle()
		tableView.performBatchUpdates({
			c.isExpanded = rowState[indexPath.row]
		}, completion: nil)
		
	}
	
}
