//
//  Pokemon.swift
//  PokéIntents
//
//  Created by Alex Logan on 14/11/2022.
//

import Foundation

class Pokemon: Hashable, Equatable {
    let id: Int
    let name: String
    let sprites: [Sprite]
    let moves: [Move]
    let favourite: Bool

    struct Move: Equatable, Hashable {
        let name: String
    }

    struct Sprite: Equatable, Hashable {
        let name: String
        let url: String
    }

    internal init(id: Int, name: String, sprites: [Pokemon.Sprite], moves: [Pokemon.Move], favourite: Bool) {
        self.id = id
        self.name = name
        self.sprites = sprites
        self.moves = moves
        self.favourite = favourite
    }

    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id == rhs.id
        && lhs.favourite == rhs.favourite
        && lhs.name == rhs.name
        && lhs.sprites == rhs.sprites
        && lhs.moves == rhs.moves
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    // MARK: - Convenience
    var primarySprite: Pokemon.Sprite? {
        sprites.first(where: { $0.name == "front_default" }) ?? sprites.first
    }
}


// MARK: - Test/Preview Helper
extension Pokemon {
    static let manaphy = Pokemon(
        id: 490,
        name: "Manaphy",
        sprites: [
            Pokemon.Sprite(
                name: "Front",
                url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/490.png"
            ),
            Pokemon.Sprite(
                name: "Back",
                url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/490.png"
            )
        ],
        moves: [
            Pokemon.Move(name: "Supersonic"),
            Pokemon.Move(name: "Surf")
        ],
        favourite: false
    )
}
