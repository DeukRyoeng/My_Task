//
//  ViewController.swift
//  Calculator
//
//  Created by DEUKRYEONG LEE on 6/20/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var btn_Add: UIButton!
    @IBOutlet weak var btn_Sub: UIButton!
    @IBOutlet weak var btn_Mult: UIButton!
    @IBOutlet weak var btn_Div: UIButton!
    @IBOutlet weak var btn_Equal: UIButton!
    @IBOutlet weak var btn_AC: UIButton!
    @IBOutlet weak var btn_0: UIButton!
    @IBOutlet weak var btn_9: UIButton!
    @IBOutlet weak var btn_8: UIButton!
    @IBOutlet weak var btn_7: UIButton!
    @IBOutlet weak var btn_6: UIButton!
    @IBOutlet weak var btn_5: UIButton!
    @IBOutlet weak var btn_4: UIButton!
    @IBOutlet weak var btn_3: UIButton!
    @IBOutlet weak var btn_2: UIButton!
    @IBOutlet weak var btn_1: UIButton!
    
    private var currentInput: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = "0"
        
        print("called Viewcontroller - run App")
        let buttons: [UIButton] = [
            btn_0, btn_1, btn_2, btn_3,
            btn_4, btn_5, btn_6, btn_7,
            btn_8, btn_9, btn_AC, btn_Equal,
            btn_Div, btn_Mult, btn_Sub, btn_Add
        ]
        makeButtonsCirc(buttons: buttons)
        
    }
    @IBAction func numberTapped(_ sender:UIButton) {
        guard let numberValue = sender.titleLabel?.text else { return }
        currentInput += numberValue
        resultLabel.text = currentInput
    }
    
    @IBAction func operatorTapped(_ sender: UIButton) {
        guard let operatorValue = sender.titleLabel?.text else { return }
        if !currentInput.isEmpty {
            currentInput += operatorValue
            resultLabel.text = currentInput
        }
    }
    
    @IBAction func equal_Btn(_ sender: UIButton) {
        if !currentInput.isEmpty {
            let result = calculate(expression: currentInput)
            resultLabel.text = "\(result!)"
            currentInput = ""
        }
    }
    
    @IBAction func ac_Btn(_ sender: UIButton) {
        currentInput = ""
        resultLabel.text = "0"
    }
    
    func calculate(expression: String) -> Int? {
        let expression = NSExpression(format: expression)
        if let result = expression.expressionValue(with: nil, context: nil) as? Int {
            return result
        } else {
            return nil
        }
    }
    func makeButtonsCirc(buttons:[UIButton]) {
        for button in buttons {
            button.layer.cornerRadius = button.frame.size.width / 2
            button.clipsToBounds = true
            
        }
    }

}
