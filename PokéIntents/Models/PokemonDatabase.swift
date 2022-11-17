//
//  Models.swift
//  PokéIntents
//
//  Created by Alex Logan on 14/11/2022.
//

import Foundation

// This was generated using QuickType.io
// MARK: - PokemonDatabase
struct PokemonDatabase: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let pokemonV2Pokemon: [PokemonV2Pokemon]

    enum CodingKeys: String, CodingKey {
        case pokemonV2Pokemon = "pokemon_v2_pokemon"
    }
}

// MARK: - PokemonV2Pokemon
struct PokemonV2Pokemon: Codable {
    let id: Int
    let name: String
    let pokemonV2Pokemonsprites: [PokemonV2Pokemonsprite]
    let pokemonV2Pokemonmoves: [PokemonV2Pokemonmove]

    enum CodingKeys: String, CodingKey {
        case id, name
        case pokemonV2Pokemonsprites = "pokemon_v2_pokemonsprites"
        case pokemonV2Pokemonmoves = "pokemon_v2_pokemonmoves"
    }
}

// MARK: - PokemonV2Pokemonmove
struct PokemonV2Pokemonmove: Codable {
    let pokemonV2Move: PokemonV2Move

    enum CodingKeys: String, CodingKey {
        case pokemonV2Move = "pokemon_v2_move"
    }
}

// MARK: - PokemonV2Move
struct PokemonV2Move: Codable {
    let name: String
}

// MARK: - PokemonV2Pokemonsprite
struct PokemonV2Pokemonsprite: Codable {
    let sprites: String
}
