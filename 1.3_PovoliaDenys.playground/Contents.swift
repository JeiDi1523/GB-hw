import UIKit

// 1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
// 2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
// 3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
// 4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
// 5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
// 6. Вывести значения свойств экземпляров в консоль.

struct SportCar {
    let carBrand: String
    let yearIssue: Int
    let trunkVolume: Double
    var carEngine: Action.Power {
        didSet {
            if carEngine == .On {
                print("— Приятной поездки —")
            }
        }
    }
    var carWindows: Action.Position
    var filledTrunkVolume: Double
    
    func printInfoAboutCar() {
        print("Информация о \(carBrand)")
        print("Год выпуска: \(yearIssue)")
        print("Объем багажника: \(trunkVolume)")
        print("Текущее состояние двигателя: \(carEngine.rawValue)")
        print("Положение окон: \(carWindows.rawValue)")
        print("Заполненность багажника: \(filledTrunkVolume)")
        print("\n")
    }
    
    mutating func enginePowerSwitch() {
        if carEngine == .On {
            self.carEngine = .Off
        } else {
            self.carEngine = .On
        }
    }
    
    mutating func windowsPositionChange() {
        if carWindows == .Open {
            self.carWindows = .Close
        } else {
            self.carWindows = .Open
        }
    }
    
    mutating func trunkAction(action: Action.Action, weight: Double) {
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
    
    init(carBrand: String, yearIssue: Int, trunkVolume: Double, carEngine: Action.Power, carWindows: Action.Position, filledTrunkVolume: Double) {
        self.carBrand = carBrand
        self.yearIssue = yearIssue
        self.trunkVolume = trunkVolume
        self.carEngine = carEngine
        self.carWindows = carWindows
        self.filledTrunkVolume = filledTrunkVolume
    }
}

struct TruckCar {
    let carBrand: String
    let yearIssue: Int
    let trunkVolume: Double
    var carEngine: Action.Power {
        didSet {
            if carEngine == .On {
                print("Приятной поездки.")
            }
        }
    }
    var carWindows: Action.Position
    var filledTrunkVolume: Double
    
    func printInfoAboutCar() {
        print("Информация о \(carBrand)")
        print("Год выпуска: \(yearIssue)")
        print("Объем багажника: \(trunkVolume)")
        print("Текущее состояние двигателя: \(carEngine.rawValue)")
        print("Положение окон: \(carWindows.rawValue)")
        print("Заполненность багажника: \(filledTrunkVolume)")
        print("\n")
    }
    
    mutating func enginePowerSwitch() {
        if carEngine == .On {
            self.carEngine = .Off
        } else {
            self.carEngine = .On
        }
    }
    
    mutating func windowsPositionChange() {
        if carWindows == .Open {
            self.carWindows = .Close
        } else {
            self.carWindows = .Open
        }
    }
    
    mutating func trunkAction(action: Action.Action, weight: Double) {
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
    
    init(carBrand: String, yearIssue: Int, trunkVolume: Double, carEngine: Action.Power, carWindows: Action.Position, filledTrunkVolume: Double) {
        self.carBrand = carBrand
        self.yearIssue = yearIssue
        self.trunkVolume = trunkVolume
        self.carEngine = carEngine
        self.carWindows = carWindows
        self.filledTrunkVolume = filledTrunkVolume
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

var sportCar1 = SportCar(carBrand: "Lamborghini Huracan",
                         yearIssue: 2014,
                         trunkVolume: 150.0,
                         carEngine: .Off,
                         carWindows: .Close,
                         filledTrunkVolume: 0.0)

sportCar1.windowsPositionChange()
sportCar1.printInfoAboutCar()

var sportCar2 = SportCar(carBrand: "Porsche 911 Carrera",
                         yearIssue: 2016,
                         trunkVolume: 132.0,
                         carEngine: .Off,
                         carWindows: .Close,
                         filledTrunkVolume: 0.0)

sportCar2.trunkAction(action: .Put, weight: 50.0)
sportCar2.enginePowerSwitch()
sportCar2.printInfoAboutCar()
sportCar2.trunkAction(action: .Take, weight: 25.0)
sportCar2.printInfoAboutCar()

var truckCar1 = TruckCar(carBrand: "Mazda CX-5", yearIssue: 2018, trunkVolume: 442.0, carEngine: .Off, carWindows: .Close, filledTrunkVolume: 0.0)

truckCar1.printInfoAboutCar()

var truckCar2 = TruckCar(carBrand: "Audi Q7", yearIssue: 2006, trunkVolume: 890.0, carEngine: .Off, carWindows: .Close, filledTrunkVolume: 0.0)

truckCar2.trunkAction(action: .Put, weight: 150.0)
truckCar2.windowsPositionChange()
truckCar2.printInfoAboutCar()
