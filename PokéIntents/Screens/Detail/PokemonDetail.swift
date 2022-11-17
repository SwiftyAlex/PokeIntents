//
//  Pokemonview.swift
//  PokéIntents
//
//  Created by Alex Logan on 14/11/2022.
//

import SwiftUI
import AppIntents
import Intents
import IntentsUI

struct PokemonDetail: View {
    let pokemon: Pokemon

    var body: some View {
        PokeContainer {
            List {
                Section("Sprites") {
                    SpritesGrid(sprites: pokemon.sprites)
                        .listRowBackground(Color.cbWhite)
                }
                
                Section {
                    NavigationLink(destination: {
                        MovesList(moves: pokemon.moves)
                    }, label: {
                        Text("Moves")
                    })
                    .listRowBackground(Color.cbWhite)
                }

                SiriTipView(intent: OpenPokemonIntent(
                    pokemon: pokemon
                ))
                .siriTipViewStyle(.dark)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            }
            .scrollContentBackground(.hidden)
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle(pokemon.name)
        .onAppear {
            Task {
                do {
                    try await OpenPokemonIntent(pokemon: pokemon).donate()
                } catch let error {
                    print("Unable to donate due to \(error.localizedDescription)")
                }
            }
        }
    }
}

struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail(pokemon: .manaphy)
    }
}
