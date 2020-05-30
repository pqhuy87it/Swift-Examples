//: Closures

func printString(_ aString: String) {
    print("Printing th string in \(aString)")
}

printString("Hi me name is")

let someFunvtion = printString

someFunvtion("Hi look at me!")


func printInt(_ number:Int) {
    print("Print int \(number)")
}

let numberOfApples = 3

printInt(numberOfApples)



func displayString(_ printStringFunc: (String) -> Void) {
    printStringFunc("I am function inside another fuction")
}

displayString(printString)

// Using the filter function

let allNumbers = [1,2,3,4,5,6,7,8,9,10]

func isEvenNumber(i: Int) -> Bool {
    
    return i % 2 == 0
    
}

let ifEven = isEvenNumber

let eveneNumbers = allNumbers.filter(ifEven)

func isFiveNumber(i: Int) -> Bool {
    return i % 5 == 0
}

let isFive = isFiveNumber

let fiveNumbers = allNumbers.filter(isFive)



////////////
//Capturing Variables

// Returning functions

func someFunc(number: Int) {
    
}

func printerFunction() -> (Int) -> () {
    var runningTotal = 0
    func printInteger(number:Int) {
        runningTotal += 10
        print("the integer passed in is: \(number)")
    }
    return printInteger
}

let printAndreturnIntegerFunc = printerFunction()

printAndreturnIntegerFunc(2)

printAndreturnIntegerFunc(3)

let runningTotalFunction = printerFunction()
runningTotalFunction(2)


func differenceBetweenNumbers(a: Int, b:Int) -> (Int) {
    return a - b
}

// Enter your code below

let differ =  differenceBetweenNumbers

func mathOperation(_ differenceBetweenNumbers: (Int, Int) -> Int, _ a:Int, _ b:Int) -> Int {
    
    return differenceBetweenNumbers(a,b)
    
}

let difference = mathOperation(differ, 10, 5)


func doubler(i:Int) ->Int {
    return i * 2
}

let doubleFunction = doubler
doubleFunction(4)

let numbers = [1,2,3,4,5]
let doubleNumbers = numbers.map(doubleFunction)

// Using closure expressions with the map function

let tripledNumbrs = numbers.map({(i: Int) -> Int in return i * 3})

// Using closure expressions with the sorted function

var name = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backwards(s1:String, s2:String) -> Bool {
    return s1 > s2
}

name.sort(by: backwards)

// Closure Shorthand Syntax

let tripleFunction = {(i:Int) -> Int in return i * 3}

[1,2,3,4,5,6].map(tripleFunction)

// Rule #2:

[1,2,3,4,5,6].map({i in return i * 3})

// Rule #3:

[1,2,3,4,5,6].map({i in i * 3})

// Rule #4: Shorthand Argument Names

[1,2,3,4,5,6].map({$0 * 3})

// Rule #5: trailing Closures

[1,2,3,4,5,6].map({$0 * 3})

[1,2,3,4,5,6].map() {
    (digit) -> Int in
    if digit % 2 == 0 {
        return digit/2
    }
    else {
        return digit
    }
}

// Rule #6: Ignoring Parenthese
[1,2,3,4,5,6].map({$0 * 3})

let numbersS = [Int](0...50)

// Enter your code below

func isOdd (number:Int) -> Bool {
    
    return number % 2 != 0
}

numbers.filter(isOdd)

