
import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        do {
            let path = Bundle.main.path(forResource: "sample", ofType: "log") // file path for file "data.txt"
            let string = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
            
            if let str = self.splitString(string) {
                print(str)
            }
        } catch {
            print(error)
        }
    }
    
    let regex: String = "\\b[0-9]{4}-[0-9]{2}-[0-9]{2}[a-zA-Z0-9 :.]{1,}"

    func splitString(_ input: String) -> [String]? {
        var courses: [String] = []
        
        courses = input.ranges(of: regex, options: .regularExpression).map { input[$0].trimmingCharacters(in: .whitespaces) }
        if courses.isEmpty { return nil }
        
        var stringSplit: [String] = []
        
        for index in 0 ... courses.count - 1 {
            if index == courses.count - 1 {
                guard let beforeIndex = input.startIndex(of: courses[index]) else { return nil }
                let subString = String(input[beforeIndex...])
                stringSplit.append(subString)
            } else {
                guard let beforeIndex = input.startIndex(of: courses[index]),
                      let afterIndex = input.startIndex(of: courses[index + 1]) else { return nil }
                let subString = String(input[beforeIndex ..< afterIndex])
                stringSplit.append(subString)
            }
        }
        
        for element in stringSplit {
            if element.isEmpty {
                continue
            }

        }
        
        return stringSplit
    }
}

extension StringProtocol {
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
              let range = self[startIndex...].range(of: string, options: options) {
            result.append(range)
            startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
    
    func startIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        ranges(of: string, options: options).map(\.lowerBound)
    }
    
}
