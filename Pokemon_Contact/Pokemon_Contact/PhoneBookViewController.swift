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
    
    var pokemon_Name: String?
    var pokemon_Number: String?
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
    
    @objc func doneBtnTpped(_ snnder: UIButton) {
        let number = numberField.text ?? "Not Data"
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
            print(dataManager.pokemonList)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
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

