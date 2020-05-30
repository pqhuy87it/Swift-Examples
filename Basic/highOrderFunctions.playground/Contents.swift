//: Playground - noun: a place where people can play

import UIKit

// Examples of High Order Functions

// Here we set up a couple of arrays to experiment with
let numbersArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let numberSetsArray = [[1, 2, 3, 4, 5], [6, 7, 8, 9, 10]]

// Map
// Allows us to perform the action within it's closure on each element in the sequence
// Here each element is multiplied by 2, producing an array of Integers that are double the original array
let mapArray = numbersArray.map{$0 * 2}
mapArray

// Filter - filter out certain values
// Produces an array containing all of the elements that satisfy the condition within it's closure
// Here the modlus operator is used on each element with a value of 2 and the result is compared to 0
// Each element that has a remainder of 0 passes through the filter, leaving us with only the even numbers from numbersArray
let evenNumbersArray = numbersArray.filter{$0 % 2 == 0}
evenNumbersArray

// Reduce
// Produces a single result from the elements of a sequence
// Here it is used to add the integers within the numbersArray
let sumOfArray = numbersArray.reduce(0, +)
sumOfArray

// flatMap{$0}
// Flattens a sequence of arrays together in the order that they are presented
let flattenedArray = numberSetsArray.flatMap{$0}
flattenedArray

// Chaining - Functions can chain off one another
// These functions can chain off one another
// Here the above flatMap function is applied first, followed by the reduce function also seen above
let chainValue = numberSetsArray.flatMap{$0}.reduce(0, +)
chainValue


// Here we set up a few arrays to perform Zip and Map on
var totalArray: [Double] = [0, 0, 0, 0, 0]

var arrayOne: [Double] = [1, 2, 3, 4, 5]
var arrayTwo: [Double] = [5, 4, 3, 2, 1]
var arrayThree: [Double] = [8, 4, 6, 3, 7]

// Zip
// Groups values in arrays
// When zipping two arrays, the values of the two arrays are associated at the same index
// Here arrayOne's 1 is associated with arrayTwo's 5, arrayOne's 2 with arrayTwo's 4, etc.
let zippedArray = zip(arrayOne, arrayTwo)
// Zip + Map
// When applying the .map function to a zipped array, the map function is performed on the associated values
// Here each associated value pair is added together
zippedArray.map(+)


// Below is an example of how you can add multiple arrays of values together using zip and map together
totalArray
totalArray = zip(totalArray, arrayOne).map(+)
totalArray = zip(totalArray, arrayTwo).map(+)
totalArray = zip(totalArray, arrayThree).map(+)
