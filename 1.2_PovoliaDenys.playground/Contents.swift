import UIKit

// 1. Написать функцию, которая определяет, четное число или нет.

func evenOdd(number: Int) -> Bool {
    let i = number % 2
    if i == 0 {
        return true
    } else {
        return false
    }
}

if evenOdd(number: 4) {
    print("Число четное.")
} else {
    print("Число не четное.")
}

print("\n")

// 2. Написать функцию, которая определяет, делится ли число без остатка на 3.

func division3WithoutReminder (number: Int) -> Bool {
    let i = number % 3
    if i == 0 {
        return true
    } else {
        return false
    }
}

if division3WithoutReminder(number: 9) {
    print("Число делится на 3 без остатка.")
} else {
    print("Число не делится на 3 без остатка.")
}

print("\n")

// 3. Создать возрастающий массив из 100 чисел.

var array = [Int]()

for i in 1...100 {
    array.append(i)
}

print(array)

print("\n")

// 4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

for item in array {
    if evenOdd(number: item) {
        array.remove(at: array.firstIndex(of: item)!)
    } else if !division3WithoutReminder(number: item) {
        array.remove(at: array.firstIndex(of: item)!)
    }
}

print(array)

print("\n")

//5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.

func fibonacciToArray(array: inout [Int]) {
    array.append(0)
    array.append(1)
    array.append(1)
    for _ in 1...47 {
        let newFibonacciNumber = array[array.count - 1] + array[array.count - 2]
        array.append(newFibonacciNumber)
    }
}

var arrayFibonacci = [Int]()
fibonacciToArray(array: &arrayFibonacci)

print(arrayFibonacci)
arrayFibonacci.count

print("\n")

//6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена.


func addElementsToArray(startFrom valueStart: Int, countOfElements valueEnd: Int, arrayOfNumbers array: inout [Int]) {
    for element in valueStart...valueEnd {
        array.append(element)
    }
}
 
var arrayOfInt: [Int] = []
 
addElementsToArray(startFrom: 0, countOfElements: 600, arrayOfNumbers: &arrayOfInt)
 
func findPrimeNumbers(array: [Int], primeNumber: Int) -> [Int] {
    var arrayOfPrimeNumbers: [Int] = array
    var primeValue = primeNumber
    for _ in arrayOfPrimeNumbers {
        for item in stride(from: primeValue * primeValue, to: arrayOfPrimeNumbers.count, by: primeValue) {
            arrayOfPrimeNumbers[item] = 0
            }
        for item in arrayOfPrimeNumbers {
            if item > primeValue {
                primeValue = item
                break
            }
        }
    }
    return arrayOfPrimeNumbers
    }
    
    
    
let p: Int = 2
arrayOfInt = findPrimeNumbers(array: arrayOfInt, primeNumber: p)
 
func cleanTrashFromArray(array: [Int]) -> [Int] {
    var variableArray: [Int] = []
    
    for item in array {
        if item >= 2 && item != 0 && variableArray.count < 100 {
            variableArray.append(array[item])
        }
    }
    return variableArray
}
 
arrayOfInt = cleanTrashFromArray(array: arrayOfInt)
print(arrayOfInt)
arrayOfInt.count
