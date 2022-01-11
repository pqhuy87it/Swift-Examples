import UIKit

let testString = "This is a test string"
var testStringReplacedOccurences = testString.replacingOccurrences(of: "is",
                                                                   with: "*")

print("testStringReplacedOccurences:", testStringReplacedOccurences)

// OUTPUT: Th* * a test string

var testStringOccurences2 = testString.replacingOccurrences(of: #"\bis"#,
                                                            with: "was",
                                                            options: .regularExpression,
                                                            range: nil)

print("testStringOccurences2:", testStringOccurences2)

// OUTPUT: This was a test string

if let range = testString.range(of: "is") {
    let testString2 = testString.replacingCharacters(in: range,
                                                     with: "at")
    
    print("testString2: ", testString2)
    
    // OUTPUT: That is a test string
}

var substringReplace = "Replace a substring"
let endIndex = substringReplace.index(substringReplace.startIndex,
                                      offsetBy: 8)
substringReplace.replaceSubrange(...endIndex,
                                 with: "Replaced the")
print("substringReplace: ", substringReplace)
// OUTPUT: Replaced the substring
