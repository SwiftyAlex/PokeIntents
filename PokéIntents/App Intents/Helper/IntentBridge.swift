//
//  IntentBridge.swift
//  PokéIntents
//
//  Created by Alex Logan on 15/11/2022.
//

import Foundation

class IntentBridge: ObservableObject {
    static let shared = IntentBridge()
    
    @Published var destinations: Set<IntentDestination> = []

    func pushPokemon(pokemon: Pokemon) {
        DispatchQueue.main.async {
            self.destinations.insert(.pokemon(pokemon: pokemon))
        }
    }

    func openFavourites() {
        self.destinations.insert(.favourites)
    }
}

enum IntentDestination: Equatable, Hashable {
    case pokemon(pokemon: Pokemon)
    case favourites
}
