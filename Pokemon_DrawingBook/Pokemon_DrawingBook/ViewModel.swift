//
//  ViewModel.swift
//  Pokemon_DrawingBook
//
//  Created by 이득령 on 8/4/24.
//

import Foundation
import RxSwift

class ViewModel {
    private let networkManager = NetworkManager.shared
    private let disposeBag = DisposeBag()
    
    let pokemonList = PublishSubject<[Pokemon]>()
    
    func fetchPokemonList(limit: Int = 20, offset: Int = 0) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)")!
        networkManager.fetch(url: url)
            .map { (pokemonList: PokemonList) in
                return pokemonList.results
            }
            .subscribe(onSuccess: { [weak self] pokemons in
                self?.pokemonList.onNext(pokemons)
            }, onFailure: { error in
                print("Error: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    func fetchPokemonDetails(for urlString: String) -> Single<PokemonDetail> {
        guard let url = URL(string: urlString) else {
            return Single.error(NSError(domain: "Invalid URL", code: -1, userInfo: nil))
        }
        return networkManager.fetch(url: url)
    }
}

