import Cocoa

// Struct practice, car struct that changes gears, gears range from 1-10

struct Car {
    let model: String
    let numSeats: Int
    private(set) var currentGear = 1
    
    enum GearDirection {
        case up, down, neutral
    }
    
    public mutating func changeGear(_ gear: GearDirection) {
        switch gear {
        case .up:
            if currentGear < 10 { currentGear += 1 }
        case .down:
            if currentGear > 1 { currentGear -= 1 }
        case .neutral:
            currentGear = 1
        }
        print("Current gear is \(currentGear)")
    }
}

// test code
var car = Car(model: "Subaru Outback", numSeats: 5)
car.changeGear(.up)
car.changeGear(.up)
car.changeGear(.up)
car.changeGear(.down)
car.changeGear(.neutral)
car.changeGear(.down)
car.changeGear(.down)
