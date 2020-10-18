//: Playground - noun: a place where people can play

import UIKit

protocol Food {
    func beComsumedBy<T: FoodConsumer>(_ consumer: T, grams: Double) -> T
}

protocol FoodConsumer {
    var calorieCount: Double {get set}
    var hydrationLevel: Double {get set}
}

extension FoodConsumer {
    func eat(_ food: Food, grams: Double) -> Self {
        return food.beComsumedBy(self, grams: grams)
    }
}

struct Kibble: Food {
    let caloriesPerGram: Double = 40.0
    
    func beComsumedBy<T : FoodConsumer>(_ consumer: T, grams: Double) -> T {
        var newConsumer = consumer
        newConsumer.calorieCount += caloriesPerGram * grams
        return newConsumer
    }
}

struct FancyFeast: Food {
    let caloriesPerGram: Double = 80.0
    let milliLitresWaterPerGram: Double = 0.2
    
    func beComsumedBy<T : FoodConsumer>(_ consumer: T, grams: Double) -> T {
        var newConsumer = consumer
        newConsumer.calorieCount += caloriesPerGram * grams
        newConsumer.hydrationLevel += milliLitresWaterPerGram * grams
        return newConsumer
    }
}

struct Cat: FoodConsumer {
    var calorieCount: Double = 0.0
    var hydrationLevel: Double = 0.0
}

let catFood = Kibble()
let wetFood = FancyFeast()
let cat = Cat()

let caloEatCatFood = cat.eat(catFood, grams: 100.0)
print(caloEatCatFood)
let caloEatWetFood = cat.eat(wetFood, grams: 200.0)
print(caloEatWetFood)
