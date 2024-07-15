//
//  ViewController.swift
//  Contact_App
//
//  Created by DEUKRYEONG LEE on 7/15/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Called ViewController - RunApp")
    }
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ContactCellView.self, forCellReuseIdentifier: ContactCellView.identifier)
        return tableView
    }()

}
extension ViewController {
    private func configure() {
        tableView.rowHeight = 80

        
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
//        let phoneBookVC = PhoneBookViewController()
//        navigationController?.pushViewController(phoneBookVC, animated: true)
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
    }
}

