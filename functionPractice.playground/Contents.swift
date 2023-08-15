import Cocoa

// This project accepts an integer from 1 to 10,000 and returns the integer
// square root of that number. Practice for functions and error handling.

enum rootError: Error {
    case outOfBounds, noRoot
}

func integerSquareRoot(_ number: Int) throws -> Int {
    if number <  1 || number > 10_000 {
        throw rootError.outOfBounds
    }
    
    for i in 1...100 {
        if i * i == number {
            return i
        }
    }
    
    throw rootError.noRoot
}

do {
    var root = try integerSquareRoot(100)
    print(root)
} catch rootError.outOfBounds {
    print("Error: number is out of bounds. Input a number between 1 and 10,000")
} catch rootError.noRoot {
    print("Error: number has no integer root.")
} catch {
    print(error)
}
