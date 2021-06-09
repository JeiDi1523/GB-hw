import UIKit

//1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
//2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
//3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
//4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.


class Car {
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
    
    init(carBrand: String, yearIssue: Int, trunkVolume: Double, carEngine: Action.Power, carWindows: Action.Position, filledTrunkVolume: Double) {
        self.carBrand = carBrand
        self.yearIssue = yearIssue
        self.trunkVolume = trunkVolume
        self.carEngine = carEngine
        self.carWindows = carWindows
        self.filledTrunkVolume = filledTrunkVolume
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
    
    func printInfoAboutCar() {
        print("Информация о \(carBrand)")
        print("Год выпуска: \(yearIssue)")
        print("Объем багажника: \(trunkVolume)")
        print("Текущее состояние двигателя: \(carEngine.rawValue)")
        print("Положение окон: \(carWindows.rawValue)")
        print("Заполненность багажника: \(filledTrunkVolume)")
    }
    
    func enginePowerSwitch() {
        if carEngine == .On {
            self.carEngine = .Off
        } else {
            self.carEngine = .On
        }
    }
    
    func windowsPositionChange() {
        if carWindows == .Open {
            self.carWindows = .Close
        } else {
            self.carWindows = .Open
        }
    }
    
    func trunkAction(action: Action.Action, weight: Double) {
        if action == .Put && (weight + filledTrunkVolume) < trunkVolume {
            filledTrunkVolume += weight
        } else if action == .Put && (weight + filledTrunkVolume) > trunkVolume{
            fatalError("Невозможное действие.\nОбъем багажника: \(trunkVolume). Невозможно вместить груз весом: \(weight)")
        } else if action == .Take && filledTrunkVolume != 0.0 && weight <= filledTrunkVolume {
            filledTrunkVolume -= weight
        } else if action == .Take && filledTrunkVolume == 0.0 || weight > filledTrunkVolume {
            fatalError("Невозможное действие.\nОбъем заполненного багажника: \(filledTrunkVolume). Невозможно взять груз весом: \(weight)")
        }
    }
}

class SportCar: Car {
    var doorsType: DoorsType
    
    init(carBrand: String, yearIssue: Int, trunkVolume: Double, carEngine: Car.Action.Power, carWindows: Car.Action.Position, filledTrunkVolume: Double, doorsType: DoorsType) {
        self.doorsType = doorsType
        super.init(carBrand: carBrand, yearIssue: yearIssue, trunkVolume: trunkVolume, carEngine: carEngine, carWindows: carWindows, filledTrunkVolume: filledTrunkVolume)
    }
    
    enum DoorsType: String {
        case Normal = "обычные"
        case Lambo = "ламбо"
        case GullWing = "крыло чайки"
    }
    
    override func printInfoAboutCar() {
        super.printInfoAboutCar()
        print("Тип дверей: \(doorsType.rawValue)")
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

sportCar1.printInfoAboutCar()

var sportCar2 = SportCar(carBrand: "Porsche 911 Carrera",
                         yearIssue: 2016,
                         trunkVolume: 132.0,
                         carEngine: .Off,
                         carWindows: .Close,
                         filledTrunkVolume: 0.0,
                         doorsType: .Normal)

sportCar2.printInfoAboutCar()

class TrunkCar: Car {
    var tiresType: TiresType
    
    init(carBrand: String, yearIssue: Int, trunkVolume: Double, carEngine: Car.Action.Power, carWindows: Car.Action.Position, filledTrunkVolume: Double, tiresType: TiresType) {
        self.tiresType = tiresType
        super.init(carBrand: carBrand, yearIssue: yearIssue, trunkVolume: trunkVolume, carEngine: carEngine, carWindows: carWindows, filledTrunkVolume: filledTrunkVolume)
    }
    
    enum TiresType: String {
        case Road = "дорожные"
        case OffRoad = "внедорожные"
        case Career = "карьерные"
    }
    
    override func printInfoAboutCar() {
        super.printInfoAboutCar()
        print("Тип шин: \(tiresType.rawValue)")
        print("\n")
    }
}

var trunkCar1 = TrunkCar(carBrand: "Mazda CX-5",
                         yearIssue: 2018,
                         trunkVolume: 442.0,
                         carEngine: .Off,
                         carWindows: .Close,
                         filledTrunkVolume: 0.0,
                         tiresType: .OffRoad)

trunkCar1.printInfoAboutCar()

var trunkCar2 = TrunkCar(carBrand: "Audi Q7",
                         yearIssue: 2006,
                         trunkVolume: 890.0,
                         carEngine: .Off,
                         carWindows: .Close,
                         filledTrunkVolume: 0.0,
                         tiresType: .Road)

trunkCar2.printInfoAboutCar()
