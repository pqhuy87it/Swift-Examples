//: Playground - noun: a place where people can play

import UIKit

enum DrinkSize {
    case Small
    case Normal
    case Tall
}

class Coke {
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

class Fridge {
    var temperature: Double
    var cokes = [Coke]()
    var maxCans: Int
    
    init(temperature: Double, maxCans: Int) {
        self.temperature = temperature
        self.maxCans = maxCans
    }
    
    func addCoke(coke: Coke) -> Bool {
        if self.cokes.count >= maxCans {
            return false
        }
        
        self.cokes.append(coke)
        return true
    }
    
    func removeCoke() -> Coke? {
        if self.cokes.count <= 0 {
            return nil
        }
        
        return cokes.removeFirst()
    }
}

let coke = Coke(volume: 330.0, temperature: 27.0, drinkSize: DrinkSize.Tall, sugar: 50.0)
let fridge = Fridge(temperature: 10.0, maxCans: 6)
fridge.addCoke(coke)

class DietCoke {
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

let dietCoke = DietCoke(volume: 330.0, temperature: 27.0, drinkSize: DrinkSize.Normal, sugar: 0.0)


