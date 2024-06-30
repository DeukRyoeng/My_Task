//
//  View.swift
//  CodeBase_ Calculator
//
//  Created by DEUKRYEONG LEE on 6/30/24.
//

import UIKit
import SnapKit

class CalculatorView: UIView {
    let result_Label = UILabel()
    let buttonsTitle = [
        ["7", "8", "9", "+"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "*"],
        ["AC", "0", "=", "/"]
    ]
    
    // 버튼 Dictionary 초기화
    var buttons: [String: UIButton] = [: ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup_View()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup_View() {
        result_Label.text = "0"
        result_Label.textAlignment = .right
        result_Label.font = .boldSystemFont(ofSize: 60)
        result_Label.textColor = .white
        
        addSubview(result_Label)
        
        result_Label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        let v_Stack = UIStackView()
        v_Stack.axis = .vertical
        v_Stack.distribution = .fillEqually
        v_Stack.spacing = 10
        
        for row in buttonsTitle {
            let h_Stack = UIStackView()
            h_Stack.axis = .horizontal
            h_Stack.distribution = .fillEqually
            h_Stack.spacing = 10
            
            for title in row {
                let button = UIButton()
                button.setTitle(title, for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.titleLabel?.font = .boldSystemFont(ofSize: 30)
                //buttton 색상
                if  title == "AC" ||
                    title == "=" ||
                    title == "/" ||
                    title == "+" ||
                    title == "-" ||
                    title == "*"  {
                    button.backgroundColor = UIColor.orange // 주황색 배경
                } else {
                    button.backgroundColor =
                    UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
                }
                button.layer.cornerRadius = 40
                h_Stack.addArrangedSubview(button)
                button.snp.makeConstraints {
                    $0.width.equalTo(80)
                    $0.height.equalTo(80)
                }
                buttons[title] = button // 버튼을 Dictionary에 추가
            }
            v_Stack.addArrangedSubview(h_Stack)
        }
        
        addSubview(v_Stack)
        v_Stack.snp.makeConstraints {
            $0.width.equalTo(350)
            $0.top.equalTo(result_Label.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
    }
}
