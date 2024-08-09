//
//  ViewController.swift
//  Pokemon_DrawingBook
//
//  Created by 이득령 on 8/4/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: "PokemonCell")
        collectionView.backgroundColor = .darkRed
        
        return collectionView
    }()
    
    lazy var pokeBallImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "pokemonBall")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchPokemonList()
    }
    
    private func setupUI() {
        view.backgroundColor = .mainRed
        
        view.addSubview(collectionView)
        view.addSubview(pokeBallImageView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(pokeBallImageView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        pokeBallImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(64)
            $0.size.equalTo(CGSize(width: 64, height: 64))
        }
    }
    
    private func bindViewModel() {
        viewModel.pokemonList
            .bind(to: collectionView.rx.items(cellIdentifier: "PokemonCell", cellType: PokemonCell.self)) { [weak self] index, pokemon, cell in
                self?.viewModel.fetchPokemonDetails(for: pokemon.url)
                    .subscribe(onSuccess: { detail in
                        cell.configure(with: pokemon, imageUrl: detail.sprites.frontDefault)
                    }, onFailure: { error in
                        print("Error fetching details: \(error)")
                    })
                    .disposed(by: self!.disposeBag)
            }
            .disposed(by: disposeBag)
        
        // 셀 클릭 시 인덱스 출력 및 DetailViewController로 전환
        Observable.zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(Pokemon.self))
            .subscribe(onNext: { [weak self] indexPath, pokemon in
                guard let self = self else { return }
                let id = indexPath.row + 1
                let detailViewModel = DetailViewModel()
                let detailVC = DetailViewController(pokemonId: id, viewModel: detailViewModel)
                self.navigationController?.pushViewController(detailVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
