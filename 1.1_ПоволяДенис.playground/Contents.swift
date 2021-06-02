import UIKit

// 1. Решить квадратное уравнение.

let a = 1
let b = -6
let c = 9

let D = b * b - 4 * a * c

if D < 0 {
    print("Корней нет.")
} else if D == 0 {
    let x = -b / (2 * a)
    print("Корень один =", x)
} else {
    let x1 = (-b + D * D) / (2 * a)
    let x2 = (-b - D * D) / (2 * a)
    print("x1 =", x1, "x2 =", x2)
}

/*
 Для проверки кода:
 1. Дискриминант положительный (в уравнении будет 2 различных корня); коефициенты: a = 1, b = −8, c = 12.
 2. Дискриминант отрицательный (корней нет); a = 5; b = 3; c = 7.
 3. Дискриминант равен нулю (единственный корень); a = 1; b = −6; c = 9.
 */

// 2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.

let cathetus1: Double = 3
let cathetus2: Double = 4

let S = cathetus1 * cathetus2 / 2
print("Площадь треугольника", S)

let hypotenuse = sqrt(cathetus1 * cathetus1 + cathetus2 * cathetus2)
print("Гипотенуза прямоугольного треугольника", hypotenuse)

let P = cathetus1 + cathetus2 + hypotenuse
print("Периметр треугольника", P)

// 3. Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.

var deposit = 5000
let percent = 10
var year = 0

while(year < 10){
    deposit += deposit * percent / 100
    year += 1
}

print("Итоговая сумма вклада за", year, "лет составила", deposit)
