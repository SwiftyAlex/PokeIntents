//
//  FavouritePokemonIntent.swift
//  PokéIntents
//
//  Created by Alex Logan on 15/11/2022.
//

import Foundation
import AppIntents
import SwiftUI

final class FavouritePokemonIntent: AppIntent {
    static var title: LocalizedStringResource = "Favourite a Pokémon"
    static var description: IntentDescription = IntentDescription(
        "Toggle the favourite state for a given Pokémon",
        categoryName: "Pokemon"
    )
    static var openAppWhenRun: Bool = false

    @Parameter(
        title: "Pokemon",
        optionsProvider: PokemonOptionProvider()
    )
    var pokemon: PokemonEntity

    func perform() async throws -> some IntentResult {
        guard var localPokemon = LocalDataSource().pokemon.value.first(where: {
            $0.id == pokemon.id
        }) else {
            return .result(value: pokemon, view: PokemonIntentView(pokemon: nil, image: nil))
        }

        AppContainer.favouritesStore.toggle(pokemon: localPokemon)

        localPokemon = Pokemon(
            id: localPokemon.id,
            name: localPokemon.name,
            sprites: localPokemon.sprites,
            moves: localPokemon.moves,
            favourite: AppContainer.favouritesStore.isFavourite(pokemon: localPokemon)
        )

        // Try to fetch the image if we can.
        let image: UIImage? = await PokemonImageFetcher.fetchImage(pokemon: localPokemon)
        if let imageData = image?.pngData() {
            pokemon.image = IntentFile(data: imageData, filename: "pokemon.png")
        }
        // Show a simple view.
        return .result(value: pokemon, view: PokemonIntentView(
            pokemon: localPokemon, image: image
        ))
    }
}
