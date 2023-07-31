//
//  Ingredient.swift
//  FoodCourt
//
//  Created by Максим Бойчук on 03.05.2020.
//  Copyright © 2020 Maksim Boichuk. All rights reserved.
//

import Foundation

public struct Ingredient {
    private let name: String
    private let amount: Int
    private let measure: String
    
    init(name: String, amount: Int, measure: String) {
        self.name = name
        self.amount = amount
        self.measure = measure
    }
    
    func getName() -> String { return name }
    func getAmount() -> Int { return amount }
    func getMeasure() -> String { return measure }
}
