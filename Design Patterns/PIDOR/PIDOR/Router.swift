//
//  Router.swift
//  PIDOR
//
//  Created by Alexander on 3/1/17.
//  Copyright © 2017 ApplePride. All rights reserved.
//

import UIKit

protocol Routable {
    // me
}

class Router: Routable {
    // home -> your mom
}

protocol Interactable {
    func gayQuestions() -> [Question]
    func getResults() -> Bool
    func setObject(_ pidor:Pidor)
    func setPidorsAnswer(for questionIndex:Int)
    func setNotPidorsAnswer(for questionIndex:Int)
}

protocol Decoratable {
    var handler: GayventHandler? { get set }
    func setImages(_ names:[String])
    func showResults(is pidor:Bool)
}

protocol GayventHandler: class {
    func viewDidLoad()
    func topButtonPressed()
    func bottomButtonPressed()
}
