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
    let name: String
    let height, weight: Int
    let sprites: Sprites
}

// MARK: - Sprites
struct Sprites: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
