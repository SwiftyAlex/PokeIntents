//
//  ContentView.swift
//  PokéIntents
//
//  Created by Alex Logan on 14/11/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.dataSource) var dataSource
    @State var navigationPath: NavigationPath = .init()
    @State var secondaryPath: NavigationPath = .init()
    @State var selectedTab: Int = 0

    @StateObject var model: ContentModel
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack(path: $navigationPath) {
                Pokedex(model: PokedexModel(dataSource: dataSource))
                    .applyPokemonDestination()
            }
            .tabItem {
                Label("Pokemon", systemImage: "leaf.fill")
            }
            .tag(0)
            NavigationStack(path: $secondaryPath) {
                FavouritePokemon(model: FavouritesModel(dataSource: dataSource))
                    .applyPokemonDestination()
            }
            .tabItem {
                Label("Favourites", systemImage: "star")
            }
            .tag(1)
        }
        .onChange(of: model.destinations) { destinations in
            if let nextDestination = destinations.first {
                switch nextDestination {
                case .pokemon(let pokemon):
                    secondaryPath.removeLast(navigationPath.count)
                    selectedTab = 0
                    navigationPath.append(pokemon)
                case .favourites:
                    navigationPath.removeLast(navigationPath.count)
                    secondaryPath.removeLast(navigationPath.count)
                    selectedTab = 1
                }
                model.consume(destination: nextDestination)
            }
        }
    }
}

private extension View {
    func applyPokemonDestination() -> some View {
        self.navigationDestination(for: Pokemon.self) { pokemon in
            PokemonDetail(pokemon: pokemon)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: ContentModel(intentBridge: .shared))
    }
}
