import Cocoa

class Animal {
    let numLegs: Int
    
    init(numLegs: Int) {
        self.numLegs = numLegs
    }
}

class Dog: Animal {
    func speak() {
        print("bark")
    }
}

class Cat: Animal {
    let isTame: Bool
    
    init(numLegs: Int, isTame: Bool) {
        self.isTame = isTame
        super.init(numLegs: numLegs)
    }
    
    func speak() {
        print("meow")
    }
}

final class Corgi: Dog {
    override func speak() {
        print("woof woof")
    }
}

final class Poodle: Dog {
    override func speak() {
        print("bork bork")
    }
}

final class Persian: Cat {
    override func speak() {
        print("meow purr")
    }
}

final class Lion: Cat {
    override func speak() {
        print("roarrrr")
    }
}

// test code

let cat = Persian(numLegs: 4, isTame: true)
let lion = Lion(numLegs: 4, isTame: false)
let loaf = Corgi(numLegs: 4)
let fluff = Poodle(numLegs: 4)

cat.speak()
lion.speak()
loaf.speak()
fluff.speak()
