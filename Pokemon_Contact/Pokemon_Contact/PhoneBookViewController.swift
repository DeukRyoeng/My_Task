//
//  PhoneBookViewController.swift
//  Pokemon_Contact
//
//  Created by DEUKRYEONG LEE on 7/12/24.
//

import UIKit
import SnapKit
import AnyFormatKit

class PhoneBookViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        setupNavigation()
        view.backgroundColor = .white

        
    }
    
    let image:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "imageSP")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 90
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.gray.cgColor
        return  imageView
        
    }()
    
    let randomButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤이미지 변경", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitleColor(.gray,for: .normal)
        return button
    }()
    
    let nameField: UITextField = {
        let field = UITextField()
        field.placeholder = "이름을 입력해주세요."
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let numberField: UITextField = {
        let field = UITextField()
        field.placeholder = "전화번호를 입력해주세요."
        field.borderStyle = .roundedRect
        field.keyboardType = .numberPad
        
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    @objc func randomBtnTapped(_ sender: UIButton) {
    }
    
    @objc func doneBtnTpped(_ snnder: UIButton) {
        print("적용 버튼")
       
        //self.navigationController?.popViewController(animated: true)
        

    }
}

extension PhoneBookViewController {
    private func addSubView() {
        [randomButton, image, nameField, numberField].forEach({view.addSubview($0)})
        self.randomButton.addTarget(self, action: #selector(randomBtnTapped(_: )), for: .touchUpInside)
        image.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.size.width.height.equalTo(180)
            $0.top.equalTo(130)
        }
        randomButton.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        nameField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.trailing.equalTo(-20)
            $0.leading.equalTo(20)
            $0.height.equalTo(40)
            $0.top.equalTo(randomButton.snp.bottom).offset(30)
        }
        numberField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.trailing.equalTo(-20)
            $0.leading.equalTo(20)
            $0.height.equalTo(40)
            $0.top.equalTo(nameField.snp.bottom).offset(10)
        }
    }
    private func setupNavigation() {
        title = "연락처 추가"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ]
        let addButton = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(doneBtnTpped(_ :)))
        addButton.tintColor = UIColor.gray
        navigationItem.rightBarButtonItem = addButton
        
    }
    
}
//
//extension PhoneBookViewController: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        
//        guard let text = numberField.text else {
//            return false
//        }
//        let characterSet = CharacterSet(charactersIn: string)
//        if CharacterSet.decimalDigits.isSuperset(of: characterSet) == false {
//            return false
//        }
//        
//        let formatter = DefaultTextInputFormatter(textPattern: "###-####-####")
//        let result = formatter.formatInput(currentText: text, range: range, replacementString: string)
//        textField.text = result.formattedText
//        let position = textField.position(from: textField.beginningOfDocument, offset: result.caretBeginOffset)!
//        textField.selectedTextRange = textField.textRange(from: position, to: position)
//        return false
//    }
//}
//
