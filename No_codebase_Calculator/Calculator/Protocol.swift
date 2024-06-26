//
//  Protocol.swift
//  Calculator
//
//  Created by DEUKRYEONG LEE on 6/20/24.
//

import Foundation
protocol Operator {
    func operation(number1: Int, number2: Int) -> Int
}
//MARK: - 더하기 연산자
class Add: Operator {
    func operation(number1: Int, number2: Int) -> Int {
        return number1 + number2
    }
}
//MARK: - 뺴기 연산자
class Sub: Operator {
    func operation(number1: Int, number2: Int) -> Int {
        return number1 - number2
    }
}
//MARK: - 곱하기 연산자
class Muti: Operator {
    func operation(number1: Int, number2: Int) -> Int {
        return number1 * number2
    }
}
//MARK: - 나누기 연산자
class Div: Operator {
    func operation(number1: Int, number2: Int) -> Int {
        return number1 / number2
    }
}

