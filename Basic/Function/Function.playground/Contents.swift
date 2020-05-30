//: Playground - noun: a place where people can play

import UIKit

// This is a function that takes an Int and prints it.
func printInt(i: Int) {
    print("you passed \(i)")
}

// This assigns the function you just declared
// to a variable.  Note the absence of () after the
// function name.
let funVar = printInt

// Now you can call that function using your variable.
// Note the use of () after the variable name.
funVar(2)  // will print out "you passed 2"

// You can also write a function that takes a
// function as an argument
func useFunction(_ funParam: (Int) -> () ) {
    // call the passed-in function:
    funParam(3)
}

// You can call this new function passing in either
// the original function:
useFunction(printInt)
// or the variable
useFunction(funVar)

// a simple function that doubles an int
func doubler(i: Int) -> Int { return i * 2 }

// the following runs doubler on each number,
// returning a new array of the results
let a = [1, 2, 3, 4].map(doubler)

/*
// This is a function that returns another function.
// That other function takes an Int and returns nothing.
func returnFunc() -> (Int) -> () {
    func innerFunc(i: Int) {
        print("you passed \(i) to the returned func")
    }
    return innerFunc
}

let f = returnFunc()
f(3)  // will print "you passed 3 to the returned func"
*/

func returnFunc() -> (Int) -> () {
    var counter = 0  // local variable declaration
    func innerFunc(i: Int) {
        counter += i   // counter is "captured"
        print("running total is now \(counter)")
    }
    return innerFunc
    // normally counter, being a local variable, would
    // go out of scope here and be destroyed. but instead,
    // it will be kept alive for use by innerFunc
}

let f = returnFunc()
f(3)  // will print "running total is now 3"
f(4)  // will print "running total is now 7"

// if we call returnFunc() again, a fresh counter
// variable will be created and captured
let g = returnFunc()
g(2)  // will print "running total is now 2"
g(2)  // will print "running total is now 4"

// this does not effect our first function, which
// still has it's own captured version of counter
f(2)  // will print "running total is now 9"
