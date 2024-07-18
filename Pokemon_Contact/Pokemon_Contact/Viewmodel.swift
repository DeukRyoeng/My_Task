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
    func addPokemon(_ pokemon: PokeAPI) {
        pokemonList.append(pokemon)
    }
    
    func updatePokemonName(at index: Int, with name: String) {
           guard index >= 0 && index < pokemonList.count else {
               print("인덱스가 범위를 벗어났습니다.")
               return
           }
        pokemonList[index].name.append(name)
       }
    //포켓몬의 번호 업데이트 메서드 추가

       func updatePokemonNumber(at index: Int, with number: String) {
           guard index >= 0 && index < pokemonList.count else {
               print("인덱스가 범위를 벗어났습니다.")
               return
           }
           pokemonList[index].number.append(number)
       }
    //로컬에 저장 밑 불러오기
    func saveData() {
        do {
            let encodedData = try JSONEncoder().encode(pokemonList)
            UserDefaults.standard.set(encodedData, forKey: "pokemonList")
            print("==================")
            print(pokemonList)
            print("==================")
        } catch {
            print("저장 중 에러 발생: \(error.localizedDescription)")
        }
    }
    func loadData() {
        if let savedData = UserDefaults.standard.data(forKey: "pokemonList") {
            do {
                pokemonList = try JSONDecoder().decode([PokeAPI].self, from: savedData)
            } catch {
                print("로드 중 에러 발생: \(error.localizedDescription)")
            }
        }
        
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
