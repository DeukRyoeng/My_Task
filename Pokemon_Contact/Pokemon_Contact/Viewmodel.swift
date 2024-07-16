//
//  Viewmodel.swift
//  Pokemon_Contact
//
//  Created by DEUKRYEONG LEE on 7/16/24.
//

import Foundation
import UIKit

class DataManager {
    //싱글톤 패턴 전역변수로 선언
    static let shared = DataManager()
    private init() {}
    
    //데이터를 담을 빈 배열 생성
    var pokemonList:[PokeAPI] = []
    
    //앱 내부에서 동작할 메서드
    
    func getPokemonCount() -> Int {
        return pokemonList.count
    }
    func sendData() {
        let sprite = Sprites(frontDefault: "https://example.com/sprite.png")

        pokemonList = [
            PokeAPI(id: 1, name: "tset", height: 1, weight: 1, sprites: sprite)
        ]
    }
    
    func addPokemon(_ pokemon: PokeAPI) {
        pokemonList.append(pokemon)
    }
    
    func fetchPokemonData(pokemonID: Int, completion: @escaping (Result<PokeAPI, Error>) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(pokemonID)/"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                let pokemonData = try JSONDecoder().decode(PokeAPI.self, from: data)
                completion(.success(pokemonData))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

}
