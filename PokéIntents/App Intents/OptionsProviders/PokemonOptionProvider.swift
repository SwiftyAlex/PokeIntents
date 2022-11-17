//
//  PokemonOptionProvider.swift
//  PokéIntents
//
//  Created by Alex Logan on 15/11/2022.
//

import Foundation
import AppIntents

class PokemonOptionProvider: DynamicOptionsProvider {
    typealias Result = [PokemonEntity]

    func results() async throws -> [PokemonEntity] {
        let database = LocalDataSource()
        return database.pokemon.value.map(PokemonEntity.init(pokemon:))
    }
}
