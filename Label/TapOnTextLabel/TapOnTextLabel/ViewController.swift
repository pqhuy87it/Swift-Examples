//
//  ViewController.swift
//  TapOnTextLabel
//
//  Created by Pham Quang Huy on 5/2/18.
//  Copyright © 2018 Pham Quang Huy. All rights reserved.
//

// https://stackoverflow.com/questions/36043006/swift-tap-on-a-part-of-text-of-uilabel

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblTermsOfUse: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let text = "Please agree for Terms & Conditions, Privacy Policy"
        
        self.lblTermsOfUse.textColor =  UIColor.black
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: "Terms & Conditions")
        let range2 = (text as NSString).range(of: "Privacy Policy")
        
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.font,
                                          value: UIFont.systemFont(ofSize: 20),
                                          range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor,
                                          value: UIColor.blue,
                                          range: range1)
        
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: range2)
        underlineAttriString.addAttribute(NSAttributedString.Key.font,
                                          value: UIFont.systemFont(ofSize: 20),
                                          range: range2)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor,
                                          value: UIColor.blue,
                                          range: range2)
        
        lblTermsOfUse.attributedText = underlineAttriString
        lblTermsOfUse.isUserInteractionEnabled = true
        lblTermsOfUse.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel(_:))))
    }
    
    @objc func handleTapOnLabel(_ recognizer: UITapGestureRecognizer) {
        guard let text = lblTermsOfUse.attributedText?.string else {
            return
        }
        
        if let range = text.range(of: NSLocalizedString("Terms & Conditions", comment: "Terms & Conditions")),
           recognizer.didTapAttributedTextInLabel(label: lblTermsOfUse, inRange: NSRange(range, in: text)) {
            goToTermsAndConditions()
        } else if let range = text.range(of: NSLocalizedString("Privacy Policy", comment: "Privacy Policy")),
                  recognizer.didTapAttributedTextInLabel(label: lblTermsOfUse, inRange: NSRange(range, in: text)) {
            goToPrivacyPolicy()
        }
    }
    
    func goToTermsAndConditions() {
        print("Terms & Conditions")
    }
    
    func goToPrivacyPolicy() {
        print("Privacy Policy")
    }
}

extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        guard let attrString = label.attributedText else {
            return false
        }
        
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: .zero)
        let textStorage = NSTextStorage(attributedString: attrString)
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
