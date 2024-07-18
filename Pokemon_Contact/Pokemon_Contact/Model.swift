//
//  Model.swift
//  Pokemon_Contact
//
//  Created by DEUKRYEONG LEE on 7/16/24.
//

import Foundation

// MARK: - PokeAPI
struct PokeAPI: Codable {
    let id: Int
    var name: String
    var number: String
    let height, weight: Int
    let sprites: Sprites

    enum CodingKeys: String, CodingKey {
        case id, name, height, weight, sprites, number
    }

    init(id: Int, name: String, number: String = "", height: Int, weight: Int, sprites: Sprites) {
        self.id = id
        self.name = name
        self.number = number
        self.height = height
        self.weight = weight
        self.sprites = sprites
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        height = try container.decode(Int.self, forKey: .height)
        weight = try container.decode(Int.self, forKey: .weight)
        sprites = try container.decode(Sprites.self, forKey: .sprites)
        number = try container.decodeIfPresent(String.self, forKey: .number) ?? ""

    }
}
// MARK: - Sprites
struct Sprites: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
