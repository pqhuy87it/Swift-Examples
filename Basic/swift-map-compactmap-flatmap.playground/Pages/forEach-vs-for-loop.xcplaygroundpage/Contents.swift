//: [Previous](@previous)
//
// `forEach` and `for` loops
//
// `map` and its derivatives `flatMap` and `compactMap` are meant to _transform_
// the `Array` on which they are called into a new one. They should be _pure_
// functions, ones without side effects.
//
// I say _should_ because Swift doesn't prevent us from performing a side effect
// in a `map`.
//
// A simple example of side effect is calling `print`. Other side effects could be
// making network requests or updating the view.
//
// Say you want to print each element in an `Array`, `map`'s type signature makes
// it clear that it's not the most appropriate tool for the job.

_ = [1,2,3,4].map { element -> Int in
    print(element)
    // In order for this to compile we need to return something, we also need to
    // ignore
    return element
}

// `forEach` is a better choice for this.

[1,2,3,4].forEach { print($0) }

// A `for` loop is another option.

for element in [1,2,3,4] { print(element) }

// Which one to use between `forEach` and a `for` loop is generally up to you.
// I used to prefer `for` loops because they read well, "for element in array do
// something". In the past years though I moved to use `forEach` instead. I like
// how the shape is the same as `map` and how more compact it looks than a `for`
// loop.
