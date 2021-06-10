import UIKit

//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести сами объекты в консоль.

protocol Car: CustomStringConvertible {
    var carBrand: String {get}
    var yearIssue: Int {get}
    var trunkVolume: Double {get}
    var carEngine: Action.Power {get set}
    var carWindows: Action.Position {get set}
    var filledTrunkVolume: Double {get set}
}

extension Car {
    mutating func enginePowerSwitch() {
            switch carEngine {
            case .On:
            return carEngine = .Off
            default:
            return carEngine = .On
            }
    }
    mutating func windowsPositionChange() {
        switch carWindows {
        case .Open:
        return carWindows = .Close
        default:
        return carWindows = .Open
        }
    }
    mutating func trunkAction(action: Action.Action, weight: Double) {
        if action == .Put && (weight + filledTrunkVolume) < trunkVolume && weight > 0.0 {
               filledTrunkVolume += weight
        } else if action == .Put && (weight + filledTrunkVolume) > trunkVolume || weight < 0.0 {
               fatalError("Невозможное действие.\nОбъем багажника: \(trunkVolume). Невозможно вместить груз весом: \(weight)")
           } else if action == .Take && filledTrunkVolume != 0.0 && weight <= filledTrunkVolume {
               filledTrunkVolume -= weight
           } else if action == .Take && filledTrunkVolume == 0.0 || weight > filledTrunkVolume {
               fatalError("Невозможное действие.\nОбъем заполненного багажника: \(filledTrunkVolume). Невозможно взять груз весом: \(weight)")
           }
       }
    func printInfoAboutCar () {
        print(description)
    }
}

enum Action {
    case Engine(power: Power)
    case Window(position: Position)
    case Trunk(action: Action)
    
    enum Power: String {
        case On = "включен"
        case Off = "выключен"
    }
    
    enum Position: String {
        case Open = "открыты"
        case Close = "закрыты"
    }
    
    enum Action {
        case Put
        case Take
    }
}

class SportCar: Car {
    let carBrand: String
    let yearIssue: Int
    let trunkVolume: Double
    var carEngine: Action.Power {
        didSet {
           if carEngine == .On {
               print("— Приятной поездки —")
               print("\n")
           }
       }
   }
    var carWindows: Action.Position
    var filledTrunkVolume: Double
    let doorsType: DoorsType
    var description: String {
        return "Информация о \(carBrand)\nГод выпуска: \(yearIssue)\nОбъем багажника: \(trunkVolume)\nТекущее состояние двигателя: \(carEngine.rawValue)\nПоложение окон: \(carWindows.rawValue)\nЗаполненность багажника: \(filledTrunkVolume)\nТип дверей: \(doorsType.rawValue)\n"
    }
    
    init(carBrand: String, yearIssue: Int, trunkVolume: Double, carEngine: Action.Power, carWindows: Action.Position, filledTrunkVolume: Double, doorsType: DoorsType) {
            self.carBrand = carBrand
            self.yearIssue = yearIssue
            self.trunkVolume = trunkVolume
            self.carEngine = carEngine
            self.carWindows = carWindows
            self.filledTrunkVolume = filledTrunkVolume
            self.doorsType = doorsType
    }
    
    enum DoorsType: String {
            case Normal = "обычные"
            case Lambo = "ламбо"
            case GullWing = "крыло чайки"
        }
}

class TruckCar: Car {
    let carBrand: String
    let yearIssue: Int
    let trunkVolume: Double
    var carEngine: Action.Power {
        didSet {
            if carEngine == .On {
                print("— Приятной поездки —")
                print("\n")
            }
        }
    }
    var carWindows: Action.Position
    var filledTrunkVolume: Double
    var tiresType: TiresType
    var description: String {
        return "Информация о \(carBrand)\nГод выпуска: \(yearIssue)\nОбъем багажника: \(trunkVolume)\nТекущее состояние двигателя: \(carEngine.rawValue)\nПоложение окон: \(carWindows.rawValue)\nЗаполненность багажника: \(filledTrunkVolume)\nТип шин: \(tiresType.rawValue)\n"
    }
    
    init(carBrand: String, yearIssue: Int, trunkVolume: Double, carEngine: Action.Power, carWindows: Action.Position, filledTrunkVolume: Double, tiresType: TiresType) {
        self.carBrand = carBrand
        self.yearIssue = yearIssue
        self.trunkVolume = trunkVolume
        self.carEngine = carEngine
        self.carWindows = carWindows
        self.filledTrunkVolume = filledTrunkVolume
        self.tiresType = tiresType
    }
    
    enum TiresType: String {
            case Road = "дорожные"
            case OffRoad = "внедорожные"
            case Career = "карьерные"
        }
    
    func printInfoAboutCar() {
        print("Информация о \(carBrand)")
        print("Год выпуска: \(yearIssue)")
        print("Объем багажника: \(trunkVolume)")
        print("Текущее состояние двигателя: \(carEngine.rawValue)")
        print("Положение окон: \(carWindows.rawValue)")
        print("Заполненность багажника: \(filledTrunkVolume)")
        print("Тип шин: \(tiresType.rawValue)")
        print("\n")
    }
}

var sportCar1 = SportCar(carBrand: "Lamborghini Huracan",
                         yearIssue: 2014,
                         trunkVolume: 150.0,
                         carEngine: .Off,
                         carWindows: .Close,
                         filledTrunkVolume: 0.0,
                         doorsType: .Lambo)

sportCar1.windowsPositionChange()
sportCar1.enginePowerSwitch()
sportCar1.printInfoAboutCar()

var sportCar2 = SportCar(carBrand: "Porsche 911 Carrera",
                         yearIssue: 2016,
                         trunkVolume: 132.0,
                         carEngine: .Off,
                         carWindows: .Close,
                         filledTrunkVolume: 0.0,
                         doorsType: .Normal)

sportCar1.trunkAction(action: .Put, weight: 45.0)
sportCar2.printInfoAboutCar()

var trunkCar1 = TruckCar(carBrand: "Mazda CX-5",
                         yearIssue: 2018,
                         trunkVolume: 442.0,
                         carEngine: .Off,
                         carWindows: .Close,
                         filledTrunkVolume: 0.0,
                         tiresType: .OffRoad)

trunkCar1.trunkAction(action: .Put, weight: 156.0)
trunkCar1.trunkAction(action: .Take, weight: 6.0)
trunkCar1.enginePowerSwitch()
trunkCar1.printInfoAboutCar()

var trunkCar2 = TruckCar(carBrand: "Audi Q7",
                         yearIssue: 2006,
                         trunkVolume: 890.0,
                         carEngine: .Off,
                         carWindows: .Close,
                         filledTrunkVolume: 0.0,
                         tiresType: .Road)

trunkCar2.printInfoAboutCar()
