//
//  DetailViewModel.swift
//  Pokemon_DrawingBook
//
//  Created by 이득령 on 8/7/24.
//

import Foundation
import RxSwift

class DetailViewModel {
    
    private let networkManager: NetworkManager
    let pokemonDetails = PublishSubject<PokemonDetails>()
    private let disposeBag = DisposeBag()
    
    init(networkManager: NetworkManager = .shared) {
        self.networkManager = networkManager
    }
        
        func fetchPokemonDetails(pokemonId: Int) -> Single<PokemonDetail> {
            let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonId)/")!
            return networkManager.fetch(url: url)
        }

    
    func fetchPokemonDetails(for id: Int) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/")!
        
        networkManager.fetch(url: url)
            .subscribe(onSuccess: { [weak self] (details: PokemonDetails) in
                self?.pokemonDetails.onNext(details)
            }, onFailure: { error in
                print("Error fetching details: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
