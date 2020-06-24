import UIKit

protocol Coffee {
    var volume: Double { get } // объем
    var name: String { get } // ингредиенты
    var coast: Int {get } // стоимость
}

class SimpleCoffee: Coffee {
    var volume: Double {
        return 100
    }
    var coast: Int {
        return 150
    }
    var name: String {
        return "Coffee"
    }
}

protocol CoffeeDecorator: Coffee {
    var base: Coffee { get }
    init(base: Coffee)
}

class Milk: CoffeeDecorator {
    let base: Coffee
    
    var volume: Double {
        return base.volume + 100.0
    }
    var coast: Int {
        return base.coast + 50
    }
    var name: String {
        return base.name + "+Milk"
    }
    required init(base: Coffee) {
        self.base = base
    }
}
class Sugar: CoffeeDecorator {
    
    let base: Coffee
    
    var volume: Double {
        return base.volume + 5.0
    }
    var coast: Int {
        return base.coast + 20
    }
    var name: String {
        return base.name + "+Sugar"
    }
    required init(base: Coffee) {
        self.base = base
    }
}

class Whip: CoffeeDecorator {
    let base: Coffee
    
    var volume: Double {
        return base.volume + 50.0
    }
    var coast: Int {
        return base.coast + 100
    }
    var name: String {
        return base.name + "+Whip"
    }
    required init(base: Coffee) {
        self.base = base
    }
}
let simpleCoffee = SimpleCoffee()
let coffeWithWhip = Whip(base: simpleCoffee)
let coffeeWithMilk = Milk(base: simpleCoffee)
let coffeeWithSugar = Sugar(base: simpleCoffee)
let coffeeWithSugarAndMilk = Milk(base: coffeeWithSugar)
print("\(coffeWithWhip.name) \(coffeWithWhip.volume) ml \(coffeWithWhip.coast) руб")
print("\(coffeeWithSugar.name) \(coffeeWithSugar.volume) ml \(coffeeWithSugar.coast) руб")
print("\(coffeeWithSugarAndMilk.name) \(coffeeWithSugarAndMilk.volume) ml \(coffeeWithSugarAndMilk.coast) руб")

