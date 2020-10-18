//
//  FoodService.swift
//  ProtocolUnitTest
//
//  Created by Pham Quang Huy on 8/31/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import Foundation

protocol FoodService {
    func cook()
    func makeFood()
}

extension FoodService {
    func cook() {
        makeFood()
    }
    
    func makeFood() {
        print("Makeing food...")
    }
}

class MockFoodService: FoodService {
    var foodWasCook = false
    
    func makeFood() {
        foodWasCook = true
    }
}
