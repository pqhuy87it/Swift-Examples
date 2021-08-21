//
//  CustomSearchBar.swift
//  CustomSearchBar
//
//  Created by Gabriel Theodoropoulos on 8/9/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {
    
    var preferredFont: UIFont!
    
    var preferredTextColor: UIColor!
    
    var preferredBackgroundColor: UIColor!
    
    var placeholderTextColor: UIColor!
    
    var placeholderFont: UIFont!
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        if let searchTextField = self.value(forKey: "searchField") as? UITextField {
            // Set its frame.
            searchTextField.frame = CGRect(x: 5.0,
                                           y: 5.0,
                                           width: frame.size.width - 10.0,
                                           height: frame.size.height - 10.0)
            // Set the background color of the search field.
            searchTextField.textColor =  preferredTextColor
            searchTextField.textAlignment = .left
            searchTextField.layer.cornerRadius = 6
            searchTextField.clipsToBounds = true
            
            // Set the font and text color of the search field.
            searchTextField.font = placeholderFont
            searchTextField.attributedPlaceholder = NSAttributedString(string: searchTextField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: placeholderTextColor!])
            
            if let backgroundView = searchTextField.subviews.first {
                backgroundView.backgroundColor = preferredBackgroundColor
            }
        }
        
        let startPoint = CGPoint(x: 0.0, y: frame.size.height)
        let endPoint = CGPoint(x: frame.size.width, y: frame.size.height)
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        // orange line below search bar
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = preferredTextColor.cgColor
        shapeLayer.lineWidth = 2.5
        
        layer.addSublayer(shapeLayer)
        
        super.draw(rect)
    }
    
    
    
    init(frame: CGRect,
         font: UIFont,
         textColor: UIColor,
         backgroundColor: UIColor = UIColor.lightGray,
         placeholderFont: UIFont = UIFont.systemFont(ofSize: 14),
         placeholderTextColor: UIColor = UIColor.purple) {
        super.init(frame: frame)
        
        self.frame = frame
        self.preferredFont = font
        self.preferredTextColor = textColor
        self.preferredBackgroundColor  = backgroundColor
        self.placeholderFont = placeholderFont
        self.placeholderTextColor = placeholderTextColor
            
        searchBarStyle = UISearchBar.Style.prominent
        isTranslucent = false
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
