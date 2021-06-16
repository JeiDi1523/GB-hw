import UIKit

//1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
//2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.

struct Enemy {
    let enemyName: String
    let hitPoints: Double
    let enemyPosition: (x: Double, y: Double)
}
enum WarriorAtackError: Error {
    case nonExistentEnemy
    case weakAtack
    case missAtack
}
class Battlefield {
    let enemies = [
        "Swordsman" : Enemy(enemyName: "Swordsman", hitPoints: 50.0, enemyPosition: (x: 14.5, y: 16.0)),
        "Archer" : Enemy(enemyName: "Archer", hitPoints: 25.0, enemyPosition: (x: 25.0, y: 20.0)),
        "Spearman" : Enemy(enemyName: "Spearman", hitPoints: 40.0, enemyPosition: (x: 17.5, y: 18.5))
    ]
    struct UserAtack {
        let userAtackEnemyName: String
        let userAtackPower: Double
        let userAtackEnemyPosition: (Double, Double)
    }
    func atackEnemy(userTry: UserAtack) throws {
        guard let enemy = enemies[userTry.userAtackEnemyName] else {
            throw WarriorAtackError.nonExistentEnemy
        }
        guard userTry.userAtackPower >= enemy.hitPoints else {
            throw WarriorAtackError.weakAtack
        }
        guard userTry.userAtackEnemyPosition == enemy.enemyPosition else {
            throw WarriorAtackError.missAtack
        }
        return print("\(userTry.userAtackEnemyName) destroyed.")
    }
}
let user = Battlefield.UserAtack(userAtackEnemyName: "ArcherX", userAtackPower: 50.0, userAtackEnemyPosition: (25.0, 20.0))
let battleField = Battlefield()
do {
    try battleField.atackEnemy(userTry: user)
} catch WarriorAtackError.nonExistentEnemy {
    print("Enemy which you want to atack is not exist.")
} catch WarriorAtackError.weakAtack {
    print("Your atack is to weak.")
} catch WarriorAtackError.missAtack {
    print("Missed atack.")
}
