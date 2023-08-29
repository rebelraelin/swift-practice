import Cocoa

// Optionals practice problem :D
// Write a function that accepts an optional Int array, returns random element in array,
// or a random number between 1-100, all in one line of code

func randomNumber(_ numbers: [Int]?) -> Int { return numbers?.randomElement() ?? Int.random(in: 1...100) }

// test code

print(randomNumber(nil))
print(randomNumber([]))
print(randomNumber([0]))
print(randomNumber([2, 2, 2]))
print(randomNumber([-2, 27, -7000, 100000]))
