//
//  FavouritesStore.swift
//  PokéIntents
//
//  Created by Alex Logan on 15/11/2022.
//

import Foundation

class FavouritesStore: ObservableObject {
    private let ubiquitousStore: NSUbiquitousKeyValueStore

    @Published var favourites: [Int] = []

    init(ubiquitousStore: NSUbiquitousKeyValueStore = .default) {
        self.ubiquitousStore = ubiquitousStore
        favourites = existingFavourites()
    }

    func isFavourite(pokemonId: Int) -> Bool {
        existingFavourites().contains(pokemonId)
    }

    func isFavourite(pokemon: Pokemon) -> Bool {
        existingFavourites().contains(where: { $0 == pokemon.id })
    }

    func toggle(pokemon: Pokemon) {
        var mutableFavourites = existingFavourites()

        if mutableFavourites.contains(pokemon.id) {
            mutableFavourites.removeAll(where: { $0 == pokemon.id })
        } else {
            mutableFavourites.append(pokemon.id)
        }

        storeFavourites(favourites: mutableFavourites)
    }
}

private extension FavouritesStore {
    func existingFavourites() -> [Int] {
        ubiquitousStore.array(forKey: Constants.key) as? [Int] ?? []
    }

    func storeFavourites(favourites: [Int]) {
        ubiquitousStore.set(favourites, forKey: Constants.key)
        DispatchQueue.main.async {
            self.favourites = favourites
        }
    }

    enum Constants {
        static let key = "favourites_key"
    }
}
