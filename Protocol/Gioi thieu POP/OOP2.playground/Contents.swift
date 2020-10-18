//: Playground - noun: a place where people can play

import UIKit

enum DrinkSize {
    case Small
    case Normal
    case Tall
}

class Drink {
    var volume: Double
    var temperature: Double
    var drinkSize: DrinkSize
    var sugar: Double
    
    init(volume: Double, temperature: Double, drinkSize: DrinkSize, sugar: Double) {
        self.volume = volume
        self.temperature = temperature
        self.drinkSize = drinkSize
        self.sugar = sugar
    }
    
    func drinking(amount: Double) {
        self.volume -= amount
    }
    
    func temperatureChange(change: Double) {
        self.temperature += change
    }
}

class Coke: Drink {
    
}

class DietCoke: Drink {
    init (volume: Double, temperature: Double, drinkSize: DrinkSize) {
        super.init(volume: volume, temperature: temperature, drinkSize: drinkSize, sugar: 0.0)
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