//
//  ViewController.swift
//  Pokemon_Contact
//
//  Created by DEUKRYEONG LEE on 7/11/24.
//

import UIKit
import SnapKit
class ViewController: UIViewController {

    let phoneVC = PhoneBookViewController()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ContactCellView.self, forCellReuseIdentifier: ContactCellView.identifier)
        return tableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("================================")
        print("called ViewController - Run App ")
        print("================================")
        configure()
        addSubView()
        autoLayout()
        setupNavigation()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("+++++=============================+++++")
        print("called ViewController - ViewWillAppear ")
        print("+++++=============================+++++")
        tableView.reloadData()
    }
}

extension ViewController {
    private func configure() {
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    private func addSubView() {
        view.addSubview(tableView)
    }
    private func autoLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    @objc func addBtnTapped() {
        let phoneBookVC = PhoneBookViewController()
        navigationController?.pushViewController(phoneBookVC, animated: true)

    }
    @objc func checkBtnTapped() {
        print(DataManager.shared.pokemonList)
        print(DataManager.shared.getPokemonCount())
        tableView.reloadData()
    }
}
extension ViewController {
    private func setupNavigation() {
        title = "친구 목록"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        let addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addBtnTapped))
        addButton.tintColor = UIColor.gray
        navigationItem.rightBarButtonItem = addButton
    
        let checkButton = UIBarButtonItem(title: "체크", style: .plain, target: self, action: #selector(checkBtnTapped))
        addButton.tintColor = UIColor.gray
        navigationItem.leftBarButtonItem = checkButton
    }
    
}

extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactCellView.identifier, for: indexPath) as! ContactCellView
        let items = DataManager.shared.pokemonList
        let pokemon = items[indexPath.row]
        cell.nameLabel.text = pokemon.name
        cell.image.image = UIImage(systemName: "person.circle")
        return cell
    }
}
extension ViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("select \(indexPath.row)")
        }
}
