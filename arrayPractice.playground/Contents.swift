import Cocoa

let testArray: [String] = ["this", "is", "a", "test", "array", "array", "is", "is"]
let numItems = testArray.count

let testSet = Set(testArray)
let numUniqueItems = testSet.count

print("# of items: \(numItems), # of unique items: \(numUniqueItems)")
