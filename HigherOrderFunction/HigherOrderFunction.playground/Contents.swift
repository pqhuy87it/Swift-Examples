//: Playground - noun: a place where people can play

import UIKit

let A = [1,3,5,7,10]
let B = [2,4,3,5,8,9]
let C = A.filter{ B.contains($0) }
print(C)

let D = A.filter{ !B.contains($0) }
print(D)

let E = [1,2,3,4,5,6,7,8,9]

// cat mang ra thanh cac mang con voi do rong la x
extension Array {
    func splitBy(_ subSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: subSize).map { startIndex in
            let endIndex = startIndex.advanced(by: subSize)
            return Array(self[startIndex ..< endIndex])
        }
    }
}

let F = E.splitBy(3)
print(F)
/*
class Person{
    var name:String?
}

var p1:Person = Person()
p1.name = "a"

var p3:Person = Person()
p3.name = "c"

var p2:Person = Person()
p2.name = "b"

var persons:NSArray = [p1,p3,p2]

var sortedArray:NSArray = persons.sortedArrayUsingComparator(){
    
    (p1:AnyObject!, p2:AnyObject!) -> NSComparisonResult in
    
    if (p1 as! Person).name > (p2 as! Person).name {
        return NSComparisonResult.OrderedDescending
    }
    if (p1 as! Person).name < (p2 as! Person).name {
        return NSComparisonResult.OrderedAscending
    }
    return NSComparisonResult.OrderedAscending
}

for item:AnyObject in sortedArray{
    print((item as! Person).name)
}
 
 // sort 1 mang Int
 let G: NSArray = [10,12,4,5,6]
 let sortedArray = G.sortedArrayUsingComparator() { (number1:AnyObject!, number2:AnyObject!) -> NSComparisonResult in
 
 if (number1 as! Int) > (number2 as! Int) {
 return NSComparisonResult.OrderedDescending
 }
 
 if (number1 as! Int) > (number1 as! Int) {
 return NSComparisonResult.OrderedAscending
 }
 
 return NSComparisonResult.OrderedSame
 }
 
 print(sortedArray)
 
*/

//let G = [[10,12,4,5,6],[4,3,10,22,14],[12,15,16,14,20],[87,54,12,65,89],[12,32,25,26,54]]
let G = [[10,12,"4",5,6],[4,3,"10",22,14]]
//let sortedArray = G.sort{ ($0[2] as? Int) < ($1[2] as? Int) }
let sortedArray = G.sorted{Int($0[2] as! String)! > Int($1[2] as! String)!}
print(sortedArray)

