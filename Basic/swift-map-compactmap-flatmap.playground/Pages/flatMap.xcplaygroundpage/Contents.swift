//: [Previous](@previous)
//
// # `flatMap`
//
// `flatMap` differs from `map` in that it expects a tranformation function
// returning an `Array`, and the value it returns is a flattened array with the
// resulting arrays.

let users = [
    User(emails: ["one@email.com", "two@email.com"]),
    User(emails: ["three@email.com"])
]

let allEmails: [Email] = users.flatMap { $0.emails }

//: [Next](@next)
