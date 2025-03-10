//
//  ViewController.swift
//  Attachments
//
//  Created by Oliver Drobnik on 01/09/2016.
//  Copyright © 2016 Cocoanetics. All rights reserved.
//

import UIKit
import UIKit.NSTextAttachment

class ViewController: UIViewController
{
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
		
		
//		let image = UIImage(named: "cocoanetics")
//		let attachment = NSTextAttachment()
//		attachment.image = image
//		attachment.bounds = CGRect(x: 0, y: 0, width: 100, height: 134)
//		
//		let attributedString = NSAttributedString(attachment: attachment)
//		textView.attributedText = attributedString
		
		let imageURL = URL(string: "https://www.cocoanetics.com/files/Cocoanetics_Square.jpg")!
        let attachment = AsyncTextAttachment(imageURL: imageURL)
        attachment.delegate = self
//        attachment.displaySize = CGSize(width: 100, height: 134)
//        attachment.image = UIImage.placeholder(UIColor.grayColor(), size: attachment.displaySize!)
        let attachmentStr = NSAttributedString(attachment: attachment)
		
        textView.attributedText = attachmentStr
    }
	

}

extension ViewController: UITextViewDelegate
{
    @available(iOS 10.0, *)
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool
    {
        return true
    }
}

extension ViewController: AsyncTextAttachmentDelegate
{
    func textAttachmentDidLoadImage(textAttachment: AsyncTextAttachment, displaySizeChanged: Bool)
    {
        if displaySizeChanged
        {
            textView.layoutManager.setNeedsLayout(forAttachment: textAttachment)
        }
        
        // always re-display, the image might have changed
        textView.layoutManager.setNeedsDisplay(forAttachment: textAttachment)
    }
}

