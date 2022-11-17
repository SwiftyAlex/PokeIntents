//
//  LocalDataSource.swift
//  PokéIntents
//
//  Created by Alex Logan on 14/11/2022.
//

import Foundation
import Combine

/// To avoid hitting an API, LocalDataSource wraps around `pokemon-db.json`
/// This data comes from pokeapi.co, and can be re-created with the query in the readme.
/// It consists of the first 151 pokemon, their move names and their sprites.
class LocalDataSource: DataSource {
    private let bundle: Bundle
    private let fileManager: FileManager
    private let decoder: JSONDecoder
    private let mapper: PokemonMapper

    private var database: PokemonDatabase?

    var pokemon: CurrentValueSubject<[Pokemon], Never> = .init([])

    init(
        bundle: Bundle = Bundle.main,
        fileManager: FileManager = FileManager(),
        decoder: JSONDecoder = JSONDecoder(),
        favouritesStore: FavouritesStore = .init()
    ) {
        self.bundle = bundle
        self.fileManager = fileManager
        self.decoder = decoder
        self.mapper = PokemonMapper(favouritesStore: favouritesStore)

        reload()
    }

    func loadDatabaseFromFile() {
        guard
            let databasePath = bundle.path(forResource: Constants.fileName, ofType: Constants.fileExtension),
            let json = fileManager.contents(atPath: databasePath) else {
            print("Unable to load sample database")
            return
        }
        do {
            let model = try decoder.decode(PokemonDatabase.self, from: json)
            self.database = model
        } catch let error {
            print("Unable to decode due to \(error.localizedDescription)")
        }
    }

    func reload() {
        loadDatabaseFromFile()
        self.pokemon.send(
            self.database?.data.pokemonV2Pokemon.map(self.mapper.map(pokemon:)) ?? []
        )
    }
}

private extension LocalDataSource {
    enum Constants {
        static let fileName = "pokemon-db"
        static let fileExtension = "json"
    }
}
