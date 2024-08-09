//
//  CustomCollectonCell.swift
//  Pokemon_DrawingBook
//
//  Created by 이득령 on 8/4/24.
//

import UIKit
import SnapKit

class PokemonCell: UICollectionViewCell {
    
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(pokemonImageView)
        pokemonImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        }
    }
    
    func configure(with pokemon: Pokemon, imageUrl: String) {
        fetchImage(from: imageUrl)
    }
    
    private func fetchImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.pokemonImageView.image = UIImage(data: data)
            }
        }
        task.resume()
    }
}
