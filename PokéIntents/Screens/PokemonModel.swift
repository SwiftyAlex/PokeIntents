//
//  PokemonModel.swift
//  PokéIntents
//
//  Created by Alex Logan on 15/11/2022.
//

import Foundation
import Combine
import SwiftUI

class PokedexModel: ObservableObject {
    let dataSource: DataSource

    @Published var pokemon: [Pokemon] = []
    private var cancellables: Set<AnyCancellable> = []

    init(dataSource: DataSource) {
        self.dataSource = dataSource

        dataSource.pokemon.receive(on: RunLoop.main).sink { pokemon in
            self.pokemon = pokemon
        }
        .store(in: &cancellables)
    }
}
