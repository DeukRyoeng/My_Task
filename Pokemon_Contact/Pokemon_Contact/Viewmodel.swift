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
    //포켓몬의 이름 업데이트 메서드
    func updatePokemonName(at index: Int, with name: String) {
           guard index >= 0 && index < pokemonList.count else {
               print("인덱스가 범위를 벗어났습니다.")
               return
           }
        pokemonList[index].name = name
    }
    //포켓몬의 번호 업데이트 메서드

       func updatePokemonNumber(at index: Int, with number: String) {
           guard index >= 0 && index < pokemonList.count else {
               print("인덱스가 범위를 벗어났습니다.")
               return
           }
           pokemonList[index].number = number
       }
    // 이름순으로 포켓몬 리스트를 정렬하는 메서드 추가
       func sortPokemonListByName() {
           pokemonList.sort { $0.name < $1.name }
           print(pokemonList)
       }
    
    //로컬에 저장 밑 불러오기
    func saveData() {
        do {
            let encodedData = try JSONEncoder().encode(pokemonList)
            UserDefaults.standard.set(encodedData, forKey: "pokemonList")
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
