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
    
    let dataManager = DataManager.shared
    let state = DataManager.shared.state
    
    //TableView에서 선택된 index값 저장
    var pokemonIndex: Int?
    var pokemon: PokeAPI?
    var pokemon_Name: String?
    var pokemon_Number: String?
    var name: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        setupNavigation()
        view.backgroundColor = .white
        numberField.delegate = self
        configureView()
        name = nameField.text ?? "연락처 추가"

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
        let random = Int.random(in: 1...1000)
        DataManager.shared.fetchPokemonData(pokemonID: random) { result in
            switch result {
            case .success(let pokemon):
                //UIupdate는 메인스레드에서 진행
                DispatchQueue.main.async { [self] in
                    dataManager.addPokemon(pokemon)
                    self.setImage(from: pokemon.sprites.frontDefault)
                    self.nameField.text = pokemon.name
                    self.pokemon_Name = pokemon.name
                }
            case .failure(let err):
                print("ERROR!! - \(err)")
            }
        }
    }
//MARK: - 추가, 적용 버튼
    @objc func doneBtnTpped(_ snnder: UIButton) {
        if state {
            // True 일때
            guard let pokemonIndex = pokemonIndex,
                  let upDateName = nameField.text,
                  let upDateNumber = numberField.text  else { return }
            
            dataManager.updatePokemonName(at: pokemonIndex, with: upDateName)
            dataManager.updatePokemonNumber(at: pokemonIndex, with: upDateNumber)
            dataManager.saveData()
            
        } else {
            //false 일때
            let number = numberField.text ?? ""
            guard let number = numberField.text, !number.isEmpty else {
                print("전화번호가 입력되지 않았습니다.")
                return
            }
            self.pokemon_Number = number
            let lastIndex = dataManager.getPokemonCount() - 1
            if lastIndex >= 0, let name = self.pokemon_Name, let number = self.pokemon_Number {
                dataManager.updatePokemonName(at: lastIndex, with: name)
                dataManager.updatePokemonNumber(at: lastIndex, with: number)
                dataManager.saveData()
            }
        }
        self.navigationController?.popViewController(animated: true)
    }// done BTN
}

extension PhoneBookViewController {
    private func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image.image = image
                    }
                }
            }
        }
    }
    
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
//MARK: - 네이게이션 관련
    private func setupNavigation() {
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ]
        //삼항 연사자로 짧게 단축
        let titleLabel: String = state ? "적용" : "추가"
        let addButton = UIBarButtonItem(title: "연락처 추가", style: .plain, target: self, action: #selector(doneBtnTpped(_ :)))
        addButton.tintColor = UIColor.gray
        navigationItem.rightBarButtonItem = addButton
        
    }
    
//MARK: - UI Update 관련
    private func configureView() {
        guard let pokemon = pokemon else { return }
        nameField.text = pokemon.name
        numberField.text = pokemon.number
        if let url = URL(string: pokemon.sprites.frontDefault) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.image.image = image
                        }
                    }
                }
            }
        }
    }
    
}

//MARK: - 전화번호 형식으로 포맷
extension PhoneBookViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //NumberField에만 적용
        guard let text = numberField.text else {
            return false
        }
        let characterSet = CharacterSet(charactersIn: string)
        if CharacterSet.decimalDigits.isSuperset(of: characterSet) == false {
            return false
        }
        
        let formatter = DefaultTextInputFormatter(textPattern: "###-####-####")
        let result = formatter.formatInput(currentText: text, range: range, replacementString: string)
        textField.text = result.formattedText
        let position = textField.position(from: textField.beginningOfDocument, offset: result.caretBeginOffset)!
        textField.selectedTextRange = textField.textRange(from: position, to: position)
        return false
    }
}
