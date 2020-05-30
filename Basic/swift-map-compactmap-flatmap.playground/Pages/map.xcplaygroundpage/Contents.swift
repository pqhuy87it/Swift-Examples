// # `map`
//
// `map` runs the given closure to each element in the `Array` calling it returning a new `Array` with the results.

let arrayOfNumbers = [1, 2, 3, 4]
let arrayOfString = arrayOfNumbers.map { "\($0)" }

// You can also pass free and static functions to `map`.

let averageImages = [Image(), Image(), Image()]
let awesomeImages = averageImages
    .map(cropIntoSquare)
    .map(bumpContrast)
    .map(applySecretFilter)

let otherAwesomeImages = averageImages
    .map(Image.blur)
    .map(Image.flip)

//: [Next](@next)
