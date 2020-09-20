//
//  Interactor.swift
//  PIDOR
//
//  Created by Alexander on 3/1/17.
//  Copyright © 2017 ApplePride. All rights reserved.
//

import UIKit

class Interactor: Interactable {
    
    var pobject:Pidor?
    
    func gayQuestions() -> [Question] {
        
        let q1 = Question(imageNames: ["walk", "gyro"])
        let q2 = Question(imageNames: ["ciga", "vape"])
        let q3 = Question(imageNames: ["beer", "smoothy"])
        
        return [q1, q2, q3]
    }
    
    func getResults() -> Bool {
        var pidor = true
        if let answers = pobject?.answers {
            for answer in answers {
                if answer == false {
                    pidor = answer
                    break
                }
            }
        }
        return pidor
    }
    
    func setObject(_ pidor:Pidor) {
        pidor.answers = [false, false, false]
        self.pobject = pidor
    }
    
    func setPidorsAnswer(for questionIndex:Int) {
        self.pobject?.answers[questionIndex] = true
    }
    
    func setNotPidorsAnswer(for questionIndex:Int) {
        self.pobject?.answers[questionIndex] = false
    }
}
