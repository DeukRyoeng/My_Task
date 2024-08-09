//
//  Model.swift
//  Pokemon_DrawingBook
//
//  Created by 이득령 on 8/4/24.
//

import Foundation

struct PokemonList: Decodable {
    let results: [Pokemon]
}

struct Pokemon: Decodable {
    let name: String
    let url: String
}

struct PokemonDetail: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [PokeTypes]
    let sprites: Sprite
}

struct PokeTypes: Codable {
    let type: PokeType?
}

struct PokeType: Codable {
    let name: String?
}


struct Sprite: Decodable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct PokemonDetails: Decodable {
    let name: String
    let height: Int
    let weight: Int
    let types: [TypeElement]
    
    struct TypeElement: Decodable {
        let type: TypeName
    }
    
    struct TypeName: Decodable {
        let name: String
    }
}
