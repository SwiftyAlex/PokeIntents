//
//  ViewPokemonIntent.swift
//  PokéIntents
//
//  Created by Alex Logan on 15/11/2022.
//

import Foundation
import AppIntents
import SwiftUI

final class ViewPokemonIntent: AppIntent {
    static var title: LocalizedStringResource = "Look at a Pokémon"
    static var description: IntentDescription = IntentDescription(
        "See a little preview of your chosen Pokémon",
        categoryName: "Pokemon"
    )
    static var openAppWhenRun: Bool = false

    @Parameter(
        title: "Pokemon",
        optionsProvider: PokemonOptionProvider()
    )
    var pokemon: PokemonEntity

    @MainActor
    func perform() async throws -> some IntentResult {
        guard let localPokemon = LocalDataSource().pokemon.value.first(where: {
            $0.id == pokemon.id
        }) else {
            return .result(value: pokemon, view: PokemonIntentView(pokemon: nil, image: nil))
        }
        // Try to fetch the image if we can.
        let image: UIImage? = await PokemonImageFetcher.fetchImage(pokemon: localPokemon)
        if let imageData = image?.pngData() {
            pokemon.image = IntentFile(data: imageData, filename: "pokemon.png")
        }
        // Show a simple view.
        return .result(value: pokemon, view: PokemonIntentView(pokemon: localPokemon, image: image))
    }
}
