//
//  PokemonGrid.swift
//  PokéIntents
//
//  Created by Alex Logan on 14/11/2022.
//

import SwiftUI

struct PokemonGrid: View {
    @Environment(\.favouritesStore) var favouritesStore
    var pokemon: [Pokemon] = []

    var body: some View {
        LazyVGrid(columns: [
            GridItem(.adaptive(minimum: 100), spacing: 12)
        ], alignment: .center, spacing: 12, pinnedViews: [], content: {
            ForEach(pokemon, id: \.id) { pokemon in
                NavigationLink(value: pokemon) {
                    PokemonGridItem(pokemon: pokemon)
                }
                .id(pokemon.id)
                .favouritable(
                    pokemon: pokemon,
                    favouritesStore: favouritesStore
                )
                .transition(
                    .opacity.combined(with: .scale(scale: 0.8))
                )
            }
        })
        .buttonStyle(BasicSquishyButtonStyle())
    }
}

struct PokemonGrid_Previews: PreviewProvider {
    static var previews: some View {
        PokemonGrid(pokemon: [.manaphy])
    }
}
