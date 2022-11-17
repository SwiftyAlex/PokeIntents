//
//  Pokédex.swift
//  PokéIntents
//
//  Created by Alex Logan on 14/11/2022.
//

import SwiftUI

struct Pokedex: View {
    @StateObject var model: PokedexModel

    var body: some View {
        PokeContainer {
            // Future feature: searchable
            List {
                PokemonList(pokemon: model.pokemon)
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Intent Monsters")
        }
    }
}

struct Pokedex_Previews: PreviewProvider {
    static var previews: some View {
        Pokedex(model: .init(dataSource: LocalDataSource()))
    }
}
