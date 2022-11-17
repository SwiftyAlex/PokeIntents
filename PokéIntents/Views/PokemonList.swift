//
//  PokemonList.swift
//  PokéIntents
//
//  Created by Alex Logan on 14/11/2022.
//

import SwiftUI
import Combine

struct PokemonList: View {
    @Environment(\.favouritesStore) var favouritesStore
    var pokemon: [Pokemon] = []

    var body: some View {
        ForEach(pokemon, id: \.id) { pokemon in
            NavigationLink(value: pokemon) {
                PokemonRow(pokemon: pokemon)
            }
            .listRowBackground(Color.cbWhite)
            .id(pokemon.id)
            .favouritable(
                pokemon: pokemon,
                favouritesStore: favouritesStore
            )
        }
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList(pokemon: [.manaphy])
    }
}
