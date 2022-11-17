//
//  FavouritePokemon.swift
//  PokéIntents
//
//  Created by Alex Logan on 14/11/2022.
//

import SwiftUI

struct FavouritePokemon: View {
    @StateObject var model: FavouritesModel

    var body: some View {
        PokeContainer {
            if model.pokemon.isEmpty {
                Text("Tap and hold on a Pokémon to favourite it.")
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.secondary)
                    .transition(.opacity)
            } else {
                ScrollView {
                    PokemonGrid(pokemon: model.pokemon)
                        .padding()
                }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: model.pokemon)
        .navigationTitle("Favourites")
    }
}

struct FavouritePokemon_Previews: PreviewProvider {
    static var previews: some View {
        FavouritePokemon(model: FavouritesModel(dataSource: LocalDataSource()))
    }
}
