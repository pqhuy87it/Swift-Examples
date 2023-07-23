//
//  CustomView.swift
//  StaskView
//
//  Created by Julio Collado on 7/25/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class CustomView: UIView {

    @IBOutlet weak var label: UILabel!
    //@IBOutlet var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    

}
