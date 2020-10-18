//: Playground - noun: a place where people can play

import UIKit

enum DrinkSize {
    case Small
    case Normal
    case Tall
}

protocol Drink {
    var volume: Double {get set}
    var temperature: Double {get set}
    var drinkSize: DrinkSize {get set}
    var sugar: Double {get set}
    
    mutating func drinking(amount: Double)
    mutating func temperatureChange(change: Double)
}

struct Coke: Drink {
    var volume: Double
    var temperature: Double
    var drinkSize: DrinkSize
    var sugar: Double
    
    mutating func drinking(amount: Double) {
        self.volume -= amount
    }
    
    mutating func temperatureChange(change: Double) {
        self.temperature += change
    }
}

struct DietCoke: Drink {
    var volume: Double
    var temperature: Double
    var drinkSize: DrinkSize
    var sugar: Double
    
    init(volume: Double, temperature: Double, drinkSize: DrinkSize) {
        self.volume = volume
        self.temperature = temperature
        self.drinkSize = drinkSize
        self.sugar = 0.0
    }
    
    mutating func drinking(amount: Double) {
        self.volume -= amount
    }
    
    mutating func temperatureChange(change: Double) {
        self.temperature += change
    }
}

class Fridge {
    var temperature: Double
    var drinks = [Drink]()
    var maxCans: Int
    
    init(temperature: Double, maxCans: Int) {
        self.temperature = temperature
        self.maxCans = maxCans
    }
    
    func addCoke(coke: Drink) -> Bool {
        if self.drinks.count >= maxCans {
            return false
        }
        
        self.drinks.append(coke)
        return true
    }
    
    func removeCoke() -> Drink? {
        if self.drinks.count <= 0 {
            return nil
        }
        
        return drinks.removeFirst()
    }
}

let coke = Coke(volume: 330.0, temperature: 27.0, drinkSize: .Tall, sugar: 50.0)
let dietCoke = DietCoke(volume: 330.0, temperature: 27.0, drinkSize: .Normal)
let fridge = Fridge(temperature: 10.0, maxCans: 6)
fridge.addCoke(coke)
fridge.addCoke(dietCoke)
