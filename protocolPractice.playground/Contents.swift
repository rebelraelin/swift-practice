import Cocoa

protocol Building {
    var numRooms: Int { get }
    var cost: Int { get }
    var realEstateAgent: String { get set }
    
    func salesSummary()
    mutating func changeAgent(to name: String)
}

struct House: Building {
    let numRooms: Int
    let cost: Int
    var realEstateAgent: String
    
    func salesSummary() {
        print("This house has \(numRooms) rooms and costs $\(cost). Please contact \(realEstateAgent).")
    }
    
    mutating func changeAgent(to name: String) {
        realEstateAgent = name
    }
}

struct Office: Building {
    let numRooms: Int
    let cost: Int
    var realEstateAgent: String
    
    func salesSummary() {
        print("This office has \(numRooms) rooms and costs $\(cost). Please contact \(realEstateAgent).")
    }
    
    mutating func changeAgent(to name: String) {
        realEstateAgent = name
    }
}

// test code

var house = House(numRooms: 5, cost: 650000, realEstateAgent: "Melissa M")
var office = Office(numRooms: 12, cost: 1000000, realEstateAgent: "Samantha R")

house.salesSummary()
office.salesSummary()

house.changeAgent(to: "Kathy Q")
office.changeAgent(to: "Liz L")

house.salesSummary()
office.salesSummary()
