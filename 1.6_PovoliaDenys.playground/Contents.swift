import UIKit

//1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов).
//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.

//сделать функцию, которая будет проверять находятся ли в массиве только числа или что-то еще и оставлять только нужное

struct Queue<T> {
    var collection = [T]()
    
    mutating func push(_ element: T) {
        collection.append(element)
    }
    
    mutating func pop() -> T {
        return collection.removeLast()
    }
    
    mutating func sortCustom(rule: (T, T) -> Bool) {
        for _ in 0..<collection.count {
            for index in 0..<collection.count - 1 {
                if rule(collection[index], collection[index + 1]) {
                    let tmpValue = collection[index]
                    collection[index] = collection[index + 1]
                    collection[index + 1] = tmpValue
                }
            }
        }
    }
    
    subscript(index: Int) -> T? {
        if index >= 0 && index < collection.count {
            return collection[index]
        } else {
            return nil
        }
    }
}

var increase: (Int, Int) -> Bool = { (element1: Int, element2: Int) -> Bool in
    return element1 > element2
}

var decrease: (Int, Int) -> Bool = { (element1: Int, element2: Int) -> Bool in
    return element1 < element2
}

var collectionQueueInt = Queue<Int>()
for _ in 1...10 {
    collectionQueueInt.push(Int.random(in: 1...100))
}
collectionQueueInt.push(15)
collectionQueueInt.pop()
print(collectionQueueInt)
collectionQueueInt.sortCustom(rule: increase)
print(collectionQueueInt)
collectionQueueInt.sortCustom(rule: decrease)
print(collectionQueueInt)

var collectionQueueString = Queue<String>()
collectionQueueString.push("Apple")
collectionQueueString.push("Microsoft")
collectionQueueString.push("Google")
collectionQueueString.push("Facebook")
collectionQueueString.push("👨🏻‍💻")
collectionQueueString.pop()
collectionQueueString[1]
print(collectionQueueString)
