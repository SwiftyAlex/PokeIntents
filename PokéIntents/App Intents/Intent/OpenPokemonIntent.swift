//
//  OpenPokemonIntent.swift
//  PokéIntents
//
//  Created by Alex Logan on 15/11/2022.
//

import Foundation
import AppIntents

final class OpenPokemonIntent: AppIntent {
    static var title: LocalizedStringResource = "Open a Pokémon"
    static var description: IntentDescription = IntentDescription(
        "See your Pokémon in the app.",
        categoryName: "Pokemon"
    )
    static var openAppWhenRun: Bool = true

    @Parameter(
        title: "Pokemon",
        optionsProvider: PokemonOptionProvider()
    )
    var pokemon: PokemonEntity

    init() { }
    init(pokemon: Pokemon) {
        self.pokemon = PokemonEntity(pokemon: pokemon)
    }

    @MainActor
    func perform() async throws -> some IntentResult {
        guard let localPokemon = LocalDataSource().pokemon.value.first(where: {
            $0.id == pokemon.id
        }) else {
            return .result(value: pokemon)
        }
        IntentBridge.shared.pushPokemon(pokemon: localPokemon)
        return .result(value: pokemon)
    }
}
