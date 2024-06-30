//
//  Model.swift
//  CodeBase_ Calculator
//
//  Created by DEUKRYEONG LEE on 6/30/24.
//

import Foundation

class CalculatorModel {
    // 계산 메서드: 주어진 문자열 표현식을 계산
    func calculate(expression: String) -> Int? {
        let exp = NSExpression(format: expression)
        if let result = exp.expressionValue(with: nil, context: nil) as? NSNumber {
            return result.intValue
        }
        return nil
    }
}
