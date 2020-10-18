//
//  Validation.swift
//  TextValidation
//
//  Created by Pham Quang Huy on 8/6/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import Foundation

class AlphaValidation: TextValidationProtocol {
    static let sharedInstance = AlphaValidation()
    
    private init() {
        
    }
    
    let regExFindMatchString = "^[a-zA-Z]{0,10}"
    let validationMessage = "Can only contain Alpha characters"
}

class AlphaNumericValidation: TextValidationProtocol  {
    static let sharedInstance = AlphaNumericValidation()
    
    private init() {
        
    }
    
    let regExFindMatchString = "^[a-zA-Z0-9]{0,10}"
    let validationMessage = "Can only contain Alpha Numeric characters"
}

class NumericValidation: TextValidationProtocol {
    static let sharedInstance = NumericValidation()
    
    private init() {
        
    }
    let regExFindMatchString = "^[0-9]{0,10}"
    let validationMessage = "Can only contain only Alpha and Numeric characters"
}
