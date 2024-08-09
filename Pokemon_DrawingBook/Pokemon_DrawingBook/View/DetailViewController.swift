//
//  DetailViewController.swift
//  Pokemon_DrawingBook
//
//  Created by 이득령 on 8/7/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    
    private let viewModel: DetailViewModel
    private let pokemonId: Int
    private let disposeBag = DisposeBag()
    
    private let     pokemonName_Label = UILabel()
    private let poke_ID_Label = UILabel()
    private let typeLabel = UILabel()
    private let heightLabel = UILabel()
    private let weightLabel = UILabel()
    private let imageView = UIImageView()
    
    init(pokemonId: Int, viewModel: DetailViewModel) {
        self.pokemonId = pokemonId
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchDetails()
    }
    
    private func setupUI() {
        view.backgroundColor = .mainRed
        
        let stackView = UIStackView(arrangedSubviews: [heightLabel, weightLabel])
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        
        
        poke_ID_Label.font = .boldSystemFont(ofSize: 30)
        poke_ID_Label.textColor = .white
        pokemonName_Label.font = .systemFont(ofSize: 30)
        pokemonName_Label.textColor = .white
        
        heightLabel.textColor = .white
        weightLabel.textColor = .white
        typeLabel.textColor = .white
        
        view.addSubview(pokemonName_Label)
        view.addSubview(poke_ID_Label)
        view.addSubview(stackView)
        view.addSubview(imageView)
        
        poke_ID_Label.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).inset(15)
            $0.leading.equalTo(110)
        }
        
        pokemonName_Label.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).inset(15)
            $0.trailing.equalTo(-90)
        }
    
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(30)
            $0.trailing.equalTo(-30)
        }
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(200)
            $0.top.equalTo(130)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func fetchDetails() {
        viewModel.fetchPokemonDetails(pokemonId: pokemonId)
            .subscribe(onSuccess: { [weak self] detail in
                guard let self = self else { return }
                DispatchQueue.main.sync {
                    self.poke_ID_Label.text = "No.\(self.pokemonId)"
                    self.pokemonName_Label.text = "\(detail.name.capitalized)"
                    self.heightLabel.text = "키: \(detail.height)"
                    self.weightLabel.text = "무게: \(detail.weight)"
                }
                self.loadImage(from: detail.sprites.frontDefault)
            }, onFailure: { error in
                print("Error fetching details: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
}
