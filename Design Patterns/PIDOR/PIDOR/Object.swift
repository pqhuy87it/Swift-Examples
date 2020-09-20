//
//  Pidor.swift
//  PIDOR
//
//  Created by Alexander on 3/1/17.
//  Copyright © 2017 ApplePride. All rights reserved.
//

import Foundation
import UIKit

class Question {
    
    init(text: String? = nil, imageNames: [String]) {
        self.text = text
        self.imageNames = imageNames
    }
    
    let text: String?
    let imageNames: [String]
}

class Pidor {
    
    init(questions: [Question]) {
        self.questions = questions
    }
    
    let questions: [Question]
    var answers = [Bool]()
}




