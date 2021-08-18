//
//  AttributedStringViewController.swift
//  StringExample
//
//  Created by mybkhn on 2021/01/25.
//  Copyright © 2021 Pham Quang Huy. All rights reserved.
//

import UIKit

class AttributedStringViewController: UIViewController {

	@IBOutlet weak var label1: UILabel!
	@IBOutlet weak var label2: UILabel!
	@IBOutlet weak var label3: UILabel!

	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

		customParagraphStyle()
    }
    
	func customParagraphStyle() {
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = 7.0
		paragraphStyle.alignment = .center
		paragraphStyle.lineBreakMode = .byCharWrapping
		paragraphStyle.paragraphSpacing = 10
		paragraphStyle.paragraphSpacingBefore = 30
		paragraphStyle.headIndent = 20

		let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0),
								NSAttributedString.Key.paragraphStyle: paragraphStyle]

		let attributedText = NSMutableAttributedString(string: "Today is monday\nAnd the weather is good",
													   attributes: attributes)
		label1.attributedText = attributedText
	}

}
