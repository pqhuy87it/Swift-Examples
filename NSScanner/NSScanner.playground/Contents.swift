//: Playground - noun: a place where people can play

import UIKit
import Foundation

let numericInJapan = CharacterSet(charactersIn: "０１２３４５６７８９")
let inputString = "abcdefdh６ijklmnop"
var checkString: String?
let scanner = Scanner(string: inputString)
scanner.charactersToBeSkipped = NSCharacterSet.whitespaces
scanner.scanUpToCharacters(from: numericInJapan)
checkString = scanner.scanCharacters(from: numericInJapan)
print(checkString!)
