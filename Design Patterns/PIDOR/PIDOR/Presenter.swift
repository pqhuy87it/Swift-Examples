//
//  ViewController.swift
//  PIDOR
//
//  Created by Alexander on 3/1/17.
//  Copyright © 2017 ApplePride. All rights reserved.
//

import UIKit

class Presenter {
    
    fileprivate var decoratable: Decoratable
    fileprivate let interactable: Interactable
    fileprivate let routable: Routable
    fileprivate var questionIndex = 0
    fileprivate var questions: [Question]?
    
    init(decoratable: Decoratable, interactable: Interactable, routable: Routable) {
        self.decoratable = decoratable
        self.interactable = interactable
        self.routable = routable
        
        self.decoratable.handler = self
    }
}

extension Presenter: GayventHandler {
    
    private func updateImages() {
        if let questions = self.questions {
            if questions.count > questionIndex {
                let img1 = questions[self.questionIndex].imageNames.first!
                let img2 = questions[self.questionIndex].imageNames.last!
                
                self.decoratable.setImages([img1, img2])
            } else {
                self.decoratable.showResults(is: interactable.getResults())
            }
        }
    }
    
    func viewDidLoad() {
        self.questions = self.interactable.gayQuestions()
        if let questions = self.questions {
            self.interactable.setObject(Pidor(questions: questions))
        }
        self.updateImages()
    }
    
    func topButtonPressed() {
        if self.questionIndex == 0 {
            self.interactable.setPidorsAnswer(for:self.questionIndex)
        } else {
            self.interactable.setNotPidorsAnswer(for:self.questionIndex)
        }
        
        self.questionIndex += 1
        self.updateImages()
    }
    
    func bottomButtonPressed() {
        if self.questionIndex != 0 {
            self.interactable.setPidorsAnswer(for:self.questionIndex)
        } else {
            self.interactable.setNotPidorsAnswer(for:self.questionIndex)
        }
        self.questionIndex += 1
        self.updateImages()
    }
}

