//
//  ViewController.swift
//  CodeBase_ Calculator
//
//  Created by DEUKRYEONG LEE on 6/28/24.
//

import UIKit

class ViewController: UIViewController {
    let model = CalculatorModel()
    var calculatorView: CalculatorView!
    var currentExpression = ""
    
    override func loadView() {
        calculatorView = CalculatorView()
        calculatorView.buttons.forEach { (_, button) in
            button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        view = calculatorView
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }
        
        switch title {
        case "0"..."9", "+", "-", "*", "/":
            currentExpression += title
            calculatorView.result_Label.text = currentExpression
        case "=":
            if let result = model.calculate(expression: currentExpression) {
                calculatorView.result_Label.text = "\(result)"
                currentExpression = "\(result)"
            } else {
                calculatorView.result_Label.text = "Error"
                currentExpression = ""
            }
        case "AC":
            currentExpression = ""
            calculatorView.result_Label.text = "0"
        default:
            break
        }
        currentExpression = removeFirstZero(currentExpression)
    }
    private func removeFirstZero(_ expression: String) -> String {
        var result = expression
        var index = result.startIndex
        
        // 첫 번째 숫자가 "0"일 경우 제거
        while index < result.endIndex, result[index] == "0" {
            index = result.index(after: index)
        }
        
        // 숫자가 없거나 첫 번째 숫자가 아닌 경우 처리
        if index < result.endIndex {
            // 제거된 0을 반영하여 재구성된 문자열 반환
            return String(result[index...])
        } else {
            return "0"
        }
    }
}
