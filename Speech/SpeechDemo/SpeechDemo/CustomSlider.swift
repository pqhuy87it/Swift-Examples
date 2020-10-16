//
//  CustomSlider.swift
//  SpeechDemo
//
//  Created by Gabriel Theodoropoulos on 10/2/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit

class CustomSlider: UISlider {

    var sliderIdentifier: Int!
    
    required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
        
        sliderIdentifier = 0
    }

}
