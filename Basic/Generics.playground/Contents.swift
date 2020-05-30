//: # Intro to Generics

//: ## Basics and Generics in the Standard Library

//: ### The need for generic functions

func adderInt(x: Int, _ y: Int) -> Int {
  return x + y
}

let intSum = adderInt(x: 1, 2)

func adderDouble(x: Double, _ y: Double) -> Double {
  return x + y
}

let doubleSum = adderDouble(x: 1.0, 2.0)

//: ### Array as a Generic Type

let numbers = [1, 2, 3]

let firstNumber = numbers[0]

var numbersAgain = Array<Int>()
numbersAgain.append(1)
numbersAgain.append(2)
numbersAgain.append(3)

let firstNumberAgain = numbersAgain[0]

// numbersAgain.append("hello") // Cannot add Double to an Int array

//: ### Other Generic Types

let countryCodes = ["Austria": "AT", "United States of America": "US", "Turkey": "TR"]

let at = countryCodes["Austria"]

let optionalName = Optional<String>.some("John")

if optionalName != nil {
}

//: ## Writing a Generic Function

func pairsFromDictionary<KeyType, ValueType>(dictionary: [KeyType: ValueType]) -> [(KeyType, ValueType)] {
  return Array(dictionary)
}

let pairs = pairsFromDictionary(dictionary: ["minimum": 199, "maximum": 299])
let morePairs = pairsFromDictionary(dictionary: [1: "Swift", 2: "Generics", 3: "Rule"])

//: ## Writing a Generic Data Structure

// See later on use of Equatable in a Challenge

struct Queue<Element: Equatable> {
  private var elements = [Element]()
  
  mutating func enqueue(newElement: Element) {
    elements.append(newElement)
  }
  
  mutating func dequeue() -> Element? {
    guard !elements.isEmpty else {
      return nil
    }
    return elements.remove(at: 0)
  }
}

var q = Queue<Int>()

q.enqueue(newElement: 4)
q.enqueue(newElement: 2)

q.dequeue()
q.dequeue()
q.dequeue()
q.dequeue()

//: ## Intermediate Topics

//: ### Type Constraints (Where Clauses)

func mid<T: Comparable>(array: [T]) -> T {
  return array.sorted()[(array.count - 1) / 2]
}

mid(array: [3, 5, 1, 2, 4]) // 3

protocol Summable { static func +(lhs: Self, rhs: Self) -> Self }

extension Int: Summable {}
extension Double: Summable {}

func adder<T: Summable>(x: T, _ y: T) -> T {
  return x + y
}

let adderIntSum = adder(x: 1, 2)
let adderDoubleSum = adder(x: 1.0, 2.0)

extension String: Summable {}
let adderString = adder(x: "Generics", " are Awesome!!! :]")

//: ### Extending a Generic Type

extension Queue {
  func peek() -> Element? {
    return elements.first
  }
}

q.enqueue(newElement: 5)
q.enqueue(newElement: 3)
q.peek()

// Challenge:

extension Queue {
  func homogeneous() -> Bool {
    if let first = elements.first {
      return !elements.contains { $0 != first }
    }
    return true
  }
}

q.homogeneous() // false

//: ## New Generics Features in Swift 2.0

//: ### Subclassing Generic Classes

class Box<T> {
}

// Generic subclass of generic type:

class Gift<T>: Box<T> {
}

// Special subclass of generic type, fix the genric type parameter:

class StringBox: Box<String> {
}

let box = Box<Int>()
let gift = Gift<Double>()
let stringBox = StringBox()

//: ### Enums with Multiple Generic Associated Values

enum Result<ValueType, ErrorType> {
  case Success(ValueType), Failure(ErrorType)
}

// Use case:

func divideOrError(x: Int, y: Int) -> Result<Int, String> {
  guard y != 0 else {
    return Result.Failure("Division by zero is undefined")
  }
  return Result.Success(x / y)
}


let result1 = divideOrError(x: 42, y: 2)
let result2 = divideOrError(x: 42, y: 0)

